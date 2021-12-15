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
    }
    
    private func bind() {
        bindNextBarBtnItem()
        bindPlanTextField()
        bindKeyboardEvents()
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
    
    private func bindKeyboardEvents() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIControl.keyboardWillShowNotification,
            object: nil
        )
        
        viewModel?.onKeyboardWillShow = { offset in
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin = CGPoint(x: 0, y: offset)
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIControl.keyboardWillHideNotification,
            object: nil
        )
        
        viewModel?.onKeyboardWillHide = {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin = CGPoint(x: 0, y: 0)
            }
        }
    }
    
    @objc private func nextBarBtnItemTapped(_ sender: Any) {
        viewModel?.nextStep()
    }
    
    @objc private func planTextFieldEditingChanged(_ sender: UITextField) {
        viewModel?.planNameChange(sender.nonNilText, spellingPhase: sender.isSpelling)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardTop = keyboardFrame.origin.y
        let targetViewBottom = planTextField.convert(planTextField.bounds.origin, to: view).y
        + planTextField.bounds.size.height
        
        viewModel?.keyboardWillShow(keyboardTop: keyboardTop, targetViewBottom: targetViewBottom)
        
    }
    
    @objc private func keyboardWillHide() {
        viewModel?.keyboardWillHide()
    }

    
}
