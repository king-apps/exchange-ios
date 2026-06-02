import Foundation


extension Int {
    
    func getStringForMonth() -> String {
        
        if self == 1 { return "JAN" }
        if self == 2 { return "FEV" }
        if self == 3 { return "MAR" }
        if self == 4 { return "ABR" }
        if self == 5 { return "MAI" }
        if self == 6 { return "JUN" }
        if self == 7 { return "JUL" }
        if self == 8 { return "AGO" }
        if self == 9 { return "SET" }
        if self == 10 { return "OUT" }
        if self == 11 { return "NOV" }
        if self == 12 { return "DEZ" }
        
        return ""
        
    }
    
    
}
