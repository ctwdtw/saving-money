//
//  WriteDownPlanViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/13.
//

import Foundation
public class WriteDownPlanViewModel {
    var onNextStateChange: ((Bool) -> Void)?
    
    
    var onPlanModelChanged: ((PlanModel) -> Void)?
    
    private var planModel: PlanModel
    
    private let onNext: (PlanModel) -> Void
    
    public init(planModel: PlanModel = "", onNext: @escaping (PlanModel) -> Void) {
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
    
    func nextStep() {
        onNext(planModel)
    }
    
    func reset() {
        planModel = ""
        onPlanModelChanged?(planModel)
        onNextStateChange?(false)
    }
    
    
}

//MARK: - validation
extension WriteDownPlanViewModel {
    private func isValidPlanName(name: String, spellingPhase: Bool) -> Bool {
        guard name.isEmpty == false else {
            return false
        }
        
        guard spellingPhase == false else {
            return false
        }
        
        return true
    }
}
