//
//  SetAmountViewControllerTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/15.
//

import XCTest
import SavingMoney

class SetAmountViewControllerTests: XCTestCase {
    func test_init_displayDefaultSavingPlan() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.initialAmount, "1", "Expect 1 dollar as default initial saving amount")
        XCTAssertEqual(sut.totalAmount, "$1,378", "Expect $1,378 dollar as default total amount")
    }
    
    func makeSUT() -> SetAmountViewController {
        let sut = SetAmountUIComposer.compose(onNext: { _ in })
        return sut
    }
}

extension SetAmountViewController {
    var totalAmount: String? {
        totalAmountLabel.text
    }
    
    var initialAmount: String? {
        initialAmountLabel.text
    }
}
