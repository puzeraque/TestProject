import UIKit

final class MainFlowCoordinator: BaseCoordinator {

    private let navigationController: UINavigationController
    private let window: UIWindow

    private var activeFlowCoordinator: BaseCoordinator?

    init(
        window: UIWindow,
        navigationController: UINavigationController
    ) {
        self.window = window
        self.navigationController = navigationController

        self.window.rootViewController = self.navigationController
    }

    override func start() {
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }

        let coordinator = AuthCoordinator(navigationController: navigationController)
        addDependency(coordinator)
        activeFlowCoordinator = coordinator
        coordinator.start()
    }
}
