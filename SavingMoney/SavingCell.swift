//
//  SavingCell.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class SavingCell: UITableViewCell {
    @IBOutlet public private(set) weak var weekLabel: UILabel!
    
    @IBOutlet public private(set) weak var dateLabel: UILabel!
    
    @IBOutlet public private(set) weak var targetAmountLabel: UILabel!
    
    @IBOutlet public private(set) weak var accumulatedAmountLabel: UILabel!
    
    @IBOutlet public private(set) weak var checkbox: Checkbox!
    
    public var onCheck: ((Bool) -> Void)?
    
    @IBAction func didCheck(_ sender: Any) {
        onCheck?(checkbox.isChecked)
    }

}
