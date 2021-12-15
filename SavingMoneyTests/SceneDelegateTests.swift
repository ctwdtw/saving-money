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

}
