import UIKit

final class FlashSaleLayout: UICollectionViewFlowLayout {
    static let cellHeight: CGFloat = UIScreen.main.bounds.height / 3.5

    override func prepare() {
        super.prepare()
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        scrollDirection = .horizontal
        itemSize = .init(
            width: (UIScreen.main.bounds.width / 2),
            height: FlashSaleLayout.cellHeight
        )
    }
}
