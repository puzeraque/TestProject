import UIKit

final class Label: UILabel {

    init(
        text: String? = nil,
        font: UIFont? = nil,
        textColor: UIColor? = nil,
        textAlignment: NSTextAlignment? = nil,
        numberOfLines: Int? = nil
    ) {
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment ?? .center
        self.numberOfLines = numberOfLines ?? 1
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func changeColorOfPartOfTheText(fullText: String, partOfTheText: String) {
        let ranges = (fullText.lowercased()).ranges(of: partOfTheText.lowercased())
        let mutableAttributedString = NSMutableAttributedString(string: fullText)
        ranges.forEach { range in
            mutableAttributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: Color.Button.main,
                range: NSRange(range, in: fullText)
            )
        }
        attributedText = mutableAttributedString
    }
}
