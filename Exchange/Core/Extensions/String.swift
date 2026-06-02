import UIKit
import Foundation


extension String {
    
    
    // Lozalized
    var localized: String {
        let table = LocalConfig.shared.getLanguage()
        let overrideTable = "\(table)_override"
        let overrideText = Bundle.main.localizedString(forKey: self, value: "{NOT_FOUND}", table: overrideTable)
        if overrideText != "{NOT_FOUND}" {
            return overrideText
        }
        return Bundle.main.localizedString(forKey: self, value: "{{\(self)}}", table: table)
    }
    
    
    // Mask
    func mask(_ mask:String) -> String {
        
        var result:String   = ""
        var index:Int       = 0
        var _mask           = mask
        let _string         = self.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
        
        var data = [String]()
        for i in 0 ..< _mask.count {
            
            let start   = _mask.index(_mask.startIndex, offsetBy: i)
            let end     = _mask.index(_mask.startIndex, offsetBy: i+1)
            let range   = start..<end
            let c       = _mask[range]
            if c == "#"  {
                data.append(String(c))
            }
        }
        
        if _string.count > data.count {
            _mask = _mask.replacingOccurrences(of: "?", with: "#")
        }
        else {
            _mask = _mask.replacingOccurrences(of: "?", with: "")
        }
        
        for i in 0 ..< _mask.count {
            
            let start   = _mask.index(_mask.startIndex, offsetBy: i)
            let end     = _mask.index(_mask.startIndex, offsetBy: i+1)
            let range   = start..<end
            let c       = _mask[range]
            
            if c=="#" {
                if _string.count>index {
                    result += _string[_mask.index(_string.startIndex, offsetBy: index)..<_mask.index(_string.startIndex, offsetBy: index+1)]
                    index  += 1
                }
            }
            else {
                if _string.count>index {
                    result += _mask[_mask.index(_mask.startIndex, offsetBy: i)..<_mask.index(_mask.startIndex, offsetBy: i+1)]
                }
            }
        }
        
        return result
    }
    
    
    // Cpf
    func isValidCpf() -> Bool {
        let cpf     = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let numbers = cpf.compactMap({Int(String($0))})
        if numbers.count == 11 {
            
            if cpf == "11111111111" ||
               cpf == "22222222222" ||
               cpf == "33333333333" ||
               cpf == "44444444444" ||
               cpf == "55555555555" ||
               cpf == "66666666666" ||
               cpf == "77777777777" ||
               cpf == "88888888888" ||
               cpf == "99999999999" ||
               cpf == "00000000000" {
               return false
            }
            
            let sum1 = 11 - (
                numbers[0] * 10 +
                    numbers[1] * 9 +
                    numbers[2] * 8 +
                    numbers[3] * 7 +
                    numbers[4] * 6 +
                    numbers[5] * 5 +
                    numbers[6] * 4 +
                    numbers[7] * 3 +
                    numbers[8] * 2
                ) % 11
            let dv1 = sum1 > 9 ? 0 : sum1
            let sum2 = 11 - (
                numbers[0] * 11 +
                    numbers[1] * 10 +
                    numbers[2] * 9 +
                    numbers[3] * 8 +
                    numbers[4] * 7 +
                    numbers[5] * 6 +
                    numbers[6] * 5 +
                    numbers[7] * 4 +
                    numbers[8] * 3 +
                    numbers[9] * 2
                ) % 11
            let dv2 = sum2 > 9 ? 0 : sum2
            
            return dv1 == numbers[9] && dv2 == numbers[10]
        }
        
        return false
    }
 
    
    // Get only numbers
    func getOnlyNumbers() -> String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    
    // Email
    func isValidEmail() -> Bool {
        let emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" +
        "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    
    // Remove special chars
    func removeSpecialChars() -> String {
        let simple = self.folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
 
    
    // Offset Currency Symbol Correction : adding space after R$ symbol
    func offsetCurrencySymbol() -> String {
        return self.replacingOccurrences(of: " ", with: "");
    }
    
    
    // Double value
    func doubleValue() -> Double {
        
        let formater = NumberFormatter()
        formater.locale = Locale.current
        formater.numberStyle = .currency
        
        var money = self.replacingOccurrences(of: formater.currencySymbol, with: "")
        money = money.replacingOccurrences(of: formater.groupingSeparator, with: "")
        money = money.replacingOccurrences(of: formater.decimalSeparator, with: "")
        
        let value = (money as NSString).doubleValue / 100.0
        return value
    
    }
    
    
    // Remove html
    func removeHtml() -> String {
        return self
            .replacingOccurrences(of: "<strong>", with: "")
            .replacingOccurrences(of: "</strong>", with: "")
            .replacingOccurrences(of: "<b>", with: "")
            .replacingOccurrences(of: "</b>", with: "")
            .replacingOccurrences(of: "<i>", with: "")
            .replacingOccurrences(of: "</i>", with: "")
    }
    
    
    // URL
    func normalizedURL() -> URL? {
        let text = self.trimmingCharacters(in: .whitespacesAndNewlines)
        if text.isEmpty {
            return nil
        }
        
        if text.lowercased().hasPrefix("http://") || text.lowercased().hasPrefix("https://") {
            return URL(string: text)
        }
        
        return URL(string: "https://\(text)")
    }
    
    
}
