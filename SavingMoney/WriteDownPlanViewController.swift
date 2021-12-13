//
//  WriteDownPlanViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class WriteDownPlanViewController: UIViewController {
    @IBOutlet public private(set) weak var nextBarBtnItem: UIBarButtonItem! {
        didSet {
            nextBarBtnItem.isEnabled = false
        }
    }
    
    @IBOutlet public private(set) weak var planTextField: UITextField!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
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

