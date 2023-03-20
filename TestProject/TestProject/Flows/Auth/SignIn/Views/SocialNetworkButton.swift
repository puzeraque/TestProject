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
            return Image.Auth.apple.image
        case .google:
            return Image.Auth.google.image
        }
    }
}

final class SocialNetworkButton: BaseView {
    private let imageView: UIImageView = {
        $0.tintColor = Color.Content.primary
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())
    private let titleLabel = Label(
        font: Fonts.subtitleRegular,
        textColor: Color.Text.primary
    )

    override func setup() {
        super.setup()
        backgroundColor(.clear)
        titleLabel.backgroundColor(.clear)
        
        let stackView = StackView(axis: .horizontal, spacing: 6)
        stackView.addArrangedSubviews(imageView, titleLabel)

        imageView.size(.square(34))
        addAndEdges(stackView)
    }
}

extension SocialNetworkButton: Configurable {
    typealias Model = SocialNetworkButtonType

    func configure(with model: SocialNetworkButtonType) {
        imageView.image = model.image
        titleLabel.text = model.title
    }
}
