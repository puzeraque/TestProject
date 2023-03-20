import UIKit

final class LatestLayout: UICollectionViewFlowLayout {
    static let cellHeight: CGFloat = UIScreen.main.bounds.height / 5.3

    override func prepare() {
        super.prepare()
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        scrollDirection = .horizontal
        itemSize = .init(
            width: (UIScreen.main.bounds.width / 3),
            height: LatestLayout.cellHeight
        )
    }
}
