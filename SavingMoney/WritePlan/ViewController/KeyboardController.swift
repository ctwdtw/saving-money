//
//  KeyboardController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/15.
//

import Foundation
import UIKit

class KeyboardController: NSObject {
    private let viewModel: KeyboardEventViewModel
    
    private weak var planTextField: UITextField!
    
    private weak var view: UIView!
    
    init(viewModel: KeyboardEventViewModel) {
        self.viewModel = viewModel
    }
    
    func bind(_ view: UIView, textField: UITextField) {
        planTextField = textField
        self.view = view
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIControl.keyboardWillShowNotification,
            object: nil
        )
        
        viewModel.onKeyboardWillShow = { offset in
            UIView.animate(withDuration: 0.3) {
                view.frame.origin = CGPoint(x: 0, y: offset)
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIControl.keyboardWillHideNotification,
            object: nil
        )
        
        viewModel.onKeyboardWillHide = {
            UIView.animate(withDuration: 0.3) {
                view.frame.origin = CGPoint(x: 0, y: 0)
            }
        }
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardTop = keyboardFrame.origin.y
        let targetViewBottom = planTextField.convert(planTextField.bounds.origin, to: view).y
        + planTextField.bounds.size.height
        
        viewModel.keyboardWillShow(keyboardTop: keyboardTop, targetViewBottom: targetViewBottom)
        
    }
    
    @objc private func keyboardWillHide() {
        viewModel.keyboardWillHide()
    }

}
