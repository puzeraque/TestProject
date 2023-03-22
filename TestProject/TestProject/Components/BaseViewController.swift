import UIKit

class BaseViewController: UIViewController {

    var onKeyboardWillShow: ((CGRect) -> Void)?
    var onKeyboardWillHide: VoidHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
        setupListeners()
    }

    func setup() { }

    func setupLayout() { }

    private func setupListeners() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        hideKeyboardWhenTappedAround()
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue {
            onKeyboardWillShow?(keyboardSize)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        onKeyboardWillHide?()
    }
}
