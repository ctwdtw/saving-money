//
//  WriteDownPlanUIComposer.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/13.
//

import UIKit

public class WriteDownPlanUIComposer {
    public static func compose(
        viewModel: WriteDownPlanViewModel
    ) -> WriteDownPlanViewController {
        let keyboardController = KeyboardController(viewModel: KeyboardEventViewModel())
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle(for: WriteDownPlanViewController.self)).instantiateViewController(identifier: "WriteDownPlanViewController", creator: { coder in
            return WriteDownPlanViewController(
                coder: coder,
                viewModel: viewModel,
                keyboardController: keyboardController
            )
        })
        
        return vc
    }
}
