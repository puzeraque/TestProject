import UIKit

final class TabBarFlowCoordinator: BaseCoordinator {
    private let requestManager: RequestsProtocol
    private var tabBarViewController: BaseTabBarViewController?
    private let profileViewController = ProfileViewAssembler.assembly()
    private var window: UIWindow?
    private let routeService: RouteService

    var onFinish: VoidHandler?

    init(routeService: RouteService) {
        self.requestManager = Requests()
        self.window = routeService.window
        self.routeService = routeService
        super.init()
    }

    override func start() {
        super.start()
        presentTabBar()
    }

    private func presentTabBar() {
        let mainPageViewController = mainPageViewController()
        routeService.mainFlowNavigationController = UINavigationController(rootViewController: mainPageViewController)
        routeService.mainFlowNavigationController.setupNavigationAppearance(backgroundColor: .clear)

        let tabBarViewController = createTabBarViewController()
        let navigationController = UINavigationController(rootViewController: tabBarViewController)
        self.tabBarViewController = tabBarViewController
        window?.rootViewController = navigationController

        profileViewController.onLogoutTapped = { [weak self] in
            self?.onFinish?()
        }
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    private func mainPageViewController() -> MainPageViewController {
        let mainPageViewController = MainPageAssembler.assembly(requestManager: requestManager)
        mainPageViewController.onProductSelected = { [weak self] in
            guard let self = self else { return }
            let productDetailsController = ProductDetailsAssembler.assembly(
                requestManager: self.requestManager
            )
            self.routeService.mainFlowNavigationController.pushViewController(productDetailsController, animated: true)
        }

        mainPageViewController.onProfileTapped = { [weak self] in
            self?.tabBarViewController?.setSelected(.profile)
        }
        return mainPageViewController
    }

    private func createTabBarViewController() -> BaseTabBarViewController {
        let tabBarViewController = BaseTabBarViewController()
        tabBarViewController.setViewControllers(
            [routeService.mainFlowNavigationController, profileViewController],
            animated: true
        )
        tabBarViewController.onSelectedController = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .home:
                tabBarViewController.selectedViewController = self.routeService.mainFlowNavigationController
            case .profile:
                tabBarViewController.selectedViewController = self.profileViewController
            default:
                break
            }
        }

        return tabBarViewController
    }
}
