//
//  SetAmountUIComposer.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/15.
//

import UIKit

public class SetAmountUIComposer {
    public static func compose(onNext: @escaping (SavingAmount) -> Void) -> SetAmountViewController {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle(for: SetAmountViewController.self)).instantiateViewController(identifier: "SetAmountViewController", creator: { coder in
            return SetAmountViewController(
                coder: coder,
                viewModel: SetAmountViewModel(
                    savingAmount: SavingAmount(initialAmount: 1), onNext: onNext
                )
            )
        })
        
        return vc
    }
}
