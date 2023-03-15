import UIKit
import SnapKit

final class SignInViewController: UIViewController {

    private let mainStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 36
        return $0
    }(UIStackView())

    private let signInLabel: UILabel = {
        $0.text = "Sign In"
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
    private lazy var secondNameTextFieldContainer: BaseTextViewContainer = {
        $0.textField.placeholder("Second Name")
        $0.textField.delegate = self
        return $0
    }(BaseTextViewContainer())
    private lazy var mailTextFieldContainer: BaseTextViewContainer = {
        $0.textField.placeholder("Email")
        $0.textField.delegate = self
        return $0
    }(BaseTextViewContainer())

    private let signInButton: BaseButton = {
        $0.setTitle("Sign In", for: .normal)
        $0.setTitleColor(Color.Text.primaryButton, for: .normal)
        $0.titleLabel?.font = Fonts.title
        $0.backgroundColor = Color.Button.main
        $0.layer.cornerRadius = 16
        return $0
    }(BaseButton())

    private let logInTextLabel: UILabel = {
        $0.text = "Already have an account?"
        $0.font = Fonts.caption1
        $0.textColor = Color.Text.secondary
        $0.textAlignment = .left
        return $0
    }(UILabel())
    private let logInButton: BaseButton = {
        $0.setTitle("Log in", for: .normal)
        $0.setTitleColor(Color.Button.main, for: .normal)
        $0.titleLabel?.font = Fonts.caption1
        return $0
    }(BaseButton())

    private let socialStackViewContainer = UIView()
    private let socialStackView: UIStackView = {
        $0.spacing = 20
        $0.axis = .vertical
        return $0
    }(UIStackView())
    private let googleButton = SocialNetworkButton()
    private let appleButton = SocialNetworkButton()

    var onLoginTapped: VoidHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.removeBackButtonTitle()
        backgroundColor(Color.Background.main)

        mainStackView.addArrangedSubviews(
            signInLabel,
            firstNameTextFieldContainer,
            secondNameTextFieldContainer,
            mailTextFieldContainer,
            signInButton
        )
        mainStackView.setCustomSpacing(84, after: signInLabel)

        let logInStackView = UIStackView()
        logInStackView.axis = .horizontal
        logInStackView.addArrangedSubviews(logInTextLabel, logInButton, UIView())
        logInStackView.spacing = 6
        mainStackView.setCustomSpacing(40, after: logInStackView)

        mainStackView.addArrangedSubview(logInStackView)
        mainStackView.setCustomSpacing(16, after: signInButton)


        socialStackView.addArrangedSubviews(googleButton, appleButton)
        socialStackViewContainer.addSubview(socialStackView)
        mainStackView.addArrangedSubview(socialStackViewContainer)
        googleButton.configure(with: .google)
        appleButton.configure(with: .apple)
        
        view.addSubview(mainStackView)

        setupLayout()
        setupListeners()

        logInButton.onTap { [weak self] in
            self?.onLoginTapped?()
        }
    }

    private func setupLayout() {
        logInButton.height(12)
        signInButton.height(48)

        mainStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }

        [
            firstNameTextFieldContainer,
            secondNameTextFieldContainer,
            mailTextFieldContainer
        ].forEach {
            $0.height(32)
        }

        socialStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
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
                let value = keyboardSize.minY - self.signInButton.frame.maxY
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

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextFieldContainer.textField {
            secondNameTextFieldContainer.textField.becomeFirstResponder()
        } else if textField == secondNameTextFieldContainer.textField {
            mailTextFieldContainer.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
