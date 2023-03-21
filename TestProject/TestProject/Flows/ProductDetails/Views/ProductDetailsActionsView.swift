import UIKit

fileprivate enum Constant {
    static let cornerRadius: CGFloat = 16
    static let buttonSize: CGFloat = 20
}

final class ProductDetailsActionsView: BaseView {

    private let stackView = StackView(axis: .vertical, spacing: 10)
    private let favoritesButton: BaseButton = {
        $0.setImage(Image.ProductDetails.share.image, for: .normal)
        $0.imageView?.tintColor = Color.Button.action
        $0.size(.square(Constant.buttonSize))
        return $0
    }(BaseButton())
    private let shareButton: BaseButton = {
        $0.setImage(Image.TabBar.heart.image, for: .normal)
        $0.imageView?.tintColor = Color.Button.action
        $0.size(.square(Constant.buttonSize))
        return $0
    }(BaseButton())
    private let dividerView: BaseView = {
        $0.backgroundColor = Color.Button.action
        return $0
    }(BaseView())

    var onShareTapped: VoidHandler?
    var onAddToFavoritesTapped: VoidHandler?

    override func setup() {
        super.setup()
        cornerRadius(Constant.cornerRadius)
        backgroundColor(Color.Background.actions)

        let dividerViewContainer = BaseView()
        dividerViewContainer.addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
            make.width.equalTo(14)
        }

        stackView.addArrangedSubviews(shareButton, dividerViewContainer, favoritesButton)

        addAndEdgesViewWithInsets(stackView, hInset: 10, vInset: 15)

        shareButton.onTap { [weak self] in
            self?.onShareTapped?()
        }

        favoritesButton.onTap { [weak self] in
            self?.onAddToFavoritesTapped?()
        }
    }
}
