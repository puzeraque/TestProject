import UIKit
import SnapKit

protocol LoginViewControllerInterface {
    func handle(_ action: LoginViewController.Action)
}

final class LoginViewController: BaseViewController {

    private let mainStackView = StackView(axis: .vertical, spacing: 36)
    private let signInLabel = Label(
        text: "Welcome back",
        font: Fonts.h1,
        textColor: Color.Text.primary,
        textAlignment: .center
    )
    private let mailTextFieldContainer = BaseTextFieldContainer(placeholder: "Email")
    private lazy var passwordTextFieldContainer: BaseTextFieldContainer = {
        $0.setupSecureView()
        return $0
    }(BaseTextFieldContainer(placeholder: "Password"))

    private let loginButton = MainButton(title: "Login")

    var onLoginTapped: VoidHandler?

    private let viewModel: LoginViewModelInterface

    init(viewModel: LoginViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setup() {
        super.setup()
        navigationController?.setupNavigationAppearance()
        view.backgroundColor(Color.Background.main)

        mainStackView.addArrangedSubviews(
            signInLabel,
            mailTextFieldContainer,
            passwordTextFieldContainer,
            loginButton
        )
        mainStackView.setCustomSpacing(84, after: signInLabel)
        mainStackView.setCustomSpacing(100, after: passwordTextFieldContainer)

        view.addSubview(mainStackView)

        loginButton.setCornerRadius(16)
        loginButton.height(48)

        setupHandlers()
    }

    override func setupLayout() {
        super.setupLayout()
        mainStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }
        mailTextFieldContainer.height(32)
        passwordTextFieldContainer.height(32)
    }

    private func setupHandlers() {
        loginButton.onTap { [weak self] in
            guard let self = self else { return }
            self.viewModel.handle(
                .login(
                    .init(
                        email: self.mailTextFieldContainer.text.orEmpty,
                        password: self.passwordTextFieldContainer.text.orEmpty
                    )
                )
            )
        }

        mailTextFieldContainer.onShouldReturn = { [weak self] in
            self?.passwordTextFieldContainer.becomeFirstResponder()
        }
        passwordTextFieldContainer.onShouldReturn = { [weak self] in
            self?.passwordTextFieldContainer.resignFirstResponder()
        }

        onKeyboardWillShow = { [weak self] keyboardSize in
            guard let self = self else { return }
            if self.view.frame.origin.y == .zero {
                let value = keyboardSize.minY - self.loginButton.frame.maxY
                self.view.frame.origin.y -= value
            }
        }
        onKeyboardWillHide = { [weak self] in
            guard let self = self else { return }
            if self.view.frame.origin.y != .zero {
                self.view.frame.origin.y = .zero
            }
        }
    }
}

extension LoginViewController: LoginViewControllerInterface {
    enum Error {
        case accountDoestExist
        case emailDoestMatch
        case validationError
        case emptyFields

        var title: String {
            switch self {
            case .accountDoestExist:
                return "Account doest exist"
            case .emailDoestMatch:
                return "Email doest match"
            case .validationError:
                return "Email is not valid"
            case .emptyFields:
                return "Empty fields"
            }
        }
    }

    enum Action {
        case error(LoginViewController.Error)
        case success
    }

    func handle(_ action: Action) {
        switch action {
        case .error(let error):
            AlertService.center.show(.error(title: error.title))
        case .success:
            onLoginTapped?()
        }
    }
}
