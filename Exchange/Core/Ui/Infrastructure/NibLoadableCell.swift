import UIKit


protocol NibLoadableCell: ReusableCell {
    static var nib: UINib { get }
}


extension NibLoadableCell {
    static var nib: UINib {
        .init(nibName: reuseID, bundle: nil)
    }
}
