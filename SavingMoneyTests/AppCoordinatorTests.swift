//
//  AppCoordinatorTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/21.
//

import XCTest
@testable import SavingMoney

class AppCoordinatorTests: XCTestCase {
    func test_navigation() {
        let (sut, router) = makeSUT()
        
        sut.start()
        let writeDownPlan = router.topViewController as? WriteDownPlanViewController
        writeDownPlan?.loadViewIfNeeded()
        XCTAssertNotNil(writeDownPlan, "First Scene is WriteDownPlan Scene")
        
        writeDownPlan?.simulateTapNext()
        router.view.forceLayout()
        
        let setAmount = router.topViewController as? SetAmountViewController
        setAmount?.loadViewIfNeeded()
        XCTAssertNotNil(setAmount, "Tap next route to SetAmount Scene")
        
        setAmount?.simulateTapNext()
        router.view.forceLayout()
        
        let saving = router.topViewController as? SavingViewController
        saving?.loadViewIfNeeded()
        XCTAssertNotNil(saving, "Tap next again route to Saving Scene")
    }
    
    private func makeSUT() -> (AppCoordinator, RouterSpy) {
        let routerSpy = RouterSpy()
        let sut = AppCoordinator(router: routerSpy)
        return (sut, routerSpy)
        
    }
}

private class RouterSpy: UINavigationController {
    
}
