import UIKit

final class AppFlowCoordinator: BaseCoordinator {
    private let routeService: RouteService

    private var activeFlowCoordinator: BaseCoordinator?

    init(routeService: RouteService) {
        self.routeService = routeService
        self.routeService.window?.rootViewController = routeService.rootNavigationController
    }

    override func start() {
        guard let window = routeService.window else { return }
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }

        let coordinator = AuthCoordinator(routeService: routeService)
        addDependency(coordinator)
        activeFlowCoordinator = coordinator
        coordinator.start()
    }
}
