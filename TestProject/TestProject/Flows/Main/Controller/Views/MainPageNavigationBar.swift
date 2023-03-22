import UIKit

final class MainPageNavigationBar: BaseView {
    private let imageView: BaseImageView = {
        $0.size(.square(20))
        return $0
    }(BaseImageView(image: Image.Main.menu.image))
    private let profileImageView: BaseImageView = {
        $0.size(.square(30))
        $0.cornerRadius(15)
        $0.border(width: 0.5, color: Color.Content.primary)
        $0.clipsToBounds = true
        return $0
    }(BaseImageView())
    private let locationLabel = Label(
        text: "Location",
        font: Fonts.caption2,
        textColor: Color.Text.primary,
        textAlignment: .left
    )
    private let chevronImageView: BaseImageView = {
        $0.tintColor = Color.Content.primary
        $0.size(.init(width: 6, height: 4))
        return $0
    }(BaseImageView(image: Image.Main.chevronDown.image))
    private let brandLabel = Label(font: Fonts.h4Bold)
    private let locationStackView = StackView(axis: .horizontal, spacing: 4)
    private let profileImageViewContainer = BaseView()
    private lazy var stackView = StackView(
        axis: .vertical,
        spacing: 6,
        arrangedSubviews: [profileImageViewContainer, locationStackView]
    )

    var onProfileTapped: VoidHandler?

    override func setup() {
        super.setup()
        profileImageViewContainer.height(30)
        profileImageViewContainer.addSubview(profileImageView)

        let imageContainer = BaseView()
        imageContainer.width(6)
        imageContainer.putInCenter(chevronImageView)

        locationStackView.addArrangedSubviews(locationLabel, imageContainer)

        brandLabel.changeColorOfPartOfTheText(
            fullText: "Trade by bata",
            partOfTheText: "bata"
        )

        addSubviews(imageView, stackView, brandLabel)

        setupLayout()
        setupHandlers()
    }

    private func setupLayout() {
        profileImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }

        brandLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(stackView)
            make.centerX.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(16)
        }
    }

    private func setupHandlers() {
        imageView.onTap {
            AlertService.center.show(.base(title: "Menu tapped"))
        }
        profileImageView.onTap { [weak self] in
            self?.onProfileTapped?()
        }
    }
}

extension MainPageNavigationBar: Configurable {
    typealias Model = UIImage?

    func configure(with model: UIImage?) {
        profileImageView.image = model ?? Image.TabBar.user.image
        if model == nil {
            profileImageView.tintColor = Color.Content.primary
        }
    }
}
