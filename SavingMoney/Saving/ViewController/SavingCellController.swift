//
//  SavingCellController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/20.
//

import Foundation
import UIKit

class SavingCellController {
    private let viewModel: SavingCellViewModel
    
    init(viewModel: SavingCellViewModel) {
        self.viewModel = viewModel
    }
    
    var onCheck: ((Bool) -> Void)?
    
    func view(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavingCell", for: indexPath) as! SavingCell
        return binded(cell)
    }
    
    private func binded(_ cell: SavingCell) -> SavingCell {
        cell.weekLabel.text = viewModel.weekText
        cell.dateLabel.text = viewModel.dateText
        cell.targetAmountLabel.text = viewModel.targetAmountText
        cell.accumulatedAmountLabel.text = viewModel.accumulatedAmountText
         
        cell.onCheck = { [unowned self] isChecked in
            onCheck?(isChecked)
        }
        
        return cell
    }
}
