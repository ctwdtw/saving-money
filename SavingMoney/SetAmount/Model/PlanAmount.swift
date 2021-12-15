//
//  PlanAmount.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/15.
//

import Foundation
public struct PlanAmount {
    public var initialAmount: Int
    public var totalAmount: Int {
        initialAmount*(52)*(52+1)/2
    }
}
