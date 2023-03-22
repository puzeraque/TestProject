import UIKit
import SkeletonView

fileprivate enum Constant {
    static let collectionInset: CGFloat = 32
    static let collectionVisibleCount: CGFloat = 7
}

final class CategoriesCollectionViewCell: BaseCollectionViewCell {

    private let imageViewContainer: BaseView = {
        $0.size(.square(34))
        $0.cornerRadius(17)
        return $0
    }(BaseView(backgroundColor: Color.TabBar.selection))
    private let imageView: BaseImageView = {
        $0.size(.square(20))
        $0.tintColor = Color.Content.primary
        return $0
    }(BaseImageView())
    private let titleLabel = Label(
        font: Fonts.caption2,
        textColor: Color.Text.primary,
        textAlignment: .center
    )

    override func setup() {
        super.setup()
        imageViewContainer.putInCenter(imageView)

        let imageViewCenterContainer = BaseView()
        imageViewCenterContainer.height(34)
        imageViewCenterContainer.putInCenter(imageViewContainer)

        let stackView = StackView(
            axis: .vertical,
            spacing: 10,
            arrangedSubviews: [imageViewCenterContainer, titleLabel]
        )

        addAndEdgesViewWithInsets(stackView, vInset: 4)

        let viewWidth = UIScreen.main.bounds.width - Constant.collectionInset
        width((viewWidth) / Constant.collectionVisibleCount)
    }
}

extension CategoriesCollectionViewCell: Configurable {
    typealias Model = CategoriesType

    func configure(with model: CategoriesType) {
        imageView.image = model.image
        titleLabel.text = model.title

        onTap {
            AlertService.center.show(.base(title: model.title.orEmpty))
        }
    }
}
