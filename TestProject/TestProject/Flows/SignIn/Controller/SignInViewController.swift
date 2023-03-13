import UIKit
import SnapKit

final class SignInViewController: UIViewController {

    private let signInLabel = UILabel()

    private let textField = BaseTextLabel()
    private let textField2 = BaseTextLabel()
    private let textField3 = BaseTextLabel()

    private let signInButton = UIButton()

    private let logInTextLabel = UILabel()
    private let logInButton = UIButton()

    private let googleButton = SocialNetworkButton()
    private let appleButton = SocialNetworkButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        signInLabel.text = "Sign In"
        signInLabel.font = Fonts.h1
        signInLabel.textColor = Color.Text.primary
        signInLabel.textAlignment = .center

        logInTextLabel.text = "Already have an account?"
        logInTextLabel.font = Fonts.caption1
        logInTextLabel.textColor = Color.Text.secondary
        logInTextLabel.textAlignment = .left

        logInButton.setTitle("Log in", for: .normal)
        logInButton.setTitleColor(Color.Button.main, for: .normal)
        logInButton.titleLabel?.font = Fonts.caption1

        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(Color.Text.primaryButton, for: .normal)
        signInButton.titleLabel?.font = Fonts.title
        signInButton.backgroundColor = Color.Button.main
        signInButton.layer.cornerRadius = 16

        backgroundColor(Color.Background.main)

        let stackView = UIStackView()
        stackView.axis = .vertical

        stackView.addArrangedSubviews(signInLabel, textField, textField2, textField3, signInButton)
        stackView.spacing = 36
        stackView.setCustomSpacing(83, after: signInLabel)

        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.addArrangedSubviews(logInTextLabel, logInButton, UIView())
        hStack.spacing = 6

        stackView.addArrangedSubview(hStack)
        stackView.setCustomSpacing(16, after: signInButton)

        let socialStackView = UIStackView()
        socialStackView.axis = .vertical
        socialStackView.addArrangedSubviews(googleButton, appleButton)
        socialStackView.spacing = 20

        let socialStackViewContainer = UIView()
        socialStackViewContainer.addSubview(socialStackView)
        socialStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        stackView.addArrangedSubview(socialStackViewContainer)
        stackView.setCustomSpacing(40, after: hStack)

        googleButton.configure(with: .google)
        appleButton.configure(with: .apple)

        view.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(36)
        }

        [textField, textField2, textField3].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(32)
            }
        }

        signInButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        logInButton.snp.makeConstraints { make in
            make.height.equalTo(12)
        }
}
}


enum SocialNetworkButtonType {
    case apple
    case google

    var title: String? {
        switch self {
        case .apple:
            return "Sign in with Apple"
        case .google:
            return "Sign in with Google"
        }
    }

    var image: UIImage? {
        switch self {
        case .apple:
            return UIImage(named: "apple")
        case .google:
            return UIImage(named: "google")
        }
    }
}

final class SocialNetworkButton: UIView, Configurable {
    typealias Model = SocialNetworkButtonType

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .clear
        imageView.tintColor = Color.Content.primary
        imageView.contentMode = .scaleAspectFill
        titleLabel.textColor = Color.Text.primary
        titleLabel.font = Fonts.subtitle
        titleLabel.backgroundColor = .clear
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6

        stackView.addArrangedSubviews(imageView, titleLabel)

        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with model: SocialNetworkButtonType) {
        imageView.image = model.image
        titleLabel.text = model.title
    }
}

final class BaseTextLabel: UITextField {

    override var placeholder: String? {
        didSet(newValue) {
            setPlaceHolder(newValue ?? "")
        }
    }
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }

    private func setup() {
        backgroundColor = Color.Background.secondary

    }

    private func setPlaceHolder(_ text: String) {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: centeredParagraphStyle,
                .font: Fonts.caption1
            ]
        )
    }
}
