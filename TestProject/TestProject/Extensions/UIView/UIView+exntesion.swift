import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            self.addSubview($0)
        }
    }

    func backgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }

    func cornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }

    func border(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

    func fadeIn(duration: TimeInterval? = 0.2,
                delay: TimeInterval = .zero,
                then: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? .zero,
                       delay: delay,
                       animations: alphaAnimation(to: 1),
                       completion: wrapped(completion: then))
    }

    func fadeOut(duration: TimeInterval? = 0.2,
                 delay: TimeInterval = .zero,
                 then: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? .zero,
                       delay: delay,
                       animations: alphaAnimation(to: .zero),
                       completion: wrapped(completion: then))
    }

    private func wrapped(completion: (() -> Void)?) -> ((Bool) -> Void)? {
        guard let completion = completion else {
            return nil
        }
        return { _ in
            completion()
        }
    }

    private func alphaAnimation(to alpha: CGFloat) -> () -> Void {
        return { [weak self] in
            self?.alpha = alpha
        }
    }
}
