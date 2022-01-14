//
//  SceneDelegate.swift
//  Cream
//
//  Created by wankikim-MN on 2022/01/08.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        window?.backgroundColor = .white
                let navigationController = UINavigationController(rootViewController: SignupViewController())
//        let navigationController = UINavigationController(rootViewController: LoginViewController())
        navigationController.navigationBar.prefersLargeTitles = true
        //        navigationController.navigationItem.title = "회원가입"
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}

