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
    
    func test_nextSceneAction_isEnableWhenSetPlanName() {
        let sut = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertFalse(sut.canGoToNextScene, "user can not navigate to next scene before setting plane name.")
        
        sut.simulateSpellingPlanName("ㄘㄨㄣ")
        XCTAssertFalse(sut.canGoToNextScene, "user can not navigate to next scene when spelling plan name.")
        
        sut.simulateTypingPlanName("存錢計畫")
        XCTAssertTrue(sut.canGoToNextScene, "user can navigate to next scene after setting a plan name.")
        
        sut.simulateDeletingPlaneName()
        XCTAssertFalse(sut.canGoToNextScene, "user can not navigate to next scene after deleting plan name.")
        
        sut.simulateTypingPlanName("超完美存錢計畫")
        XCTAssertTrue(sut.canGoToNextScene, "user can navigate to next scene after setting plan name again.")
    }
    
    func test_nextSceneAction_notifiesNextStepHandler() {
        var settedPlan: [PlanModel] = []
        let sut = makeSUT(onNext: { settedPlan.append($0) })
        sut.loadViewIfNeeded()
        
        sut.simulateTypingPlanName("My awesome plan")
        sut.simulateTapNext()
        
        XCTAssertEqual(settedPlan, ["My awesome plan"])
    }
    
    func test_adjustViewOffset_onKeyboardShownOrHide() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        
        let keyboardView = sut.simulateReceiveKeyboardWillShowNotification()
        assertThat(sut, render: sut.planTextField, onWillShow: keyboardView, spacing: 20.0)
        
        sut.simulateReceiveKeyboardWillHideNotification()
        XCTAssertEqual(sut.view.frame.origin, .zero, "view has zero offset when keyboard hide.")
    }
    
    private func makeSUT(onNext: @escaping ((PlanModel) -> Void) = { _ in }) -> WriteDownPlanViewController {
        return WriteDownPlanUIComposer.compose(onNext: onNext)
    }
    
    private func assertThat(_ sut: WriteDownPlanViewController, render view: UIView, onWillShow keyboardView: UIView, spacing: CGFloat, file: StaticString = #filePath, line: UInt = #line) {
        sut.view.forceLayout()
        
        let container = UIView(frame: sut.view.bounds)
        container.addSubview(sut.view)
        container.addSubview(keyboardView)
    
        let viewBottom = view.convert(view.bounds.origin, to: container).y + view.bounds.size.height
        
        let keyboardTop = keyboardView.frame.origin.y
        
        let diff = keyboardTop - viewBottom
        XCTAssertTrue( diff >= spacing , "view's bottom should be above keyboard top \(spacing) points, got \(diff) instead.", file: file, line: line)
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
    
    var canGoToNextScene: Bool {
        nextBarBtnItem.isEnabled
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
    
    func simulateTapNext() {
        loadViewIfNeeded()
        guard let action = nextBarBtnItem.action else { return }
        UIApplication.shared.sendAction(action, to: nextBarBtnItem.target, from: nil, for: nil)
    }
    
    @discardableResult
    func simulateReceiveKeyboardWillShowNotification() -> UIView {
        let extremelyHighKeyboardFrame =
        CGRect(
            origin: CGPoint(x: 0, y: view.bounds.height * (1/3)),
            size: CGSize(width: view.bounds.width, height: view.bounds.height * (2/3))
        )
    
        NotificationCenter.default.post(
            name: UIControl.keyboardWillShowNotification,
            object: nil,
            userInfo: [UIResponder.keyboardFrameEndUserInfoKey : extremelyHighKeyboardFrame]
        )
        
        return UIView(frame: extremelyHighKeyboardFrame)
    }
    
    func simulateReceiveKeyboardWillHideNotification() {
        NotificationCenter.default.post(
            name: UIResponder.keyboardWillHideNotification,
            object: nil,
            userInfo: nil
        )
    }
    
}

extension UIView {
    func forceLayout() {
        layoutIfNeeded()
        RunLoop.main.run(until: Date())
    }
}
