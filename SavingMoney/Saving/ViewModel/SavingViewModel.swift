//
//  SavingViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/18.
//

import Foundation
class SavingViewModel {
    private var model: SavingPlan {
        didSet {
            onProgressionTextChanged?(progressionText())
            onProgressionCountTextChanged?(progressionCountText())
        }
    }
    
    var planName: String {
        model.name
    }
    
    private let onNext: () -> Void
    
    init(model: SavingPlan, onNext: @escaping () -> Void) {
        self.model = model
        self.onNext = onNext
    }
    
    //MARK: - progression
    private lazy var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.locale = Locale(identifier: "zh_Hant_TW")
        f.usesGroupingSeparator = true
        f.maximumFractionDigits = 0
        f.currencySymbol = ""
        return f
    }()
    
    var onProgressionTextChanged: ((String) -> Void)?
    
    var onProgressionCountTextChanged: ((String) -> Void)?
    
    func progressionText() -> String {
        let totalAmount = currencyFormatter.string(from: NSNumber(value: model.totalAmount)) ?? ""
        return "$\(model.accumulatedAmount)/\(totalAmount)"
    }
    
    func progressionCountText() -> String {
        let count = model.progressions.filter ({ $0.value == true }).count
        return "\(count)/52"
    }
    
    func checkProgression(_ weekNumber: Int, isChecked: Bool) {
        model.progressions[weekNumber] = isChecked
    }
    
    //MARK: - navigation
    func restart() {
        onNext()
    }
    
}
