import UIKit

final class MainButton: BaseButton {
    let detailsLabel = Label(
        font: Fonts.caption2Regular,
        textColor: Color.TabBar.selection,
        textAlignment: .left
    )

    init(title: String?) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setup()
    }

    convenience init(title: String?, image: UIImage?) {
        self.init(title: title)
        setImage(image, for: .normal)
        if title != nil {
            setImagePadding()
        }
    }

    convenience init(title: String?, detailsTitle: String?) {
        self.init(title: title)
        detailsLabel.text = detailsTitle
        addDetailsTitle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCornerRadius(_ radius: CGFloat) {
        cornerRadius(radius)
    }

    func imageSize(_ size: CGSize) {
        imageView?.snp.makeConstraints { make in
            make.size.equalTo(size)
        }
    }

    private func setup() {
        setTitleColor(Color.Text.primaryButton, for: .normal)
        tintColor = Color.Content.primaryButton
        titleLabel?.font = Fonts.title
        backgroundColor = Color.Button.main
        cornerRadius(16)
    }

    private func addDetailsTitle() {
        addSubview(detailsLabel)
        titleLabel?.font = Fonts.caption1Bold
        detailsLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        titleLabel?.textAlignment = .right
        titleLabel?.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }

    private func setImagePadding() {
        imageView?.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(40)
        }
        titleLabel?.textAlignment = .center
        titleLabel?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
