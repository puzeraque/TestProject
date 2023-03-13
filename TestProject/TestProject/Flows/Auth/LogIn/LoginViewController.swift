import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private let mainStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 36
        return $0
    }(UIStackView())

    private let signInLabel: UILabel = {
        $0.text = "Welcome back"
        $0.font = Fonts.h1
        $0.textColor = Color.Text.primary
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private lazy var firstNameTextFieldContainer: BaseTextViewContainer = {
        $0.textField.placeholder("First Name")
        $0.textField.delegate = self
        return $0
    }(BaseTextViewContainer())
    private lazy var passwordTextFieldContainer: BaseTextViewContainer = {
        $0.textField.placeholder("Password")
        $0.textField.isSecureTextEntry = true
        $0.textField.delegate = self
        return $0
    }(BaseTextViewContainer())

    private let loginButton: BaseButton = {
        $0.setTitle("Login", for: .normal)
        $0.setTitleColor(Color.Text.primaryButton, for: .normal)
        $0.titleLabel?.font = Fonts.title
        $0.backgroundColor = Color.Button.main
        $0.layer.cornerRadius = 16
        return $0
    }(BaseButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setupWhiteNavigationAppearance(backgroundColor: Color.Background.main)
        navigationController?.removeBackButtonTitle()
        backgroundColor(Color.Background.main)

        mainStackView.addArrangedSubviews(
            signInLabel,
            firstNameTextFieldContainer,
            passwordTextFieldContainer,
            loginButton
        )
        mainStackView.setCustomSpacing(84, after: signInLabel)
        mainStackView.setCustomSpacing(100, after: passwordTextFieldContainer)

        view.addSubview(mainStackView)

        setupLayout()
        setupListeners()
    }

    private func setupLayout() {
        loginButton.height(48)

        mainStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }

        [
            firstNameTextFieldContainer,
            passwordTextFieldContainer
        ].forEach {
            $0.height(32)
        }
    }

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
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                let value = keyboardSize.minY - self.loginButton.frame.maxY
                view.frame.origin.y -= value
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextFieldContainer.textField {
            passwordTextFieldContainer.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
