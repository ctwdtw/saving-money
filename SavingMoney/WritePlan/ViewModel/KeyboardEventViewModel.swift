//
//  KeyboardEventViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/15.
//

import Foundation
import CoreGraphics

class KeyboardEventViewModel {
    var onKeyboardWillShow: ((CGFloat) -> Void)?
    
    func keyboardWillShow(keyboardTop: CGFloat, targetViewBottom: CGFloat) {
        let spacing: CGFloat = 20.0
        
        let diff = keyboardTop - targetViewBottom
        
        if diff < spacing {
            let offset = -spacing - abs(diff)
            onKeyboardWillShow?(offset)
        }
    }
    
    var onKeyboardWillHide: (() -> Void)?
    
    func keyboardWillHide() {
        onKeyboardWillHide?()
    }
}
