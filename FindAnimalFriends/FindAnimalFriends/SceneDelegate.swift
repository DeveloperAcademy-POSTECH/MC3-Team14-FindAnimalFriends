//
//  SceneDelegate.swift
//  FindAnimalFriends
//
//  Created by Hyeonsoo Kim on 2022/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.window?.rootViewController = UINavigationController(rootViewController: LaunchScreenController())
        }
        //출처: https://hongssup.tistory.com/150
        //근거 - sleep은 Thread를 멈춰서 앱 자체를 delay시키는 것이기에, DispatchQueue를 이용해서 비동기로 지연해주는 것이 좋다고 한다.
        self.window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func moveVC(nibName : String) {
        if nibName == "WebViewController" {
            let webVC = LaunchScreenController(nibName: nibName, bundle: nil)
            let navigationController = UINavigationController(rootViewController: webVC)
            navigationController.navigationBar.isHidden = true
            self.window?.rootViewController = navigationController
        } else if nibName == "LaunchScreen" {
            self.window?.rootViewController = UIStoryboard(name: nibName, bundle: nil).instantiateInitialViewController()
        }
        self.window?.makeKeyAndVisible()
    }
    
}

