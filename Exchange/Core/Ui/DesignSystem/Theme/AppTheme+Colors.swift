import UIKit


extension AppTheme {
    
    enum ColorToken: String {
        
        // Background
        case backgroundBase = "BackgroundBase"
        case backgroundDisabled = "BackgroundDisabled"
        case backgroundSurface90 = "BackgroundSurface90"
        case backgroundSurface100 = "BackgroundSurface100"
        case backgroundButton = "BackgroundButton"
        
        // Base
        case baseWhite = "BaseWhite"
        case baseWhite90 = "BaseWhite90"
        case baseBlack = "BaseBlack"
        case baseBlack90 = "BaseBlack90"
        
        // Border (Semantic)
        case borderDefault = "BorderDefault"
        case borderStrong = "BorderStrong"
        
        // Brand
        case brandPrimary100 = "BrandPrimary100"
        case brandPrimary300 = "BrandPrimary300"
        case brandPrimary500 = "BrandPrimary500"
        case brandPrimary700 = "BrandPrimary700"
        
        // Icon
        case iconOnBrandPrimary = "IconOnBrandPrimary"
        case iconOnSurface = "IconOnSurface"
        case iconOnSurfaceDisabled = "IconOnSurfaceDisabled"
        case iconOnSurfaceSecondary = "IconOnSurfaceSecondary"
        
        // Match
        case matchBoost = "MatchBoost"
        case matchLike = "MatchLike"
        case matchNope = "MatchNope"
        case matchSuperLike = "MatchSuperLike"
        
        // Neutral
        case neutral50  = "Neutral50"
        case neutral100 = "Neutral100"
        case neutral200 = "Neutral200"
        case neutral400 = "Neutral400"
        case neutral600 = "Neutral600"
        case neutral900 = "Neutral900"
        
        // Text
        case textOnBrandPrimary = "TextOnBrandPrimary"
        case textOnSurface = "TextOnSurface"
        case textOnSurfaceDisabled = "TextOnSurfaceDisabled"
        case textOnSurfaceSecondary = "TextOnSurfaceSecondary"
        case textOnButton = "TextOnButton"
        
        // Button
        case buttonPrimary = "ButtonPrimary"
        case buttonOnPrimary = "ButtonOnPrimary"
        case buttonDisabled = "ButtonDisabled"
        case buttonOnDisabled = "ButtonOnDisabled"
        
        // Success scale
        case success100 = "Success100"
        case success300 = "Success300"
        case success500 = "Success500"
        case success700 = "Success700"

        // Warning scale
        case warning100 = "Warning100"
        case warning300 = "Warning300"
        case warning500 = "Warning500"
        case warning700 = "Warning700"
        
        // Error
        case error100 = "Error100"
        case error300 = "Error300"
        case error500 = "Error500"
        case error700 = "Error700"
        
    }
    
    
    static func color(_ token: ColorToken, fallback: UIColor = .systemPink, file: StaticString = #fileID, line: UInt = #line) -> UIColor {
        
        guard let c = UIColor(named: token.rawValue) else {
            assertionFailure("🎨 Missing color asset: \(token.rawValue) (\(file):\(line))")
            return fallback
        }
        return c
    }
    
}


extension AppTheme {

    enum Colors {
        
        // Background
        static var backgroundBase: UIColor { AppTheme.color(.backgroundBase) }
        static var backgroundDisabled: UIColor { AppTheme.color(.backgroundDisabled) }
        static var backgroundSurface90: UIColor { AppTheme.color(.backgroundSurface90) }
        static var backgroundSurface100: UIColor { AppTheme.color(.backgroundSurface100) }
        
        // Base
        static var baseWhite: UIColor { AppTheme.color(.baseWhite) }
        static var baseWhite90: UIColor { AppTheme.color(.baseWhite90) }
        static var baseBlack: UIColor { AppTheme.color(.baseBlack) }
        static var baseBlack90: UIColor { AppTheme.color(.baseBlack90) }
        
        // Border
        static var borderDefault: UIColor { AppTheme.color(.borderDefault) }
        static var borderStrong: UIColor { AppTheme.color(.borderStrong) }
        
        // Brand
        static var brandPrimary100: UIColor { AppTheme.color(.brandPrimary100) }
        static var brandPrimary300: UIColor { AppTheme.color(.brandPrimary300) }
        static var brandPrimary500: UIColor { AppTheme.color(.brandPrimary500) }
        static var brandPrimary700: UIColor { AppTheme.color(.brandPrimary700) }
        
        // Icon
        static var iconOnBrandPrimary: UIColor { AppTheme.color(.iconOnBrandPrimary) }
        static var iconOnSurface: UIColor { AppTheme.color(.iconOnSurface) }
        static var iconOnSurfaceDisabled: UIColor { AppTheme.color(.iconOnSurfaceDisabled) }
        static var iconOnSurfaceSecondary: UIColor { AppTheme.color(.iconOnSurfaceSecondary) }
        
        // Match
        static var matchBoost: UIColor { AppTheme.color(.matchBoost) }
        static var matchLike: UIColor { AppTheme.color(.matchLike) }
        static var matchNope: UIColor { AppTheme.color(.matchNope) }
        static var matchSuperLike: UIColor { AppTheme.color(.matchSuperLike) }
        
        // Neutral
        static var neutral50: UIColor { AppTheme.color(.neutral50) }
        static var neutral100: UIColor { AppTheme.color(.neutral100) }
        static var neutral200: UIColor { AppTheme.color(.neutral200) }
        static var neutral400: UIColor { AppTheme.color(.neutral400) }
        static var neutral600: UIColor { AppTheme.color(.neutral600) }
        static var neutral900: UIColor { AppTheme.color(.neutral900) }
        
        // Text
        static var textOnBrandPrimary: UIColor { AppTheme.color(.textOnBrandPrimary) }
        static var textOnSurface: UIColor { AppTheme.color(.textOnSurface) }
        static var textOnSurfaceDisabled: UIColor { AppTheme.color(.textOnSurfaceDisabled) }
        static var textOnSurfaceSecondary: UIColor { AppTheme.color(.textOnSurfaceSecondary) }
        static var textOnButton: UIColor { AppTheme.color(.textOnButton) }
        
        // Button
        static var buttonPrimary: UIColor { AppTheme.color(.buttonPrimary) }
        static var buttonOnPrimary: UIColor { AppTheme.color(.buttonOnPrimary) }
        static var buttonDisabled: UIColor { AppTheme.color(.buttonDisabled) }
        static var buttonOnDisabled: UIColor { AppTheme.color(.buttonOnDisabled) }

        // Success scale
        static var success100: UIColor { AppTheme.color(.success100) }
        static var success300: UIColor { AppTheme.color(.success300) }
        static var success500: UIColor { AppTheme.color(.success500) }
        static var success700: UIColor { AppTheme.color(.success700) }
        
        // Warning scale
        static var warning100: UIColor { AppTheme.color(.warning100) }
        static var warning300: UIColor { AppTheme.color(.warning300) }
        static var warning500: UIColor { AppTheme.color(.warning500) }
        static var warning700: UIColor { AppTheme.color(.warning700) }
        
        // Error scale
        static var error100: UIColor { AppTheme.color(.error100) }
        static var error300: UIColor { AppTheme.color(.error300) }
        static var error500: UIColor { AppTheme.color(.error500) }
        static var error700: UIColor { AppTheme.color(.error700) }
    }
    
}
