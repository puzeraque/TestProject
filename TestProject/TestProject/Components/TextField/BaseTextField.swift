import UIKit

final class BaseTextField: UITextField {

    func placeholder(_ text: String) {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: centeredParagraphStyle,
                .font: Fonts.caption1
            ]
        )
    }
}
