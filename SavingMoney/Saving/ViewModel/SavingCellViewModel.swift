//
//  SavingCellViewModel.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/20.
//

import Foundation
class SavingCellViewModel {
    private let weekNumber: Int
    private let initialAmount: Int
    private let startDate: Date
    
    init(weekNumber: Int, initialAmount: Int, startDate: Date) {
        self.weekNumber = weekNumber
        self.initialAmount = initialAmount
        self.startDate = startDate
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MM/dd/yyyy"
        return f
    }()
    
    var weekText: String {
        return "\(weekNumber)"
    }
    
    var dateText: String {
        let date = startDate.addingTimeInterval(Double(86400*7*(weekNumber-1)))
        return dateFormatter.string(from: date)
    }
    
    var targetAmountText: String {
        return "\(initialAmount * weekNumber)"
    }
    
    var accumulatedAmountText: String {
        return "\(initialAmount*weekNumber*(weekNumber+1)/2)"
    }
}
