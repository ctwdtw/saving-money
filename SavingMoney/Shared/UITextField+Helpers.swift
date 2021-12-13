//
//  UITextField+Helpers.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/13.
//

import UIKit
public extension UITextField {
    var isSpelling: Bool {
        return !(markedTextRange == nil)
    }
    
    var nonNilText: String {
        text ?? ""
    }
}
