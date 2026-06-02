import UIKit

extension UITableView {

    func register<T: NibLoadableCell>(_ cell: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reuseID)
    }

    func dequeue<T: ReusableCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        guard let c = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.reuseID)")
        }
        return c
    }
}
