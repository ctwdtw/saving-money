//
//  SavingUIComposer.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/17.
//

import UIKit

public struct SavingPlan {
    public let name: String
    
    public let startDate: Date
    
    public let initialAmount: Int
    
    public var totalAmount: Int {
        initialAmount*(52)*(52+1)/2
    }
    
    public var progressions: [Int: Bool] = [:]
    
    public var accumulatedAmount: Int {
        progressions.reduce(0) { (result, progression) in
            let weekAmount = progression.key * initialAmount
            return progression.value ? result + weekAmount  : result
        }
    }
    
    public init(name: String, startDate: Date = Date(), initialAmount: Int) {
        self.name = name
        self.startDate = startDate
        self.initialAmount = initialAmount
    }
}

public class SavingUIComposer {
    public static func compose(model: SavingPlan, onNext: @escaping () -> Void) -> SavingViewController {
        let vc = UIStoryboard(name: "Main", bundle: Bundle(for: SavingViewController.self)).instantiateViewController(identifier: "SavingViewController", creator: { coder in
            return SavingViewController(
                coder: coder,
                viewModel: SavingViewModel(
                    model: model,
                    onNext: onNext
                )
            )
        })
        
        return vc
    }
}
