//
//  SavingMoneyViewControllerTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/17.
//

import XCTest
import SavingMoney

class SavingMoneyViewControllerTests: XCTestCase {
    func test_init_displayPlanName() {
        let plan = SavingPlan(name: "Awesome Saving Plan", initialAmount: 1, accumulatedAmount: 0)
        let sut = makeSUT(model: plan)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.planName, "Awesome Saving Plan")
    }
   
    func makeSUT(model: SavingPlan, file: StaticString = #filePath, line: UInt = #line) -> SavingViewController {
        return SavingUIComposer.compose(model: model)
    }
}

extension SavingViewController {
    var planName: String {
        return title ?? ""
    }
}
