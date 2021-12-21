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
        let (sut, router) = makeSUT()
        
        sut.start()
        
        XCTAssertTrue(router.viewControllers.first is WriteDownPlanViewController)
    }
    
    private func makeSUT() -> (AppCoordinator, RouterSpy) {
        let routerSpy = RouterSpy()
        let sut = AppCoordinator(router: routerSpy)
        return (sut, routerSpy)
        
    }
}

private class RouterSpy: UINavigationController {
    
}
