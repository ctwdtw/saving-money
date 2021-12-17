//
//  SetAmountViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/15.
//

import Foundation
class SetAmountViewModel {
    private let onNext: (PlanAmount) -> Void
    
    private var planAmount: PlanAmount
    
    init(savingAmount: PlanAmount, onNext: @escaping (PlanAmount) -> Void) {
        self.planAmount = savingAmount
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
            planAmount.initialAmount = digits.reduce(0) { return $0*10 + $1 }
            onAmountsChange?(self)
        }
    }
    
    var onAmountsChange: ((SetAmountViewModel) -> Void)?
    
    var totalAmount: String? {
        currencyFormatter.string(from: NSNumber(value: planAmount.totalAmount))
    }
    
    var initialAmount: String {
        "\(planAmount.initialAmount)"
    }
    
    var readyForNext: Bool {
        return planAmount.initialAmount != 0
    }
    
    func appendDigit(_ digit: Int) {
        digits.append(digit)
    }
    
    func deleteBackward() {
        digits.removeAll()
    }
    
    func nextStep() {
        onNext(planAmount)
    }
}
