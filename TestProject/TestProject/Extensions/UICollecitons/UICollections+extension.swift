import UIKit

extension UITableViewCell {
    static var id: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var id: String {
        return String(describing: self)
    }
}
