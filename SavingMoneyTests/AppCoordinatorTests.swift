//
//  AppCoordinatorTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/21.
//

import XCTest
@testable import SavingMoney

class AppCoordinatorTests: XCTestCase {
    func test_routingStartWithWriteDownPlan_onEmptyPlan() {
        let (sut, router) = makeSUT()
        
        sut.start()
        let writeDownPlan = assertPushedTop(is: WriteDownPlanViewController.self, on: router)
        
        writeDownPlan?.simulateTypingPlanName("My Awesome Saving Plan")
        writeDownPlan?.simulateTapNext()
        let setAmount = assertPushedTop(is: SetAmountViewController.self, on: router)
    
        setAmount?.simulateTapNext()
        let saving = assertPresentedTop(is: SavingViewController.self, on: router)
        
        saving?.simulatePressReStart()
        assertPushedTop(is: WriteDownPlanViewController.self, on: router)
        XCTAssertNilOrEmptyString(writeDownPlan?.planName, "should have no plan name when pop to write down plan scene")
    }
    
    func test_routingStartWithSaving_onNonEmptyPlan() {
        let plan = SavingPlan(name: "My Awesome Saving Plan", startDate: Date.fixedDate, initialAmount: 1)
        let (sut, router) = makeSUT(stub: .success(plan))
        
        sut.start()
        let saving = assertPushedTop(is: SavingViewController.self, on: router)
        XCTAssertTrue(router.navigationBar.isHidden, "should not show router's navigation bar when start from saving page.")
        
        saving?.simulatePressReStart()
        let writeDownPlan = assertPushedTop(is: WriteDownPlanViewController.self, on: router)
        XCTAssertNilOrEmptyString(writeDownPlan?.planName, "should have no plan name when pop to write down plan scene")
        XCTAssertFalse(router.navigationBar.isHidden, "show show router's navigation bar when start from write down plan page.")
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
    
    private func makeSUT(stub result: Result<SavingPlan, Error> = .failure(LocalSavingPlanLoader.Error.emptySavingPlan)) -> (AppCoordinator, RouterSpy) {
        let routerSpy = RouterSpy()
        let loaderStub = SavingPlanLoaderStub()
        loaderStub.stub(result)
        let sut = AppCoordinator(
            router: routerSpy,
            savingPlanLoader: loaderStub
        )
        return (sut, routerSpy)
    }
}

private class SavingPlanLoaderStub: SavingPlanLoader {
    func load() throws -> SavingPlan {
        try stubbedResult.get()
    }
    
    func save(_ savingPlan: SavingPlan) throws {
        
    }
    
    private var stubbedResult: Result<SavingPlan, Error> = .failure(LocalSavingPlanLoader.Error.emptySavingPlan)
    
    func stub(_ result: Result<SavingPlan, Error>) {
        stubbedResult = result
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
