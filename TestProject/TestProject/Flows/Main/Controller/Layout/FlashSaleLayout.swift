import UIKit

fileprivate enum Constant {
    static let cellHeightMultiplier: CGFloat = 3.5
    static let cellWidthMultiplier: CGFloat = 2
}

final class FlashSaleLayout: UICollectionViewFlowLayout {
    static let cellHeight: CGFloat = UIScreen.main.bounds.height / Constant.cellHeightMultiplier

    override func prepare() {
        super.prepare()
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        scrollDirection = .horizontal
        itemSize = .init(
            width: (UIScreen.main.bounds.width / Constant.cellWidthMultiplier),
            height: FlashSaleLayout.cellHeight
        )
    }
}
