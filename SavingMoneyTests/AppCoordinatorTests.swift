//
//  AppCoordinatorTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/21.
//

import XCTest
@testable import SavingMoney

class AppCoordinatorTests: XCTestCase {
    func test_routing() {
        let (sut, router) = makeSUT()
        
        sut.start()
        let writeDownPlan = assertPushedTop(is: WriteDownPlanViewController.self, on: router)
        
        writeDownPlan?.simulateTapNext()
        let setAmount = assertPushedTop(is: SetAmountViewController.self, on: router)
    
        setAmount?.simulateTapNext()
        assertPresentedTop(is: SavingViewController.self, on: router)
    }
    
    @discardableResult
    private func assertPushedTop<ViewController: UIViewController>(
        is type: ViewController.Type,
        on router: RouterSpy,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> ViewController? {
        let top = router.pushedViewControllers.last as? ViewController
        XCTAssertNotNil(top, "expect an instance of \(type) but got \(String(describing: router.pushedViewControllers.last))", file: file, line: line)
        return top
    }
    
    @discardableResult
    private func assertPresentedTop<ViewController: UIViewController>(
        is type: ViewController.Type,
        on router: RouterSpy,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> ViewController? {
        let top = router.presentedViewControllers.last as? ViewController
        XCTAssertNotNil(top, "expect an instance of \(type) but got \(String(describing: router.pushedViewControllers.last))", file: file, line: line)
        return top
    }
    
    private func makeSUT() -> (AppCoordinator, RouterSpy) {
        let routerSpy = RouterSpy()
        let sut = AppCoordinator(router: routerSpy)
        return (sut, routerSpy)
    }
}

private class RouterSpy: UINavigationController {
    var pushedViewControllers: [UIViewController] = []
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushedViewControllers.append(viewController)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        //super.setViewControllers(viewControllers, animated: animated)
        guard let first = viewControllers.first else { return }
        pushedViewControllers.append(first)
    }
    
    var presentedViewControllers: [UIViewController] = []
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedViewControllers.append(viewControllerToPresent)
    }
}
