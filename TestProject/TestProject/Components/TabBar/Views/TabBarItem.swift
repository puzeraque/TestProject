import UIKit

final class TabBarItem: BaseView {
    var isSelected = false {
        didSet {
            updateUi()
        }
    }

    private let imageView: UIImageView = {
        $0.tintColor = Color.Text.secondary
        return $0
    }(UIImageView())

    override func setup() {
        super.setup()
        cornerRadius(16)
        size(.square(36))

        addSubview(imageView)
        setupLayout()
    }

    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(20)
        }
    }

    private func updateUi() {
        imageView.tintColor = isSelected
        ? Color.Text.selection
        : Color.Text.secondary
    }
}

extension TabBarItem: Configurable {
    typealias Model = TabBarItemType

    func configure(with model: TabBarItemType) {
        imageView.image = model.image
    }
}
