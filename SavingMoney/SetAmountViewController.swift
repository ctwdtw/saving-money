//
//  SetAmountViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public struct SavingAmount {
    public var initialAmount: Int
    public var totalAmount: Int {
        initialAmount*(52)*(52+1)/2
    }
}

class SetAmountViewModel {
    private let onNext: (SavingAmount) -> Void
    
    private var savingAmount: SavingAmount
    
    init(savingAmount: SavingAmount, onNext: @escaping (SavingAmount) -> Void) {
        self.savingAmount = savingAmount
        self.digits = savingAmount.initialAmount.digits
        self.onNext = onNext
    }
    
    private lazy var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.locale = Locale(identifier: "zh_Hant_TW")
        f.usesGroupingSeparator = true
        f.maximumFractionDigits = 0
        return f
    }()
    
    private var digits: [Int] {
        didSet {
            savingAmount.initialAmount = digits.reduce(0) { return $0*10 + $1 }
            onAmountsChange?(self)
        }
    }
    
    var onAmountsChange: ((SetAmountViewModel) -> Void)?
    
    var totalAmount: String? {
        currencyFormatter.string(from: NSNumber(value: savingAmount.totalAmount))
    }
    
    var initialAmount: String {
        "\(savingAmount.initialAmount)"
    }
    
    func appendDigit(_ digit: Int) {
        digits.append(digit)
    }
    
    func nextStep() {
        onNext(savingAmount)
    }
}

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
