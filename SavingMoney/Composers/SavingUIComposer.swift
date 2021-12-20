//
//  SavingUIComposer.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/17.
//

import UIKit

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
