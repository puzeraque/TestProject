import UIKit

class TabBarView: BaseView {

    var selectedType: TabBarItemType = .home

    var onSelectedAction: TabBarActionHandler?

    private let selectionView: BaseView = {
        $0.cornerRadius(18)
        return $0
    }(BaseView(backgroundColor: Color.TabBar.selection))

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
                self?.setSelectionViewPosition()
            }
            tabBarItems[tabType] = tabBarItem
            stackView.addArrangedSubview(tabBarItem)
        }

        addSubviews(selectionView, stackView)
        setupLayout()
        setSelectionViewPosition(animated: false)
    }

    private func setupLayout() {
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }

    private func setSelectionViewPosition(animated: Bool = true) {
        guard
            let view = tabBarItems.first(
                where: { $0.key == self.selectedType }
            )
        else { return }
        selectionView.snp.remakeConstraints {
            $0.center.equalTo(view.value)
            $0.size.equalTo(36)
        }
        guard animated else { return }
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.layoutIfNeeded()
        }
    }

    func setSelected(_ type: TabBarItemType) {
        selectedType = type
        tabBarItems.forEach { [weak self] type, view in
            guard let self = self else { return }
            view.isSelected = type == self.selectedType
        }
        setSelectionViewPosition(animated: true)
        onSelectedAction?(type)
    }
}
