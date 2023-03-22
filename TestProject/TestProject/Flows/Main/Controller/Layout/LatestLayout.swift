import UIKit

fileprivate enum Constant {
    static let cellHeightMultiplier: CGFloat = 5.3
    static let cellWidthMultiplier: CGFloat = 3
}

final class LatestLayout: UICollectionViewFlowLayout {
    static let cellHeight: CGFloat = UIScreen.main.bounds.height / Constant.cellHeightMultiplier

    override func prepare() {
        super.prepare()
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        scrollDirection = .horizontal
        itemSize = .init(
            width: (UIScreen.main.bounds.width / Constant.cellWidthMultiplier),
            height: LatestLayout.cellHeight
        )
    }
}
