import UIKit

class TabBarView: BaseView {

    var selectedType: TabBarItemType = .home

    var onSelectedAction: TabBarActionHandler?

    private let stackView: StackView = {
        $0.distribution = .equalSpacing
        $0.height(36)
        return $0
    }(StackView(axis: .horizontal))

    private var tabBarItems = [TabBarItemType: TabBarItem]()

    override func setup() {
        super.setup()
        backgroundColor(Color.TabBar.background)
        clipsToBounds = true
        cornerRadius(24)
        layer.maskedCorners = [
            .layerMaxXMinYCorner,
            .layerMinXMinYCorner
        ]

        TabBarItemType.allCases.enumerated().forEach { index, tabType in
            let tabBarItem = TabBarItem()
            tabBarItem.configure(with: tabType)
            tabBarItem.isSelected = tabType == selectedType
            tabBarItem.onTap { [weak self] in
                self?.setSelected(tabType)
            }
            tabBarItems[tabType] = tabBarItem
            stackView.addArrangedSubview(tabBarItem)
        }

        addSubview(stackView)
        setupLayout()
    }

    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }

    func setSelected(_ type: TabBarItemType) {
        selectedType = type
        tabBarItems.forEach { [weak self] type, view in
            guard let self = self else { return }
            view.isSelected = type == self.selectedType
        }
        onSelectedAction?(type)
    }
}
