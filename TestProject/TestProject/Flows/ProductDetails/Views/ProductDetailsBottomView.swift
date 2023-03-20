import UIKit

final class ProductDetailsBottomView: BaseView {
    private let quantityLabel = Label(
        text: "Quantity:",
        font: Fonts.caption1,
        textColor: Color.Text.secondary,
        textAlignment: .left
    )
    private let quantityPickerView = QuantityPickerView()
    private let addToCartButton = MainButton(
        title: "Add to cart".uppercased(),
        detailsTitle: .empty
    )

    var cost: Int = .zero

    private var quantity = 1

    override func setup() {
        backgroundColor(Color.Content.primary)
        cornerRadius(24)
        layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMinYCorner
        ]

        let quantityStackView = StackView(
            axis: .vertical,
            spacing: 10,
            arrangedSubviews: [quantityLabel, quantityPickerView]
        )
        quantityPickerView.height(30)

        addSubviews(quantityStackView, addToCartButton)

        quantityStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.leading.equalToSuperview().inset(22)
            make.trailing.equalTo(addToCartButton)
        }

        addToCartButton.setCornerRadius(16)
        addToCartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(26)
            make.trailing.equalToSuperview().inset(22)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(48)
        }

        quantityPickerView.onPlusTapped = { [weak self] in
            guard let self = self else { return }
            self.quantity += 1
            self.addToCartButton.detailsLabel.text = "$ \(self.cost * self.quantity)"
        }

        quantityPickerView.onMinusTapped = { [weak self] in
            guard let self = self else { return }
            if self.quantity > 1 {
                self.quantity -= 1
            }
            self.addToCartButton.detailsLabel.text = "$ \(self.cost * self.quantity)"
        }
    }
}

extension ProductDetailsBottomView: Configurable {
    typealias Model = Int

    func configure(with model: Int) {
        cost = model
        addToCartButton.detailsLabel.text = "$ \(model * quantity)"
    }
}
