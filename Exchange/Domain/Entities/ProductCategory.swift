import UIKit


struct ProductCategoryData {
    let id: Int
    let code: String
    let color: String?
    let name: String
    let logo: String
    let coverUrl: String?
}


class ProductCategory {
    
    private var id: Int
    private var name: String
    private var logo: String
    private var code: String
    private var color: String
    private var coverUrl: String
    
    init() {
        id = -1
        name = ""
        logo = ""
        code = ""
        color = ""
        coverUrl = ""
    }
    
    convenience init(data: ProductCategoryData) {
        self.init()
        
        id << data.id
        name << data.name
        logo << data.logo
        code << data.code
        color << data.color
        coverUrl << data.coverUrl
    }
    
    convenience init(dto: ProductCategoryDTO) {
        self.init()
        
        id << dto.id
        name << dto.name
        logo << dto.logo
        code << dto.code
        color << dto.color
        coverUrl << dto.logo
    }
    
    func getId() -> Int { id }
    func getName() -> String { name }
    func getLogo() -> String { logo }
    func getCode() -> String { code }
    func getColor() -> String { color }
    func getCoverUrl() -> String { coverUrl }
    
    func getPrimaryColor() -> UIColor {
        ProductCategory.primaryColor(forCode: code)
    }
    
    static func primaryColor(forCode code: String) -> UIColor {
        let normalizedCode = code
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()
        
        return primaryColors[normalizedCode] ?? fallbackPrimaryColor
    }
    
    private static let fallbackPrimaryColor = UIColor(hex: "#4B5563")
    
    private static let primaryColors: [String: UIColor] = [
        "GER": UIColor(hex: "#111111"),
        "ARG": UIColor(hex: "#1D5FA7"),
        "ALG": UIColor(hex: "#006233"),
        "KSA": UIColor(hex: "#006C35"),
        "AUS": UIColor(hex: "#012169"),
        "BRA": UIColor(hex: "#007A3D"),
        "BEL": UIColor(hex: "#111111"),
        "BIH": UIColor(hex: "#002F6C"),
        "CPV": UIColor(hex: "#003893"),
        "CAN": UIColor(hex: "#C8102E"),
        "QAT": UIColor(hex: "#8A1538"),
        "COL": UIColor(hex: "#003893"),
        "KOR": UIColor(hex: "#003478"),
        "CIV": UIColor(hex: "#006B3F"),
        "ESP_CROMOS": UIColor(hex: "#4B5563"),
        "CRO": UIColor(hex: "#B31942"),
        "CUW": UIColor(hex: "#002B7F"),
        "EGY": UIColor(hex: "#CE1126"),
        "ECU": UIColor(hex: "#034EA2"),
        "SCO": UIColor(hex: "#005EB8"),
        "ESP": UIColor(hex: "#AA151B"),
        "USA": UIColor(hex: "#3C3B6E"),
        "FRA": UIColor(hex: "#002395"),
        "GHA": UIColor(hex: "#006B3F"),
        "HAI": UIColor(hex: "#00209F"),
        "NED": UIColor(hex: "#21468B"),
        "ENG": UIColor(hex: "#C8102E"),
        "IRQ": UIColor(hex: "#CE1126"),
        "IRN": UIColor(hex: "#006B3F"),
        "JPN": UIColor(hex: "#BC002D"),
        "JOR": UIColor(hex: "#CE1126"),
        "MAR": UIColor(hex: "#C1272D"),
        "MEX": UIColor(hex: "#006847"),
        "NOR": UIColor(hex: "#00205B"),
        "NZL": UIColor(hex: "#00247D"),
        "PAN": UIColor(hex: "#005293"),
        "PAR": UIColor(hex: "#0038A8"),
        "POR": UIColor(hex: "#006600"),
        "COD": UIColor(hex: "#0057A8"),
        "CZE": UIColor(hex: "#11457E"),
        "SEN": UIColor(hex: "#00853F"),
        "SWE": UIColor(hex: "#005293"),
        "SUI": UIColor(hex: "#DA291C"),
        "TUN": UIColor(hex: "#E70013"),
        "TUR": UIColor(hex: "#E30A17"),
        "URU": UIColor(hex: "#0038A8"),
        "UZB": UIColor(hex: "#0072CE"),
        "RSA": UIColor(hex: "#007A4D"),
        "AUT": UIColor(hex: "#C8102E")
    ]
}
