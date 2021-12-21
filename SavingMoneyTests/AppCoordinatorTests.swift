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
        let writeDownPlan = assertTop(is: WriteDownPlanViewController.self, on: router)
        
        writeDownPlan?.simulateTapNext()
        let setAmount = assertTop(is: SetAmountViewController.self, on: router)
    
        setAmount?.simulateTapNext()
        assertTop(is: SavingViewController.self, on: router)
    }
    
    @discardableResult
    private func assertTop<ViewController: UIViewController>(
        is type: ViewController.Type,
        on router: UINavigationController,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> ViewController? {
        let top = router.topViewController as? ViewController
        top?.loadViewIfNeeded()
        XCTAssertNotNil(top, file: file, line: line)
        return top
    }
    
    private func makeSUT() -> (AppCoordinator, RouterSpy) {
        let routerSpy = RouterSpy()
        let sut = AppCoordinator(router: routerSpy)
        return (sut, routerSpy)
        
    }
}

private class RouterSpy: UINavigationController {}
