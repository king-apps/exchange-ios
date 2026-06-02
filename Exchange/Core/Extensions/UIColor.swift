import UIKit
import Foundation


extension UIColor {
    
    convenience init(hex: String) {
        let hex = hex
            .trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var value: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&value)
        
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
        
        switch hex.count {
        case 6:
            red = CGFloat((value & 0xFF0000) >> 16) / 255.0
            green = CGFloat((value & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(value & 0x0000FF) / 255.0
            alpha = 1.0
        case 8:
            red = CGFloat((value & 0xFF000000) >> 24) / 255.0
            green = CGFloat((value & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((value & 0x0000FF00) >> 8) / 255.0
            alpha = CGFloat(value & 0x000000FF) / 255.0
        default:
            red = 75.0 / 255.0
            green = 85.0 / 255.0
            blue = 99.0 / 255.0
            alpha = 1.0
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}
