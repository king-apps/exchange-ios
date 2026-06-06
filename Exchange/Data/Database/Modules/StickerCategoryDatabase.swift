import Foundation


class StickerCategoryDatabase {
    
    enum SortOrder {
        case sort
        case code
    }
    
    private enum Table {
        static let raw = "category"
        
        static let id = "id"
        static let code = "code"
        static let color = "color"
        static let name = "name"
        static let logo = "logo"
        static let coverUrl = "cover_url"
        static let sort = "sort"
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
    
    func list(ids: [Int]? = nil, sortOrder: SortOrder = .sort) throws -> [ProductCategory] {
        var sql = """
        SELECT
            \(Table.id),
            \(Table.code),
            \(Table.color),
            \(Table.name),
            \(Table.logo),
            \(Table.coverUrl),
            \(Table.sort)
        FROM \(Table.raw)
        """
        var parameters: [SQLiteValue] = []
        
        if let ids {
            guard ids.isEmpty == false else { return [] }
            
            let placeholders = ids.map { _ in "?" }.joined(separator: ", ")
            sql += " WHERE \(Table.id) IN (\(placeholders))"
            parameters = ids.map { .integer(Int64($0)) }
        }
        
        sql += " \(orderClause(for: sortOrder))"
        
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
                \(Table.coverUrl),
                \(Table.sort)
            ) VALUES (?, ?, ?, ?, ?, ?, ?)
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
                \(Table.coverUrl) = ?,
                \(Table.sort) = ?
            WHERE \(Table.id) = ?
            """,
            parameters: [
                .text(category.getCode()),
                .text(category.getColor()),
                .text(category.getName()),
                .text(category.getLogo()),
                .text(category.getCoverUrl()),
                .integer(Int64(category.getSort())),
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
            .text(category.getCoverUrl()),
            .integer(Int64(category.getSort()))
        ]
    }
    
    private func orderClause(for sortOrder: SortOrder) -> String {
        switch sortOrder {
        case .sort:
            return "ORDER BY \(Table.sort), \(Table.code) COLLATE NOCASE"
        case .code:
            return "ORDER BY \(Table.code) COLLATE NOCASE"
        }
    }
    
    private func mapCategory(row: SQLiteRow) -> ProductCategory {
        ProductCategory(data: ProductCategoryData(
            id: row.int(Table.id) ?? -1,
            code: row.string(Table.code) ?? "",
            color: row.string(Table.color),
            name: row.string(Table.name) ?? "",
            logo: row.string(Table.logo) ?? "",
            coverUrl: row.string(Table.coverUrl),
            sort: row.int(Table.sort) ?? 0
        ))
    }
}
