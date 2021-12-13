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
        
        sut.simulateSpellingPlanName("ㄘㄨㄣ")
        XCTAssertFalse(sut.canGoToSetAmountScene, "user can not navigate to set amount scene when spelling plan name.")
        
        sut.simulateTypingPlanName("存錢計畫")
        XCTAssertTrue(sut.canGoToSetAmountScene, "user can navigate to set amount scene after setting a plan name.")
        
        sut.simulateDeletingPlaneName()
        XCTAssertFalse(sut.canGoToSetAmountScene, "user can not navigate to set amount scene after deleting plan name.")
        
        sut.simulateTypingPlanName("超完美存錢計畫")
        XCTAssertTrue(sut.canGoToSetAmountScene, "user can navigate to set amount scene after setting plan name again.")
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
    
    func simulateTypingPlanName(_ name: String) {
        planTextField.text = name
        planTextField.sendActions(for: .editingChanged)
    }
    
    func simulateSpellingPlanName(_ name: String) {
        let currentPlanName = planTextField.text ?? ""
        planTextField.text = currentPlanName + name
        planTextField.setMarkedText(name, selectedRange: NSRange(location: currentPlanName.count, length: name.count))
    }
    
    func simulateDeletingPlaneName() {
        planTextField.text = ""
        planTextField.sendActions(for: .editingChanged)
    }
}
