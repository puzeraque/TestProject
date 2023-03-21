import UIKit

final class BaseTabBarViewController: UITabBarController {
    private let tabBarView = TabBarView()

    var onSelectedController: TabBarActionHandler?

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isHidden = true
        view.backgroundColor(.clear)

        self.view.addSubview(tabBarView)
        tabBarView.snp.makeConstraints { make in
            make.top.equalTo(tabBar.snp.top).offset(-10)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }

        tabBarView.onSelectedAction = { [weak self] type in
            self?.onSelectedController?(type)
        }
    }

    func setSelected(_ type: TabBarItemType) {
        tabBarView.setSelected(type)
    }
}
