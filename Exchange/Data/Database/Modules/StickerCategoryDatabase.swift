import Foundation


class StickerCategoryDatabase {
    
    private enum Table {
        static let raw = "category"
        
        static let id = "id"
        static let code = "code"
        static let color = "color"
        static let name = "name"
        static let logo = "logo"
        static let coverUrl = "cover_url"
    }
    
    // Var's
    private let db: SQLiteHelper
    
    
    // Construct
    init() throws {
        db = try SQLiteHelper(bundleResource: "stickers", withExtension: "db")
    }
    
    
    // Actions
    func get(id: Int?) throws -> ProductCategory? {
        guard let id else { return nil }
        return try list(ids: [id]).first
    }
    
    func list(ids: [Int]? = nil) throws -> [ProductCategory] {
        var sql = """
        SELECT
            \(Table.id),
            \(Table.code),
            \(Table.color),
            \(Table.name),
            \(Table.logo),
            \(Table.coverUrl)
        FROM \(Table.raw)
        """
        var parameters: [SQLiteValue] = []
        
        if let ids {
            guard ids.isEmpty == false else { return [] }
            
            let placeholders = ids.map { _ in "?" }.joined(separator: ", ")
            sql += " WHERE \(Table.id) IN (\(placeholders))"
            parameters = ids.map { .integer(Int64($0)) }
        }
        
        sql += " ORDER BY \(Table.code)"
        
        return try db
            .query(sql, parameters: parameters)
            .map(mapCategory)
    }
    
    @discardableResult
    func insert(_ category: ProductCategory) throws -> Int {
        try db.execute(
            """
            INSERT INTO \(Table.raw) (
                \(Table.id),
                \(Table.code),
                \(Table.color),
                \(Table.name),
                \(Table.logo),
                \(Table.coverUrl)
            ) VALUES (?, ?, ?, ?, ?, ?)
            """,
            parameters: values(for: category)
        )
    }
    
    @discardableResult
    func update(_ category: ProductCategory) throws -> Int {
        try db.execute(
            """
            UPDATE \(Table.raw)
            SET
                \(Table.code) = ?,
                \(Table.color) = ?,
                \(Table.name) = ?,
                \(Table.logo) = ?,
                \(Table.coverUrl) = ?
            WHERE \(Table.id) = ?
            """,
            parameters: [
                .text(category.getCode()),
                .text(category.getColor()),
                .text(category.getName()),
                .text(category.getLogo()),
                .text(category.getCoverUrl()),
                .integer(Int64(category.getId()))
            ]
        )
    }
    
    private func values(for category: ProductCategory) -> [SQLiteValue] {
        [
            .integer(Int64(category.getId())),
            .text(category.getCode()),
            .text(category.getColor()),
            .text(category.getName()),
            .text(category.getLogo()),
            .text(category.getCoverUrl())
        ]
    }
    
    private func mapCategory(row: SQLiteRow) -> ProductCategory {
        ProductCategory(data: ProductCategoryData(
            id: row.int(Table.id) ?? -1,
            code: row.string(Table.code) ?? "",
            color: row.string(Table.color),
            name: row.string(Table.name) ?? "",
            logo: row.string(Table.logo) ?? "",
            coverUrl: row.string(Table.coverUrl)
        ))
    }
}
