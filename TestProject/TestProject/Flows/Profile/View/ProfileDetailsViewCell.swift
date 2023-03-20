import UIKit

final class ProfileDetailsViewCell: BaseTableViewCell {
    private let iconImageView: BaseImageView = {
        $0.tintColor = Color.Content.primary
        $0.size(.square(20))
        return $0
    }(BaseImageView())
    private let titleLabel = Label(
        font: Fonts.subtitle,
        textColor: Color.Text.primary,
        textAlignment: .left
    )
    private let detailsTitleLabel = Label(
        font: Fonts.subtitle,
        textColor: Color.Text.primary,
        textAlignment: .right
    )
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
            detailsTitleLabel
        ]
    )

    override func setup() {
        super.setup()
        imageViewContainer.putInCenter(iconImageView)

        addAndEdgesViewWithInsets(mainStackView, hInset: 28, vInset: 12)
    }
}

extension ProfileDetailsViewCell: Configurable {
    typealias Model = SettingType

    func configure(with model: SettingType) {
        iconImageView.image = model.icon
        titleLabel.text = model.title
        detailsTitleLabel.text = "$ 1999"
    }
}
