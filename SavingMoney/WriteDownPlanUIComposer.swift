//
//  WriteDownPlanUIComposer.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/13.
//

import UIKit

public class WriteDownPlanUIComposer {
    public static func compose(onNext: @escaping (PlanModel) -> Void) -> WriteDownPlanViewController {
        let vc = UIStoryboard(name: "Main", bundle: Bundle(for: WriteDownPlanViewController.self)).instantiateViewController(identifier: "WriteDownPlanViewController", creator: { coder in
            return WriteDownPlanViewController(
                coder: coder,
                viewModel: WriteDownPlanViewModel(onNext: onNext)
                )
        })
        
        return vc
    }
}
