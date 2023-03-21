import UIKit

final class AuthCoordinator: BaseCoordinator {
    
    private lazy var coordinator = TabBarFlowCoordinator(routeService: routeService)
    private let navigationController: UINavigationController
    private let routeService: RouteService
    
    init(routeService: RouteService) {
        self.routeService = routeService
        self.navigationController = routeService.rootNavigationController
    }
    
    override func start() {
        super.start()
        presentSignIn()
    }

    private func presentSignIn() {
        let controller = SignInViewControllerAssembler.assembly()
        controller.onLoginTapped = { [weak self] in
            self?.presentLogin()
        }
        controller.onSignInTapped = { [weak self] in
            self?.presentProfile()
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func presentLogin() {
        let controller = LoginViewControllerAssembler.assembly()
        controller.onLoginTapped = { [weak self] in
            self?.presentProfile()
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func presentProfile() {
        addDependency(coordinator)
        coordinator.start()
        coordinator.onFinish = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(self.coordinator)
            self.routeService.window?.rootViewController = self.navigationController
            self.presentSignIn()
        }
    }
}
