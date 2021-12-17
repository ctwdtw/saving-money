//
//  SetAmountViewControllerTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/15.
//

import XCTest
import SavingMoney

class SetAmountViewControllerTests: XCTestCase {
    func test_renderSavingPlan_onPressNumberPad() {
        let sut = makeSUT()
        
        sut.loadViewIfNeeded()
        assertThat(sut, renderInitialAmount: "1", totalAmount: "$1,378", "render default saving plan on init.")
        
        sut.simulatePressDigit(0)
        assertThat(sut, renderInitialAmount: "10", totalAmount: "$13,780", "render start `10` saving plan on press digit 0 after init saving plan.")
        
        sut.simulatePressDeleteBtn()
        assertThat(sut, renderInitialAmount: "1", totalAmount: "$1,378", "render start `1` saving plane on press backward delete after `10` saving plan.")
        
        sut.simulatePressDeleteBtn()
        assertThat(sut, renderInitialAmount: "0", totalAmount: "$0", "render `0` saving plane on press backward delete to the end.")
        
        sut.simulatePressDigit(0)
        assertThat(sut, renderInitialAmount: "0", totalAmount: "$0", "render `0` saving plane on press digit 0 after `0` saving plan")
        
        sut.simulatePressDigit(0)
        assertThat(sut, renderInitialAmount: "0", totalAmount: "$0", "render `0` saving plane on press digit 0 again after `0` saving plan")
        
        sut.simulatePressDigit(5)
        assertThat(sut, renderInitialAmount: "5", totalAmount: "$6,890", "render start 5 saving plane on press digit 5 after `0` saving plan.")
    }
    
    func test_renderNextSceneAction_onPressNumberPad() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        
        sut.simulatePressDeleteBtn()
        XCTAssertFalse(sut.canGoToNextScene)
        
        sut.simulatePressDeleteBtn()
        XCTAssertFalse(sut.canGoToNextScene)
        
        sut.simulatePressDigit(9)
        XCTAssertTrue(sut.canGoToNextScene)
    }
    
    func makeSUT() -> SetAmountViewController {
        let sut = SetAmountUIComposer.compose(onNext: { _ in })
        return sut
    }
    
    private func assertThat(_ sut: SetAmountViewController, renderInitialAmount initialAmount: String, totalAmount: String, _ message: String = "", file: StaticString = #filePath, line: UInt = #line) {
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
    
    func simulatePressDigit(_ digit: Int) {
        let btn = digitBtns.filter { $0.tag == digit }.first
        btn?.sendActions(for: .touchUpInside)
    }
    
    func simulatePressDeleteBtn() {
        deleteBtn.sendActions(for: .touchUpInside)
    }
    
    var canGoToNextScene: Bool {
        nextBarBtnItem.isEnabled
    }
    
}
