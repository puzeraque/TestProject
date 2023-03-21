import UIKit

final class ProductsHeaderView: UICollectionReusableView {
    private let titleLabel = Label(
        font: Fonts.titleSemiBold,
        textColor: Color.Text.primary,
        textAlignment: .left
    )

    private let viewAllButton: BaseButton = {
        $0.setTitle("View all", for: .normal)
        $0.setTitleColor(Color.Text.secondary, for: .normal)
        $0.titleLabel?.font = Fonts.caption1
        $0.titleLabel?.textAlignment = .right
        return $0
    }(BaseButton())

    private lazy var stackView = StackView(
        axis: .horizontal,
        arrangedSubviews: [titleLabel, viewAllButton]
    )

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        addAndEdgesViewWithInsets(stackView, hInset: 16)
        self.height(30)
    }
}

extension ProductsHeaderView: Configurable {
    typealias Model = String

    func configure(with model: String) {
        titleLabel.text = model
    }
}
