//
//  SavingViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/18.
//

import Foundation
class SavingViewModel {
    private var model: SavingPlan
    
    var planName: String {
        model.name
    }
    
    init(model: SavingPlan) {
        self.model = model
    }
    
}
