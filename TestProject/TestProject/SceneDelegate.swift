import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let routeService = RouteService()
    private var mainCoordinator: AppFlowCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        routeService.window = self.window

        let mainCoordinator = AppFlowCoordinator(routeService: routeService)
        self.mainCoordinator = mainCoordinator
        mainCoordinator.start()
    }
}

