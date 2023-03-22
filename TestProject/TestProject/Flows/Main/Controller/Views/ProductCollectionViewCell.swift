import UIKit
import SkeletonView

final class ProductCollectionViewCell: BaseCollectionViewCell {
    private let imageView: BaseImageView = {
        $0.contentMode = .scaleAspectFill
        return $0
    }(BaseImageView())
    private lazy var infoStackView = StackView(
        axis: .vertical,
        spacing: 10,
        arrangedSubviews: [typeContainerViewStackView, titleLabel, costLabel]
    )
    private let titleLabel = Label(
        font: Fonts.title,
        textColor: Color.Text.primaryButton,
        textAlignment: .left,
        numberOfLines: .zero
    )
    private lazy var typeContainerViewStackView = StackView(
        axis: .horizontal,
        arrangedSubviews: [typeContainerView, UIView()]
    )
    private let typeContainerView: BaseView = {
        $0.isHidden = true
        return $0
    }(BaseView(backgroundColor: Color.TabBar.background.withAlphaComponent(0.7)))
    private let typeLabel = Label(
        font: Fonts.caption2Bold,
        textColor: Color.Text.primary,
        textAlignment: .center
    )
    private let costLabel = Label(
        font: Fonts.caption1Bold,
        textColor: Color.Text.primaryButton,
        textAlignment: .left
    )
    private let saleContainerView: BaseView = {
        $0.isHidden = true
        return $0
    }(BaseView(backgroundColor: Color.Main.sale))
    private let saleLabel = Label(
        font: Fonts.caption2Bold,
        textColor: Color.Text.primaryButton,
        textAlignment: .center
    )
    private let profileIcon: BaseImageView = {
        $0.size(.square(24))
        $0.cornerRadius(12)
        $0.border(width: 0.5, color: Color.Text.primaryButton)
        return $0
    }(BaseImageView())

    private let addButton: BaseButton = {
        $0.isHidden = true
        $0.setImage(Image.ProductDetails.plus.image, for: .normal)
        $0.imageView?.tintColor = Color.Content.secondary
        $0.backgroundColor(Color.TabBar.selection)
        return $0
    }(BaseButton())
    private let favoritesButton: BaseButton = {
        $0.isHidden = true
        $0.size(.square(24))
        $0.cornerRadius(12)
        $0.setImage(Image.TabBar.heart.image, for: .normal)
        $0.imageView?.tintColor = Color.Content.secondary
        $0.imageView?.size(.square(14))
        $0.backgroundColor(Color.TabBar.selection)
        return $0
    }(BaseButton())
    private lazy var favoritesButtonContainerView = BaseView()
    private lazy var buttonsStackView = StackView(
        axis: .horizontal,
        spacing: 6,
        arrangedSubviews: [favoritesButtonContainerView, addButton]
    )

    private lazy var infoStackContainerStackView = StackView(
        axis: .horizontal,
        arrangedSubviews: [infoStackView, UIView()]
    )

    override func layoutSubviews() {
        super.layoutSubviews()
        typeContainerView.cornerRadius(typeContainerView.frame.height / 1.8)
        saleContainerView.cornerRadius(saleContainerView.frame.height / 2)
    }

    override func setup() {
        super.setup()
        clipsToBounds = true
        isSkeletonable = true
        skeletonCornerRadius = 10
        cornerRadius(10)

        addAndEdges(imageView)
        favoritesButtonContainerView.addSubview(favoritesButton)
        saleContainerView.addAndEdgesViewWithInsets(saleLabel, hInset: 8, vInset: 4)
        favoritesButton.width(28)
        typeContainerView.addAndEdgesViewWithInsets(typeLabel, hInset: 6, vInset: 2)
        addSubviews(
            profileIcon,
            saleContainerView,
            infoStackContainerStackView,
            buttonsStackView
        )
        setupLayout()
    }

    private func setupLayout() {
        favoritesButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        profileIcon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(6)
        }
        saleContainerView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(6)
        }
        infoStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        infoStackContainerStackView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(10)
        }

        buttonsStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension ProductCollectionViewCell: Configurable {
    struct Model {
        let title: String?
        let productType: String?
        let sale: Int?
        let cost: String
        let image: UIImage
        let isSale: Bool
    }

    func configure(with model: Model) {
        imageView.image = model.image
        costLabel.text = model.cost
        titleLabel.text = model.title
        typeLabel.text = model.productType
        typeContainerView.isHidden = false
        saleLabel.text = "\(model.sale ?? .zero)% off"
        saleContainerView.isHidden = !model.isSale
        profileIcon.isHidden = !model.isSale
        profileIcon.image = Image.Main.profile.image
        favoritesButton.isHidden = !model.isSale
        addButton.isHidden = false
        addButton.size(.square(model.isSale ? 32 : 24))
        addButton.cornerRadius(model.isSale ? 16 : 12)
        addButton.imageView?.size(.square(model.isSale ? 18 : 14))

        titleLabel.font = model.isSale ? Fonts.title : Fonts.caption2Bold
        typeLabel.font = model.isSale ? Fonts.caption2Bold : Fonts.caption3Bold
        costLabel.font = model.isSale ? Fonts.caption1Bold : Fonts.caption3Bold
    }
}
