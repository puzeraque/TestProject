import UIKit

final class ProfileSegueViewCell: BaseTableViewCell {
    private let iconImageView: UIImageView = {
        $0.size(.square(20))
        $0.tintColor = Color.Content.primary
        return $0
    }(UIImageView())
    private let titleLabel = Label(
        font: Fonts.subtitle,
        textColor: Color.Text.primary,
        textAlignment: .left
    )
    private let chevronImageView: UIImageView = {
        $0.image = Image.Main.chevron.image
        $0.tintColor = Color.Content.primary
        return $0
    }(UIImageView())
    private let chevronImageContainer = {
        $0.size(.square(64))
        return $0
    }(BaseView())
    private let imageViewContainer: BaseView = {
        $0.size(.square(36))
        $0.cornerRadius(18)
        $0.backgroundColor = Color.Background.secondary
        return $0
    }(BaseView())
    private lazy var mainStackView = StackView(
        axis: .horizontal,
        spacing: 10,
        arrangedSubviews: [
            imageViewContainer,
            titleLabel,
            UIView(),
            chevronImageContainer
        ]
    )

    override func setup() {
        super.setup()
        imageViewContainer.putInCenter(iconImageView)
        chevronImageContainer.addSubview(chevronImageView)

        addAndEdgesViewWithInsets(mainStackView, hInset: 28, vInset: 12)
        setupLayout()
    }

    private func setupLayout() {
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
}

extension ProfileSegueViewCell: Configurable {
    typealias Model = SettingType

    func configure(with model: SettingType) {
        iconImageView.image = model.icon
        titleLabel.text = model.title
    }
}
