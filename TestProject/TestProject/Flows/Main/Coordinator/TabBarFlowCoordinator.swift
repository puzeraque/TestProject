import UIKit

final class TabBarFlowCoordinator: BaseCoordinator {
    private var window: UIWindow?
    private var tabBarViewController: BaseTabBarViewController?
    private var activeViewController: UIViewController?

    private let requestManager: RequestsProtocol
    private let profileViewController: ProfileViewController
    private let routeService: RouteService

    var onFinish: VoidHandler?

    init(routeService: RouteService) {
        self.requestManager = Requests()
        self.routeService = routeService
        self.profileViewController = ProfileViewAssembler.assembly()
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
        self.tabBarViewController = tabBarViewController
        let navigationController = UINavigationController(
            rootViewController: tabBarViewController
        )
        navigationController.setNavigationBarHidden(true, animated: true)

        if let currentWindowScene = UIApplication.shared.connectedScenes.first as?  UIWindowScene {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.windowScene = currentWindowScene
        }

        window?.backgroundColor(Color.Background.main)
        window?.windowLevel = UIWindow.Level.normal + 1

        window?.rootViewController = navigationController

        window?.makeKeyAndVisible()
        window?.fadeIn()

        profileViewController.onLogoutTapped = { [weak self] in
            self?.finishFlow()
        }
    }

    private func finishFlow() {
        onFinish?()
        window?.fadeOut { [weak self] in
            self?.window?.isHidden = true
            self?.window = nil
        }
    }

    private func mainPageViewController() -> MainPageViewController {
        let mainPageViewController = MainPageAssembler.assembly(
            requestManager: requestManager
        )
        mainPageViewController.onProductSelected = { [weak self] in
            guard let self = self else { return }
            let productDetailsController = ProductDetailsAssembler.assembly(
                requestManager: self.requestManager
            )
            self.routeService.mainFlowNavigationController.pushViewController(
                productDetailsController,
                animated: true
            )
            self.activeViewController = productDetailsController
        }

        mainPageViewController.onProfileTapped = { [weak self] in
            self?.tabBarViewController?.setSelected(.profile)
        }
        return mainPageViewController
    }

    private func createTabBarViewController() -> BaseTabBarViewController {
        let tabBarViewController = BaseTabBarViewController()
        tabBarViewController.setViewControllers(
            [
                routeService.mainFlowNavigationController,
                profileViewController
            ],
            animated: true
        )
        tabBarViewController.onSelectedController = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .home:
                let controller = self.routeService.mainFlowNavigationController
                guard tabBarViewController.selectedViewController != controller else {
                    guard self.activeViewController != nil else { return }
                    self.routeService.mainFlowNavigationController.popViewController(animated: true)
                    return
                }
                tabBarViewController.selectedViewController = controller
            case .profile:
                let controller = self.profileViewController
                guard tabBarViewController.selectedViewController != controller else { return }
                tabBarViewController.selectedViewController = controller
            default:
                break
            }
        }

        return tabBarViewController
    }
}
