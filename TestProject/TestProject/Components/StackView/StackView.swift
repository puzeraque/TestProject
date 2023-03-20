import UIKit

final class StackView: UIStackView {

    init(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat? = nil,
        arrangedSubviews: [UIView]? = nil
    ) {
        super.init(frame: .zero)
        self.axis = axis
        if let spacing = spacing {
            self.spacing = spacing
        }
        if let arrangedSubviews = arrangedSubviews {
            addArrangedSubviews(arrangedSubviews)
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
