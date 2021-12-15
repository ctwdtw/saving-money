//
//  WriteDownPlanViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/13.
//

import Foundation
import CoreGraphics

class KeyboardEventViewModel {
    var onKeyboardWillShow: ((CGFloat) -> Void)?
    
    func keyboardWillShow(keyboardTop: CGFloat, targetViewBottom: CGFloat) {
        let spacing: CGFloat = 20.0
        
        let diff = keyboardTop - targetViewBottom
        
        if diff < spacing {
            let offset = -spacing - abs(diff)
            onKeyboardWillShow?(offset)
        }
    }
    
    var onKeyboardWillHide: (() -> Void)?
    func keyboardWillHide() {
        onKeyboardWillHide?()
    }
}

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
    
    func nextStep() {
        onNext(planModel)
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
