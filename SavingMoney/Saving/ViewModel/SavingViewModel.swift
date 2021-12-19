//
//  SavingViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/18.
//

import Foundation
class SavingViewModel {
    private var model: SavingPlan
    
    var planName: String {
        model.name
    }
    
    init(model: SavingPlan) {
        self.model = model
    }
    
    private lazy var currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.locale = Locale(identifier: "zh_Hant_TW")
        f.usesGroupingSeparator = true
        f.maximumFractionDigits = 0
        f.currencySymbol = ""
        return f
    }()
    
    func progressionText() -> String {
        let totalAmount = currencyFormatter.string(from: NSNumber(value: model.totalAmount)) ?? ""
        return "$\(model.accumulatedAmount)/\(totalAmount)"
    }
    
    func weekText(at idx: Int) -> String {
        return "\(idx + 1)"
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy"
        return f
    }()
    
    func dateText(at idx: Int) -> String {
        var date = model.startDate
        date.addTimeInterval(Double(86400*7*idx))
        return dateFormatter.string(from: date)
    }
    
    func targetAmountText(at idx: Int) -> String {
        return "\(model.initialAmount * (idx + 1))"
    }
    
    func accumulatedAmountLabel(at idx: Int) -> String {
        let weekNumber = idx + 1
        return "\(model.initialAmount*weekNumber*(weekNumber+1)/2)"
    }
    
}
