import UIKit

final class Alert: BaseView {
    private let titleLabel = Label(
        font: Fonts.subtitleBold,
        textColor: Color.Text.primaryButton,
        textAlignment: .left
    )

    override func setup() {
        alpha = .zero

        addSubview(titleLabel)
        setupLayout()
    }

    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}

extension Alert: Configurable {
    typealias Model = AlertType

    func configure(with model: AlertType) {
        switch model {
        case .error(let title):
            backgroundColor(Color.Main.sale)
            titleLabel.text = title
        case .base(let title):
            backgroundColor(Color.Button.main)
            titleLabel.text = title
        }
    }
}
