import UIKit

final class BaseTextViewContainer: UIView {

    let textField = BaseTextField()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }

    private func setup() {
        backgroundColor = Color.Background.secondary

        addAndEdgesViewWithInsets(textField, hInset: 10)
    }
}
