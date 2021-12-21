//
//  AppCoordinatorTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/21.
//

import XCTest
@testable import SavingMoney

class AppCoordinatorTests: XCTestCase {
    func test_start_setWriteDownPlanSceneOnNavigationStackRoot() {
        let (sut, navigationController) = makeSUT()
        
        sut.start()
        
        XCTAssertTrue(navigationController.viewControllers.first is WriteDownPlanViewController)
    }
    
    private func makeSUT() -> (AppCoordinator, NavigationSpy) {
        let navcSpy = NavigationSpy()
        let sut = AppCoordinator(rootViewController: navcSpy)
        return (sut, navcSpy)
        
    }
}

private class NavigationSpy: UINavigationController {
    
}
