import UIKit

fileprivate enum Constant {
    static let width: CGFloat = 52
    static let cornerRadius: CGFloat = 12
    static let imageSize: CGFloat = 20
}
final class QuantityPickerView: BaseView {
    private let plusButton = MainButton(
        title: nil,
        image: Image.ProductDetails.plus.image
    )
    private let minusButton = MainButton(
        title: nil,
        image: Image.ProductDetails.minus.image
    )

    var onPlusTapped: VoidHandler?
    var onMinusTapped: VoidHandler?

    override func setup() {

        let stackView =  StackView(
            axis: .horizontal,
            spacing: 14,
            arrangedSubviews: [minusButton, plusButton, UIView()]
        )

        plusButton.width(Constant.width)
        plusButton.setCornerRadius(Constant.cornerRadius)
        plusButton.imageSize(.square(Constant.imageSize))
        plusButton.onTap { [weak self] in
            self?.onPlusTapped?()
        }

        minusButton.width(Constant.width)
        minusButton.setCornerRadius(Constant.cornerRadius)
        minusButton.imageSize(.square(Constant.imageSize))
        minusButton.onTap { [weak self] in
            self?.onMinusTapped?()
        }

        addAndEdges(stackView)
    }
}
