//
//  AppCoordinator.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var router: UIViewController {
        return navc
    }
    
    private let navc: UINavigationController
    
    private var savingPlan = SavingPlan(name: "", initialAmount: 0)
    
    private var savingPlanLoader: SavingPlanLoader
    
    init(router: UINavigationController, savingPlanLoader: SavingPlanLoader) {
        self.navc = router
        self.savingPlanLoader = savingPlanLoader
    }
    
    private lazy var writeDownPlanViewModel: WriteDownPlanViewModel =
    WriteDownPlanViewModel(
        onNext: { [unowned self] planName in
            savingPlan.name = planName
            pushToSetAmountScene()
        }
    )
    
    func start() {
        var vc: UIViewController!
        do {
            savingPlan = try savingPlanLoader.load()
            vc = SavingUIComposer.compose(
                model: savingPlan,
                onNext: { [unowned self] in
                    writeDownPlanViewModel.reset()
                    let vc = WriteDownPlanUIComposer.compose(viewModel: writeDownPlanViewModel)
                    
                    
                    navc.navigationBar.isHidden = false
                    navc.setViewControllers([vc], animated: false)
                    
                }
            )
            navc.navigationBar.isHidden = true
            
        } catch {
            vc = WriteDownPlanUIComposer
                .compose(viewModel: writeDownPlanViewModel)
            
        }
        
        navc.setViewControllers([vc], animated: false)
    }
    
    private func pushToSetAmountScene() {
        let vc = SetAmountUIComposer
            .compose(onNext: { [unowned self] planAmount in
                savingPlan.initialAmount = planAmount.initialAmount
                pushToSavingScene()
            })
        
        navc.pushViewController(vc, animated: true)
    }
    
    private func pushToSavingScene() {
        let vc = SavingUIComposer
            .compose(model: savingPlan, onNext: { [unowned self] in
                backToWriteDownPlanScene()
            })
        
        vc.modalPresentationStyle = .fullScreen
        navc.present(vc, animated: true, completion: nil)
    }
    
    private func backToWriteDownPlanScene() {
        writeDownPlanViewModel.reset()
        navc.dismiss(animated: true) { [navc] in
            navc.popToRootViewController(animated: true)
        }
    }
}
