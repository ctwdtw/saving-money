//
//  WriteDownPlanViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class WriteDownPlanViewController: UIViewController {
    @IBOutlet public private(set) weak var planTextField: UITextField!
    
    @IBOutlet public private(set) weak var nextPlanBarBtnItem: UIBarButtonItem! {
        didSet {
            nextPlanBarBtnItem.isEnabled = false
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

