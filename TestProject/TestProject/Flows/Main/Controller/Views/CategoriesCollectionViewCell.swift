import UIKit
import SkeletonView

enum CategoriesType : CaseIterable {
    case phone
    case headphones
    case games
    case cars
    case furniture
    case kids

    var image: UIImage? {
        switch self {
        case .phone:
            return Image.SearchCategories.phone.image
        case .headphones:
            return Image.SearchCategories.headphones.image
        case .games:
            return Image.SearchCategories.games.image
        case .cars:
            return Image.SearchCategories.car.image
        case .furniture:
            return Image.SearchCategories.furniture.image
        case .kids:
            return Image.SearchCategories.kid.image
        }
    }

    var title: String? {
        switch self {
        case .phone:
            return "Phone"
        case .headphones:
            return "Headphone"
        case .games:
            return "Games"
        case .cars:
            return "Cars"
        case .furniture:
            return "Home"
        case .kids:
            return "Kids"
        }
    }
}

final class CategoriesCollectionViewCell: BaseCollectionViewCell {

    private let imageViewContainer: BaseView = {
        $0.backgroundColor(Color.TabBar.selection)
        $0.size(.square(34))
        $0.cornerRadius(17)
        return $0
    }(BaseView())
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

        let container = BaseView()
        container.height(34)
        container.putInCenter(imageViewContainer)

        let stackView = StackView(
            axis: .vertical,
            spacing: 10,
            arrangedSubviews: [container, titleLabel]
        )

        addAndEdgesViewWithInsets(stackView, vInset: 4)
        width((UIScreen.main.bounds.width - 32) / 7)
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
