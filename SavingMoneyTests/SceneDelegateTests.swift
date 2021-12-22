//
//  SceneDelegateTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/15.
//

import XCTest
@testable import SavingMoney

class SceneDelegateTests: XCTestCase {

    func test_sceneWillConnectToSession_configureRootViewController() {
        let sut = SceneDelegate()
        sut.window = UIWindow()
        
        sut.configureRootViewController()
        
        let root = sut.window?.rootViewController as? UINavigationController
        XCTAssertNotNil(root, "Expected `UINavigationController` as root, got \(String(describing: root)) instead")
        
        let top = root?.topViewController as? WriteDownPlanViewController
        XCTAssertNotNil(top, "Expected `WriteDownPlanViewController` as root of `UINavigationController`, got \(String(describing: top)) instead")
    }
    
    func test_sceneWillConnectToSession_messageAppCoordinatorStart() {
        let (sut, coordinator) = makeSUT()
        sut.window = UIWindow()
        sut.configureRootViewController()
        
        XCTAssertEqual(coordinator.startCallCount, 1)
    }
    
    private func makeSUT() -> (SceneDelegate, CoordinatorSpy) {
        let coordinator = CoordinatorSpy()
        let sut = SceneDelegate(coordinator: coordinator)
        return (sut, coordinator)
    }

}

private class CoordinatorSpy: Coordinator {
    var router: UIViewController = UIViewController()
    
    var startCallCount = 0
    func start() {
        startCallCount += 1
    }
}
