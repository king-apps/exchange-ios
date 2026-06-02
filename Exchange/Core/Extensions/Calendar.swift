import UIKit


extension Calendar {
    static var business: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.locale = Locale(identifier: "pt_BR")
        cal.timeZone = .current
        cal.firstWeekday = 1 // Domingo
        return cal
    }
    
    func todayIndex() -> Int {
        // weekday: 1=Dom ... 7=Sab
        Calendar.business.component(.weekday, from: Date()) - 1 // 0..6
    }
}



