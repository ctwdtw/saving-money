//
//  WriteDownPlanViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class WriteDownPlanViewController: UIViewController {
    @IBOutlet public private(set) weak var nextBarBtnItem: UIBarButtonItem!
    
    @IBOutlet public private(set) weak var planTextField: UITextField!
    
    private var viewModel: WriteDownPlanViewModel?
    
    private var keyboardController: KeyboardController?
    
    init?(coder: NSCoder, viewModel: WriteDownPlanViewModel, keyboardController: KeyboardController) {
        super.init(coder: coder)
        self.viewModel = viewModel
        self.keyboardController = keyboardController
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        bind(planTextField, nextBarBtnItem)
        keyboardController?.bind(view, textField: planTextField)
    }
    
    private func bind(_ textField: UITextField, _ barBtnItem: UIBarButtonItem) {
        viewModel?.onNextStateChange = { readyForNextStep in
            barBtnItem.isEnabled = readyForNextStep
        }
        
        textField.addTarget(
            self,
            action: #selector(planTextFieldEditingChanged(_:)),
            for: .editingChanged
        )
        
        viewModel?.onPlanModelChanged = { planModel in
            textField.text = planModel
            
        }
        
        barBtnItem.target = self
        barBtnItem.action = #selector(nextBarBtnItemTapped(_:))
    }
    
    @objc private func nextBarBtnItemTapped(_ sender: Any) {
        viewModel?.nextStep()
    }
    
    @objc private func planTextFieldEditingChanged(_ sender: UITextField) {
        viewModel?.planNameChange(sender.nonNilText, spellingPhase: sender.isSpelling)
    }
    
}
