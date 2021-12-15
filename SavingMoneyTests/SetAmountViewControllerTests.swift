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
        
        assertThat(sut, renderInitialAmount: "1", totalAmount: "$1,378")
    }
            
    func makeSUT() -> SetAmountViewController {
        let sut = SetAmountUIComposer.compose(onNext: { _ in })
        return sut
    }
    
    private func assertThat(_ sut: SetAmountViewController, renderInitialAmount initialAmount: String, totalAmount: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(sut.initialAmount, initialAmount, "Expect \(initialAmount) dollar as default initial saving amount, but got \(String(describing: sut.totalAmount)) instead", file: file, line: line)
        XCTAssertEqual(sut.totalAmount, totalAmount, "Expect \(totalAmount) dollar as total saving amount, but got \(String(describing: sut.totalAmount)) instead", file: file, line: line)
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
