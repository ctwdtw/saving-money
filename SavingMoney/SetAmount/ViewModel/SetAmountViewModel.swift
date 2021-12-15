//
//  SetAmountViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/15.
//

import Foundation
class SetAmountViewModel {
    private let onNext: (PlanAmount) -> Void
    
    private var savingAmount: PlanAmount
    
    init(savingAmount: PlanAmount, onNext: @escaping (PlanAmount) -> Void) {
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
