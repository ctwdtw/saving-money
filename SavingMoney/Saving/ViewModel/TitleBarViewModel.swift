//
//  TitleBarViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/20.
//

import Foundation
class TitleBarViewModel {
    private let planName: String
    
    var title: String {
        return planName
    }
    
    private let savingPlanCache: SavingPlanCache
    
    init(planName: String, savingPlanCache: SavingPlanCache) {
        self.planName = planName
        self.savingPlanCache = savingPlanCache
    }
    
    func deleteCache() {
        try? savingPlanCache.delete()
    }
}
