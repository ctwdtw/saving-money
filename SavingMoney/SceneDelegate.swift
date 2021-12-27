//
//  SceneDelegate.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var dataStore: DataStore = {
        FileManager.default
    }()
    
    private lazy var savingPlanService: SavingPlanService = {
        LocalSavingPlanLoader(dataStore: dataStore)
    }()
    
    private lazy var coordinator: Coordinator = {
        let navc = UINavigationController()
        return AppCoordinator(
            router: navc,
            savingPlanService: savingPlanService
        )
    }()
    
    convenience init(coordinator: Coordinator) {
        self.init()
        self.coordinator = coordinator
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        //savingPlanService = SuccessSavingPlanLoader() // for testing purpose
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

//MARK: - for testing purpose
class SuccessSavingPlanLoader: SavingPlanLoader, SavingPlanCache {
    func load() throws -> SavingPlan {
        return SavingPlan(name: "好好存錢", startDate: Date(), initialAmount: 10)
    }
    
    func save(_ savingPlan: SavingPlan) throws {
        
    }
}
