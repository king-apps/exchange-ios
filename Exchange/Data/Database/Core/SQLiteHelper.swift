import Foundation
import SQLite3


enum SQLiteValue: Equatable {
    case null
    case integer(Int64)
    case double(Double)
    case text(String)
    case blob(Data)
    case bool(Bool)
}


struct SQLiteRow {
    let values: [String: SQLiteValue]
    
    subscript(_ column: String) -> SQLiteValue? {
        values[column]
    }
    
    func string(_ column: String) -> String? {
        guard case .text(let value) = values[column] else { return nil }
        return value
    }
    
    func int(_ column: String) -> Int? {
        guard case .integer(let value) = values[column] else { return nil }
        return Int(value)
    }
    
    func int64(_ column: String) -> Int64? {
        guard case .integer(let value) = values[column] else { return nil }
        return value
    }
    
    func double(_ column: String) -> Double? {
        switch values[column] {
        case .double(let value):
            return value
        case .integer(let value):
            return Double(value)
        default:
            return nil
        }
    }
    
    func bool(_ column: String) -> Bool? {
        switch values[column] {
        case .bool(let value):
            return value
        case .integer(let value):
            return value != 0
        default:
            return nil
        }
    }
    
    func data(_ column: String) -> Data? {
        guard case .blob(let value) = values[column] else { return nil }
        return value
    }
}


final class SQLiteHelper {
    
    enum Location {
        case documents
        case caches
        case temporary
        case url(URL)
    }
    
    enum SQLiteHelperError: LocalizedError {
        case openFailed(String)
        case prepareFailed(String)
        case bindFailed(String)
        case executeFailed(String)
        case invalidDatabaseURL
        
        var errorDescription: String? {
            switch self {
            case .openFailed(let message):
                return "Failed to open SQLite database. \(message)"
            case .prepareFailed(let message):
                return "Failed to prepare SQLite statement. \(message)"
            case .bindFailed(let message):
                return "Failed to bind SQLite value. \(message)"
            case .executeFailed(let message):
                return "Failed to execute SQLite statement. \(message)"
            case .invalidDatabaseURL:
                return "Invalid SQLite database URL."
            }
        }
    }
    
    let url: URL
    private var database: OpaquePointer?
    private let lock = NSRecursiveLock()
    
    convenience init(name: String, location: Location = .documents) throws {
        let fileName = URL(fileURLWithPath: name).pathExtension.isEmpty ? "\(name).sqlite" : name
        try self.init(url: Self.databaseURL(fileName: fileName, location: location))
    }
    
    convenience init(bundleResource resource: String, withExtension fileExtension: String, location: Location = .documents) throws {
        let fileName = "\(resource).\(fileExtension)"
        let url = try Self.bundledDatabaseURL(
            resource: resource,
            withExtension: fileExtension,
            fileName: fileName,
            location: location
        )
        try self.init(url: url)
    }
    
    init(url: URL) throws {
        self.url = url
        try Self.createDirectoryIfNeeded(for: url)
        try open()
        try execute("PRAGMA foreign_keys = ON")
    }
    
    deinit {
        close()
    }
    
    @discardableResult
    func execute(_ sql: String, parameters: [SQLiteValue] = []) throws -> Int {
        try lock.perform {
            var statement: OpaquePointer?
            defer { sqlite3_finalize(statement) }
            
            try prepare(sql, statement: &statement)
            try bind(parameters, to: statement)
            
            guard sqlite3_step(statement) == SQLITE_DONE else {
                throw SQLiteHelperError.executeFailed(lastErrorMessage)
            }
            
            return Int(sqlite3_changes(database))
        }
    }
    
    func query(_ sql: String, parameters: [SQLiteValue] = []) throws -> [SQLiteRow] {
        try lock.perform {
            var statement: OpaquePointer?
            defer { sqlite3_finalize(statement) }
            
            try prepare(sql, statement: &statement)
            try bind(parameters, to: statement)
            
            var rows: [SQLiteRow] = []
            var stepResult = sqlite3_step(statement)
            
            while stepResult == SQLITE_ROW {
                rows.append(row(from: statement))
                stepResult = sqlite3_step(statement)
            }
            
            guard stepResult == SQLITE_DONE else {
                throw SQLiteHelperError.executeFailed(lastErrorMessage)
            }
            
            return rows
        }
    }
    
    func transaction(_ changes: () throws -> Void) throws {
        try lock.perform {
            try execute("BEGIN TRANSACTION")
            
            do {
                try changes()
                try execute("COMMIT")
            } catch {
                _ = try? execute("ROLLBACK")
                throw error
            }
        }
    }
    
    func lastInsertedRowID() -> Int64 {
        lock.perform {
            sqlite3_last_insert_rowid(database)
        }
    }
    
    func close() {
        lock.perform {
            guard database != nil else { return }
            sqlite3_close(database)
            database = nil
        }
    }
    
    static func databaseURL(fileName: String, location: Location = .documents) throws -> URL {
        switch location {
        case .documents:
            return try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            ).appendingPathComponent(fileName)
        case .caches:
            return try FileManager.default.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            ).appendingPathComponent(fileName)
        case .temporary:
            return FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        case .url(let url):
            return url
        }
    }
    
    static func bundledDatabaseURL(
        resource: String,
        withExtension fileExtension: String,
        fileName: String? = nil,
        location: Location = .documents
    ) throws -> URL {
        let fileManager = FileManager.default
        let localURL = try databaseURL(
            fileName: fileName ?? "\(resource).\(fileExtension)",
            location: location
        )
        
        guard fileManager.fileExists(atPath: localURL.path) == false else {
            return localURL
        }
        
        guard let bundleURL = Bundle.main.url(forResource: resource, withExtension: fileExtension) else {
            return localURL
        }
        
        try fileManager.copyItem(at: bundleURL, to: localURL)
        return localURL
    }
    
    private func open() throws {
        let flags = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE | SQLITE_OPEN_FULLMUTEX
        guard sqlite3_open_v2(url.path, &database, flags, nil) == SQLITE_OK else {
            let message = lastErrorMessage
            sqlite3_close(database)
            database = nil
            throw SQLiteHelperError.openFailed(message)
        }
        
        print("[SQLiteHelper] Database path: \(url.path)")
        print("[SQLiteHelper] Finder command: open -R \"\(url.path)\"")
    }
    
    private func prepare(_ sql: String, statement: inout OpaquePointer?) throws {
        guard sqlite3_prepare_v2(database, sql, -1, &statement, nil) == SQLITE_OK else {
            throw SQLiteHelperError.prepareFailed(lastErrorMessage)
        }
    }
    
    private func bind(_ parameters: [SQLiteValue], to statement: OpaquePointer?) throws {
        for (index, parameter) in parameters.enumerated() {
            let position = Int32(index + 1)
            let result: Int32
            
            switch parameter {
            case .null:
                result = sqlite3_bind_null(statement, position)
            case .integer(let value):
                result = sqlite3_bind_int64(statement, position, value)
            case .double(let value):
                result = sqlite3_bind_double(statement, position, value)
            case .text(let value):
                result = sqlite3_bind_text(statement, position, value, -1, Self.transientDestructor)
            case .blob(let data):
                result = data.withUnsafeBytes { bytes in
                    sqlite3_bind_blob(statement, position, bytes.baseAddress, Int32(data.count), Self.transientDestructor)
                }
            case .bool(let value):
                result = sqlite3_bind_int(statement, position, value ? 1 : 0)
            }
            
            guard result == SQLITE_OK else {
                throw SQLiteHelperError.bindFailed(lastErrorMessage)
            }
        }
    }
    
    private func row(from statement: OpaquePointer?) -> SQLiteRow {
        var values: [String: SQLiteValue] = [:]
        let columnCount = sqlite3_column_count(statement)
        
        for index in 0..<columnCount {
            guard let columnName = sqlite3_column_name(statement, index) else { continue }
            values[String(cString: columnName)] = value(from: statement, column: index)
        }
        
        return SQLiteRow(values: values)
    }
    
    private func value(from statement: OpaquePointer?, column: Int32) -> SQLiteValue {
        switch sqlite3_column_type(statement, column) {
        case SQLITE_INTEGER:
            return .integer(sqlite3_column_int64(statement, column))
        case SQLITE_FLOAT:
            return .double(sqlite3_column_double(statement, column))
        case SQLITE_TEXT:
            guard let text = sqlite3_column_text(statement, column) else { return .null }
            return .text(String(cString: text))
        case SQLITE_BLOB:
            let byteCount = Int(sqlite3_column_bytes(statement, column))
            guard byteCount > 0, let bytes = sqlite3_column_blob(statement, column) else {
                return .blob(Data())
            }
            return .blob(Data(bytes: bytes, count: byteCount))
        default:
            return .null
        }
    }
    
    private var lastErrorMessage: String {
        guard let message = sqlite3_errmsg(database) else {
            return "Unknown SQLite error."
        }
        return String(cString: message)
    }
    
    private static var transientDestructor: sqlite3_destructor_type {
        unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    }
    
    private static func createDirectoryIfNeeded(for url: URL) throws {
        let directoryURL = url.deletingLastPathComponent()
        guard directoryURL.path.isEmpty == false else {
            throw SQLiteHelperError.invalidDatabaseURL
        }
        try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
    }
}


private extension NSRecursiveLock {
    func perform<T>(_ work: () throws -> T) rethrows -> T {
        lock()
        defer { unlock() }
        return try work()
    }
}
