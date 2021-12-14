//
//  WriteDownPlanViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class WriteDownPlanViewController: UIViewController {
    @IBOutlet public private(set) weak var nextBarBtnItem: UIBarButtonItem!
    
    @IBOutlet public private(set) weak var planTextField: UITextField!
    
    private var viewModel: WriteDownPlanViewModel?
    
    init?(coder: NSCoder, viewModel: WriteDownPlanViewModel) {
        super.init(coder: coder)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIControl.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let topY = view.frame.origin.y
        let keyboardTopY = keyboardFrame.origin.y
        let viewBottomY = planTextField.convert(planTextField.bounds.origin, to: view).y
        + planTextField.bounds.size.height
        
        print("log-textFiled-bottom-in-prod-code: \(viewBottomY)")
        
        let spacing: CGFloat = 20.0
        let diff = viewBottomY - keyboardTopY
        
        if diff > 0 {
            let offset = -(diff+spacing) + topY
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin = CGPoint(x: 0, y: offset)
            }
            
        }
        
    }
    
    private func bind() {
        bindNextBarBtnItem()
        bindPlanTextField()
    }
    
    private func bindNextBarBtnItem() {
        viewModel?.onNextStateChange = { [nextBarBtnItem] readyForNextStep in
            nextBarBtnItem?.isEnabled = readyForNextStep
        }
        
        nextBarBtnItem.target = self
        nextBarBtnItem.action = #selector(nextBarBtnItemTapped(_:))
    }
    
    private func bindPlanTextField() {
        planTextField.addTarget(self, action: #selector(planTextFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    @objc private func nextBarBtnItemTapped(_ sender: Any) {
        viewModel?.nextStep()
    }
    
    @objc private func planTextFieldEditingChanged(_ sender: UITextField) {
        viewModel?.planNameChange(sender.nonNilText, spellingPhase: sender.isSpelling)
    }
    
}
