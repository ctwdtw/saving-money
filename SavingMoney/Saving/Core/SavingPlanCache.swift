//
//  SavingPlanCache.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/27.
//

import Foundation
public protocol SavingPlanCache {
    func save(_ savingPlan: SavingPlan) throws
}
