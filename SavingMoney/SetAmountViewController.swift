//
//  SetAmountViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public typealias AmountModel = Double

class SetAmountViewModel {
    private var amountModel: Double
    
    private let onNext: (AmountModel) -> Void
    
    init(amountModel: AmountModel = 0.0, onNext: @escaping (AmountModel) -> Void) {
        self.amountModel = amountModel
        self.onNext = onNext
    }
    
    func nextStep() {
        onNext(amountModel)
    }
}

public class SetAmountViewController: UIViewController {
    private var viewModel: SetAmountViewModel?
    
    @IBOutlet public private(set) weak var totalAmountLabel: UILabel!
    
    @IBOutlet public private (set) weak var initialAmountLabel: UILabel!
    
    init?(coder: NSCoder, viewModel: SetAmountViewModel) {
        super.init(coder: coder)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
