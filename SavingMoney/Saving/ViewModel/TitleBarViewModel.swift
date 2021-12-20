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
    
    init(planName: String) {
        self.planName = planName
    }
}
