import UIKit
import SnapKit

protocol SignInViewControllerInterface {
    func handle(_ action: SignInViewController.Action)
}
final class SignInViewController: UIViewController {

    private let mainStackView = StackView(axis: .vertical, spacing: 36)
    private let signInLabel = Label(
        text: "Sign In",
        font: Fonts.h1,
        textColor: Color.Text.primary,
        textAlignment: .center
    )
    private let firstNameTextFieldContainer = BaseTextFieldContainer(placeholder: "First Name")
    private let secondNameTextFieldContainer = BaseTextFieldContainer(placeholder: "Second Name")
    private let mailTextFieldContainer = BaseTextFieldContainer(placeholder: "Email")
    private let signInButton = MainButton(title: "Sign In")
    private let logInTextLabel = Label(
        text: "Already have an account?",
        font: Fonts.caption1,
        textColor: Color.Text.secondary,
        textAlignment: .left
    )
    private let logInButton: BaseButton = {
        $0.setTitle("Log in", for: .normal)
        $0.setTitleColor(Color.Button.main, for: .normal)
        $0.titleLabel?.font = Fonts.caption1
        return $0
    }(BaseButton())

    private let socialStackViewContainer = BaseView()
    private let socialStackView = StackView(axis: .vertical, spacing: 20)
    private let googleButton = SocialNetworkButton()
    private let appleButton = SocialNetworkButton()

    var onLoginTapped: VoidHandler?
    var onSignInTapped: VoidHandler?

    private let viewModel: SignInViewModelInterface

    init(viewModel: SignInViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor(Color.Background.main)

        mainStackView.addArrangedSubviews(
            signInLabel,
            firstNameTextFieldContainer,
            secondNameTextFieldContainer,
            mailTextFieldContainer,
            signInButton
        )
        mainStackView.setCustomSpacing(84, after: signInLabel)

        let logInStackView = StackView(axis: .horizontal, spacing: 6)
        logInStackView.addArrangedSubviews(logInTextLabel, logInButton, UIView())
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
        signInButton.setCornerRadius(16)
        signInButton.onTap { [weak self] in
            guard let self = self else { return }
            let model = ProfileModel(
                firstName: self.firstNameTextFieldContainer.text.orEmpty,
                secondName: self.secondNameTextFieldContainer.text.orEmpty,
                email: self.mailTextFieldContainer.text.orEmpty
            )
            self.viewModel.handle(.saveAccount(model))
        }

        googleButton.onTap {
            AlertService.center.show(.base(title: "Google Auth"))
        }

        appleButton.onTap {
            AlertService.center.show(.base(title: "Apple Auth"))
        }

        firstNameTextFieldContainer.onShouldReturn = { [weak self] in
            self?.secondNameTextFieldContainer.becomeFirstResponder()
        }
        secondNameTextFieldContainer.onShouldReturn = { [weak self] in
            self?.mailTextFieldContainer.becomeFirstResponder()
        }
        mailTextFieldContainer.onShouldReturn = { [weak self] in
            self?.mailTextFieldContainer.resignFirstResponder()
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
            if self.view.frame.origin.y == .zero {
                let value = keyboardSize.minY - self.signInButton.frame.maxY
                view.frame.origin.y -= value
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != .zero {
            self.view.frame.origin.y = .zero
        }
    }
}

extension SignInViewController: SignInViewControllerInterface {
    enum Error {
        case validationError
        case emptyFields
        case accountExist

        var title: String {
            switch self {
            case .validationError:
                return "Email is not valid"
            case .emptyFields:
                return "Empty fields"
            case .accountExist:
                return "Account with this email exists"
            }
        }
    }
    enum Action {
        case authSuccess
        case error(SignInViewController.Error)
    }

    func handle(_ action: Action) {
        switch action {
        case .authSuccess:
            onSignInTapped?()
        case .error(let error):
            AlertService.center.show(.error(title: error.title))
        }
    }
}
