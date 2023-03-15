import UIKit

extension UIStackView {
    @discardableResult
    func addArrangedSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach { subview in
            addArrangedSubview(subview)
        }
        return self
    }

    @discardableResult
    func addArrangedSubviews(_ subviews: [UIView]) -> Self {
        subviews.forEach { subview in
            addArrangedSubview(subview)
        }
        return self
    }

    @discardableResult
    func removeArrangedSubviews() -> Self {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
            removeArrangedSubview($0)
        }
        return self
    }
}
