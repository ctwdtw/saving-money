//
//  SetAmountViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class SetAmountViewController: UIViewController {
    private var viewModel: SetAmountViewModel?
    
    @IBOutlet public private(set) weak var totalAmountLabel: UILabel!
    
    @IBOutlet public private (set) weak var initialAmountLabel: UILabel!
    
    @IBOutlet public private(set) var digitBtns: [UIButton]!
    
    @IBOutlet public private(set) weak var clearBtn: UIButton!
    
    init?(coder: NSCoder, viewModel: SetAmountViewModel) {
        super.init(coder: coder)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel?.onAmountsChange = { [initialAmountLabel, totalAmountLabel] viewModel in
            initialAmountLabel?.text = viewModel.initialAmount
            totalAmountLabel?.text = viewModel.totalAmount
        }
    }
    
    @IBAction func digitTouchUpInside(_ sender: UIButton) {
        viewModel?.appendDigit(sender.tag)
    }
    
    @IBAction func clearBtnTouchUpInside(_ sender: Any) {
        viewModel?.clearInitialAmount()
    }
}
