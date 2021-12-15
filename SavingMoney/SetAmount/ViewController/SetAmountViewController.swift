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
    
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
