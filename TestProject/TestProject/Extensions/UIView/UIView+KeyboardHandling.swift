import UIKit

typealias KeyboardActionHandler = (KeyboardAction) -> Void

enum KeyboardAction: Equatable {
    case willHide
    case willShow(_ height: CGFloat)

    static func ==(lhs: KeyboardAction, rhs: KeyboardAction) -> Bool {
        switch (lhs, rhs) {
        case (.willShow, .willHide), (.willHide, .willShow):
            return false
        default:
            return true
        }
    }
}

enum KeyboardActionBehaviour {
    case none
    case translateY
    case action(_ action: KeyboardActionHandler)
}

extension UIView {

    @discardableResult
    func listenToKeyboard(_ behaviour: KeyboardActionBehaviour) -> Self {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardNotification),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardNotification),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        return self
    }

    @objc private func handleKeyboardNotification(_ notification: Notification) {

        guard let userInfo: [AnyHashable: Any] = notification.userInfo,
              let keyboardFrame: CGRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        let keyboardAction: KeyboardAction = notification.name == UIResponder.keyboardWillShowNotification ? .willShow(keyboardFrame.height) : .willHide

        var innerKeyboardActionBehaviour: KeyboardActionBehaviour?

        switch innerKeyboardActionBehaviour {
        case .translateY:
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.transform = keyboardAction == .willHide ? .identity : CGAffineTransform(translationX: 0, y: -keyboardFrame.height)
            }
        case .action(let action):
            action(keyboardAction)
        case .none, .some:
            break
        }
    }
}
