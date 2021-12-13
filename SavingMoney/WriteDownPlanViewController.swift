//
//  WriteDownPlanViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public typealias PlanModel = String

public class WriteDownPlanViewController: UIViewController {
    @IBOutlet public private(set) weak var nextBarBtnItem: UIBarButtonItem! {
        didSet {
            nextBarBtnItem.isEnabled = false
        }
    }
    
    @IBOutlet public private(set) weak var planTextField: UITextField!
    
    public init?(coder: NSCoder, onNext: @escaping ((PlanModel) -> Void)) {
        super.init(coder: coder)
        self.onNext = onNext
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var onNext: ((PlanModel) -> Void)?
    
    @IBAction func nextBarBtnItemTapped(_ sender: Any) {
        let model = planTextField.text ?? ""
        onNext?(model)
    }
    
    @IBAction func planTextFieldEditingChanged(_ sender: UITextField) {
        guard let planName = sender.text, planName.isEmpty == false else {
            nextBarBtnItem.isEnabled = false
            return
        }
        
        guard sender.markedTextRange == nil else {
            nextBarBtnItem.isEnabled = false
            return
        }
        
        nextBarBtnItem.isEnabled = true
    }
    
}

