//
//  SavingUIComposer.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/17.
//

import UIKit

public class SavingUIComposer {
    public static func compose(model: SavingPlan, savingPlanCache: SavingPlanCache, onNext: @escaping () -> Void) -> SavingViewController {
        let vm = ProgressionViewModel(model: model, savingPlanCache: savingPlanCache)
        
        let cellControllers: [SavingCellController] = (1...52).map { weekNumber in
            let cellController = SavingCellController(
                viewModel: SavingCellViewModel(
                    weekNumber: weekNumber,
                    initialAmount: model.initialAmount,
                    startDate: model.startDate
                )
            )
            
            cellController.onCheck = { isChecked in
                vm.checkProgression(weekNumber, isChecked: isChecked)
            }
            
            return cellController
        }
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle(for: SavingViewController.self)).instantiateViewController(identifier: "SavingViewController", creator: { coder in
            return SavingViewController(
                coder: coder,
                cellControllers: cellControllers
            )
        })
        
        vc.progressionController.viewModel = vm
        vc.titleBarController.viewModel = TitleBarViewModel(planName: model.name)
        vc.titleBarController.onNext = onNext
        
        return vc
    }
}
