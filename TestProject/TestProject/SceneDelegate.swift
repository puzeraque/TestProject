//
//  SceneDelegate.swift
//  TestProject
//
//  Created by Alexander Putsikovich on 13.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)

        guard let window = self.window else { return }
        let rootNavigationController = UINavigationController()
        let mainCoordinator = MainFlowCoordinator(
            window: window,
            navigationController: rootNavigationController
        )
        mainCoordinator.start()
    }
}

