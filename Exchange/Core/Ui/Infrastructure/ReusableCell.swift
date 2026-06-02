import UIKit


protocol ReusableCell: UITableViewCell {
    static var reuseID: String { get }
}


extension ReusableCell {
    static var reuseID: String {
        return String(describing: Self.self)
    }
}
