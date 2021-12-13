//
//  WriteDownPlanViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/13.
//

import Foundation
class WriteDownPlanViewModel {
    var onNextStateChange: ((Bool) -> Void)?
    
    private var planModel: PlanModel
    
    private let onNext: (PlanModel) -> Void
    
    init(planModel: PlanModel = "", onNext: @escaping (PlanModel) -> Void) {
        self.planModel = planModel
        self.onNext = onNext
    }
    
    func planNameChange(_ name: String, spellingPhase: Bool) {
        guard isValidPlanName(name: name, spellingPhase: spellingPhase) else {
            onNextStateChange?(false)
            return
        }
        
        planModel = name
        
        onNextStateChange?(true)
    }
    
    private func isValidPlanName(name: String, spellingPhase: Bool) -> Bool {
        guard name.isEmpty == false else {
            return false
        }
        
        guard spellingPhase == false else {
            return false
        }
        
        return true
    }
    
    func nextStep() {
        onNext(planModel)
    }
}
