//
//  SceneDelegate.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

protocol Coordinator {
    var router: UIViewController { get }
    func start()
}

class AppCoordinator: Coordinator {
    var router: UIViewController {
        return navc
    }
    
    private let navc: UINavigationController
    
    init(router: UINavigationController) {
        self.navc = router
    }
    
    private var savingPlan = SavingPlan(name: "", initialAmount: 0)
    
    func start() {
        let vc = WriteDownPlanUIComposer
            .compose(onNext: { [unowned self] planName in
                savingPlan.name = planName
                pushToSetAmountScene()
            })
        
        navc.setViewControllers([vc], animated: false)
    }
    
    private func pushToSetAmountScene() {
        let vc = SetAmountUIComposer
            .compose(onNext: { [unowned self] planAmount in
                savingPlan.initialAmount = planAmount.initialAmount
                pushToSavingScene()
            })
        
        navc.pushViewController(vc, animated: true)
    }
    
    private func pushToSavingScene() {
        let vc = SavingUIComposer
            .compose(model: savingPlan, onNext: {
                
            })
        
        navc.present(vc, animated: true, completion: nil)
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var coordinator: Coordinator = {
        let navc = UINavigationController()
        return AppCoordinator(router: navc)
    }()
    
    convenience init(coordinator: Coordinator) {
        self.init()
        self.coordinator = coordinator
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        configureRootViewController()
    }
    
    func configureRootViewController() {
        coordinator.start()
        window?.rootViewController = coordinator.router
        window?.makeKeyAndVisible()
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


}

