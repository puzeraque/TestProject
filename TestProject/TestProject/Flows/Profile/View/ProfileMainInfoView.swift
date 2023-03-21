import UIKit

final class ProfileMainInfoView: BaseView {
    private let imageView: BaseImageView = {
        $0.size(.square(64))
        $0.border(width: 1, color: Color.Background.secondary)
        $0.cornerRadius(32)
        return $0
    }(BaseImageView())
    private let changePhotoLabel = Label(
        text: "Change photo",
        font: Fonts.caption3,
        textColor: Color.Text.secondary,
        textAlignment: .center
    )
    private let fullNameLabel = Label(
        font: Fonts.title,
        textColor: Color.Text.primary,
        textAlignment: .center
    )
    private let uploadItemButton: MainButton = {
        $0.height(48)
        $0.setCornerRadius(16)
        return $0
    }(
        MainButton(
            title: "Upload item",
            image: Image.Profile.repeat.image
        )
    )
    private lazy var imageStackView = StackView(
        axis: .vertical,
        spacing: 6,
        arrangedSubviews: [imageView, changePhotoLabel]
    )
    private let imageStackViewContainer = BaseView()

    var onIconTapped: VoidHandler?

    override func setup() {
        super.setup()
        imageStackViewContainer.addSubview(imageStackView)

        let contentStackView = StackView(
            axis: .vertical,
            arrangedSubviews: [
                imageStackViewContainer,
                fullNameLabel,
                uploadItemButton
            ]
        )
        contentStackView.setCustomSpacing(16, after: imageStackViewContainer)
        contentStackView.setCustomSpacing(32, after: fullNameLabel)

        addAndEdgesViewWithInsets(contentStackView, hInset: 40, vInset: 10)
        setupLayout()

        imageView.onTap { [weak self] in
            self?.onIconTapped?()
        }

        uploadItemButton.onTap {
            AlertService.center.show(.base(title: "Upload item"))
        }
    }

    private func setupLayout() {
        imageStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension ProfileMainInfoView: Configurable {
    struct Model {
        let icon: UIImage?
        let fullName: String?
    }

    func configure(with model: Model) {
        imageView.image = model.icon ?? Image.TabBar.user.image
        imageView.clipsToBounds = true
        fullNameLabel.text = model.fullName
        guard model.icon == nil else { return }
        imageView.tintColor = Color.Content.primary
    }
}
