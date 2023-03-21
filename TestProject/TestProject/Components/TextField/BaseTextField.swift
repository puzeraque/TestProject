import UIKit

final class BaseTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        autocorrectionType = .no
        autocapitalizationType = .none
        tintColor = Color.Button.main
    }

    func placeholder(_ text: String?) {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        attributedPlaceholder = NSAttributedString(
            string: text.orEmpty,
            attributes: [
                .paragraphStyle: centeredParagraphStyle,
                .font: Fonts.caption1,
                .foregroundColor: Color.Text.secondary
            ]
        )
    }
}
