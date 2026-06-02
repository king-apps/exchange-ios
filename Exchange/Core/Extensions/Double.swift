import Foundation


extension Double {
    
    
    // Get String With Currency Symbol
    func moneyFormatWithCurrencySimbol(locale: Locale?) -> String {
        
        let formatter           = NumberFormatter.init()
        formatter.locale        = locale ?? Locale.current
        formatter.numberStyle   = NumberFormatter.Style.currency
        
        if let string = formatter.string(from: NSNumber.init(value: self)) {
            return string
        }

        return "--"
    }
    
    
}
