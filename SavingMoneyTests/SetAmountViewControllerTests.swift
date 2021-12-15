//
//  SetAmountViewControllerTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/15.
//

import XCTest
import SavingMoney

class SetAmountViewControllerTests: XCTestCase {
    func test_init_displayZeroAccumulatedAmount() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.accumulatedAmount, "$0")
    }
    
    func test_init_displayZeroInitialAmount() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.initialAmount, "$0")
    }
    
    func makeSUT() -> SetAmountViewController {
        let sut = SetAmountUIComposer.compose(onNext: { _ in })
        return sut
    }
}

extension SetAmountViewController {
    var accumulatedAmount: String? {
        accumulatedAmountLabel.text
    }
    
    var initialAmount: String? {
        initialAmountLabel.text
    }
}
