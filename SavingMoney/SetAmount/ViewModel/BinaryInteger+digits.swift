//
//  BinaryInteger+digits.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/15.
//

import Foundation
extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
