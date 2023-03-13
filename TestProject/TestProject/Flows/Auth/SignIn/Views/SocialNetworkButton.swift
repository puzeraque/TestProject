import UIKit

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

    private let imageView: UIImageView = {
        $0.tintColor = Color.Content.primary
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())
    private let titleLabel: UILabel = {
        $0.textColor = Color.Text.primary
        $0.font = Fonts.subtitle
        $0.backgroundColor = .clear
        return $0
    }(UILabel())

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .clear
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.addArrangedSubviews(imageView, titleLabel)

        imageView.size(.init(width: 34, height: 34))
        addAndEdgesSuperview(stackView)
    }

    func configure(with model: SocialNetworkButtonType) {
        imageView.image = model.image
        titleLabel.text = model.title
    }
}
