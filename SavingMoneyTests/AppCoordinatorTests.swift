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
        let saving = assertPresentedTop(is: SavingViewController.self, on: router)
        
        saving?.simulatePressReStart()
        assertPushedTop(is: WriteDownPlanViewController.self, on: router)
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
        with style: UIModalPresentationStyle = .fullScreen,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> ViewController? {
        let top = router.presentedViewControllers.last as? ViewController
        XCTAssertNotNil(top, "expect an instance of \(type) but got \(String(describing: router.pushedViewControllers.last))", file: file, line: line)
        
        XCTAssertTrue(top?.modalPresentationStyle == style, "expect modal presentation style: \(style), but got \(String(describing: top?.modalPresentationStyle)) instead", file: file, line: line)
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
        guard let first = viewControllers.first else { return }
        pushedViewControllers.append(first)
        super.setViewControllers(viewControllers, animated: animated)
    }
    
    var presentedViewControllers: [UIViewController] = []
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedViewControllers.append(viewControllerToPresent)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedViewControllers.removeLast()
        super.dismiss(animated: flag, completion: completion)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        pushedViewControllers.removeLast(pushedViewControllers.count - 1)
        return super.popToRootViewController(animated: animated)
    }
}
