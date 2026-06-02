import Foundation


class StickerDatabase {
    
    private enum Table {
        static let raw = "sticker"
        
        static let id = "id"
        static let idCategory = "id_category"
        static let idProduct = "id_product"
        static let title = "title"
        static let description = "description"
        static let collected = "collected"
    }
    
    // Var's
    private let db: SQLiteHelper
    
    
    // Construct
    init() throws {
        db = try SQLiteHelper(bundleResource: "stickers", withExtension: "db")
    }
    
    
    // Actions
    func get(id: Int?) throws -> Sticker? {
        guard let id else { return nil }
        return try list(ids: [id]).first
    }
    
    func list(ids: [Int]? = nil, idCategory: Int? = nil) throws -> [Sticker] {
        var sql = """
        SELECT
            \(Table.id),
            \(Table.idCategory),
            \(Table.idProduct),
            \(Table.title),
            \(Table.description),
            \(Table.collected)
        FROM \(Table.raw)
        """
        var whereClauses: [String] = []
        var parameters: [SQLiteValue] = []
        
        if let ids {
            guard ids.isEmpty == false else { return [] }
            
            let placeholders = ids.map { _ in "?" }.joined(separator: ", ")
            whereClauses.append("\(Table.id) IN (\(placeholders))")
            parameters.append(contentsOf: ids.map { .integer(Int64($0)) })
        }
        
        if let idCategory {
            whereClauses.append("\(Table.idCategory) = ?")
            parameters.append(.integer(Int64(idCategory)))
        }
        
        if whereClauses.isEmpty == false {
            sql += " WHERE \(whereClauses.joined(separator: " AND "))"
        }
        
        sql += " ORDER BY \(Table.id)"
        
        return try db
            .query(sql, parameters: parameters)
            .map(mapSticker)
    }
    
    @discardableResult
    func insert(_ sticker: Sticker) throws -> Int {
        if sticker.getId() > 0 {
            return try db.execute(
                """
                INSERT INTO \(Table.raw) (
                    \(Table.id),
                    \(Table.idCategory),
                    \(Table.idProduct),
                    \(Table.title),
                    \(Table.description),
                    \(Table.collected)
                ) VALUES (?, ?, ?, ?, ?, ?)
                """,
                parameters: values(for: sticker, includeId: true)
            )
        }
        
        return try db.execute(
            """
            INSERT INTO \(Table.raw) (
                \(Table.idCategory),
                \(Table.idProduct),
                \(Table.title),
                \(Table.description),
                \(Table.collected)
            ) VALUES (?, ?, ?, ?, ?)
            """,
            parameters: values(for: sticker, includeId: false)
        )
    }
    
    @discardableResult
    func update(_ sticker: Sticker) throws -> Int {
        try db.execute(
            """
            UPDATE \(Table.raw)
            SET
                \(Table.idCategory) = ?,
                \(Table.idProduct) = ?,
                \(Table.title) = ?,
                \(Table.description) = ?,
                \(Table.collected) = ?
            WHERE \(Table.id) = ?
            """,
            parameters: [
                .integer(Int64(sticker.getIdCategory())),
                .integer(Int64(sticker.getIdProduct())),
                .text(sticker.getTitle()),
                .text(sticker.getDescription()),
                .integer(Int64(sticker.getCollected())),
                .integer(Int64(sticker.getId()))
            ]
        )
    }
    
    @discardableResult
    func clearUserData() throws -> Int {
        try db.execute(
            """
            UPDATE \(Table.raw)
            SET
                \(Table.idProduct) = 0,
                \(Table.collected) = 0
            """
        )
    }
    
    private func values(for sticker: Sticker, includeId: Bool) -> [SQLiteValue] {
        var values: [SQLiteValue] = []
        
        if includeId {
            values.append(.integer(Int64(sticker.getId())))
        }
        
        values.append(contentsOf: [
            .integer(Int64(sticker.getIdCategory())),
            .integer(Int64(sticker.getIdProduct())),
            .text(sticker.getTitle()),
            .text(sticker.getDescription()),
            .integer(Int64(sticker.getCollected()))
        ])
        
        return values
    }
   
    private func mapSticker(row: SQLiteRow) -> Sticker {
        let sticker = Sticker()
        
        sticker.setId(row.int(Table.id) ?? 0)
        sticker.setIdCategory(row.int(Table.idCategory) ?? 0)
        sticker.setIdProduct(row.int(Table.idProduct) ?? 0)
        sticker.setTitle(row.string(Table.title) ?? "")
        sticker.setDescription(row.string(Table.description) ?? "")
        sticker.setCollected(row.int(Table.collected) ?? 0)
        
        return sticker
    }
}
