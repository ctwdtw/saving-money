//
//  SavingPlanLoader.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/24.
//

import Foundation
public protocol SavingPlanLoader {
    func load() throws -> SavingPlan
}
