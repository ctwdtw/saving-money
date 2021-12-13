//
//  WriteDownPlanViewControllerTests.swift
//  WriteDownPlanViewControllerTests
//
//  Created by Paul Lee on 2021/12/12.
//

import XCTest
import SavingMoney

class WriteDownPlanViewControllerTests: XCTestCase {
    func test_viewDidLoad_doesNotHasPlanName() {
        let sut = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertNilOrEmptyString(sut.planName)
    }
    
    func test_navigateToSetAmountSceneAction_isEnableWhenSetPlanName() {
        let sut = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertFalse(sut.canGoToSetAmountScene, "user can not navigate to set amount scene before setting plane name.")
        
        sut.simulateTypingPlaneName("My awesome saving plan name")
        XCTAssertTrue(sut.canGoToSetAmountScene, "user can navigate to set amount scene after setting a plan name.")
        
        sut.simulateDeletePlaneName()
        XCTAssertFalse(sut.canGoToSetAmountScene, "user can not navigate to set amount scene when plan name is deleted.")
    }
    
    private func makeSUT() -> WriteDownPlanViewController {
        let sut = UIStoryboard(name: "Main", bundle: Bundle(for: WriteDownPlanViewController.self)).instantiateViewController(identifier: "WriteDownPlanViewController", creator: { coder in
            WriteDownPlanViewController(coder: coder)
        })
        
        return sut
    }
}

extension XCTestCase {
    func XCTAssertNilOrEmptyString(_ string: String?, _ message: String = "", file: StaticString = #filePath, line: UInt = #line) {
        guard string?.isEmpty == true || string == nil else {
            XCTFail(message, file: file, line: line)
            return
        }
    }
}

extension WriteDownPlanViewController {
    var planName: String? {
        planTextField.text
    }
    
    var placeHolderPlanName: String? {
        planTextField.placeholder
    }
    
    var canGoToSetAmountScene: Bool {
        nextPlanBarBtnItem.isEnabled
    }
    
    func simulateTypingPlaneName(_ name: String) {
        planTextField.text = name
        planTextField.sendActions(for: .editingChanged)
    }
    
    func simulateDeletePlaneName() {
        planTextField.text = ""
        planTextField.sendActions(for: .editingChanged)
    }
}
