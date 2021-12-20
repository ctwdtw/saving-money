//
//  ProgressionController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/20.
//

import Foundation
import UIKit

public class ProgressionController: NSObject {
    @IBOutlet public private(set) weak var progressionLabel: UILabel!
    
    @IBOutlet public private(set) weak var progressionCountLabel: UILabel!
    
    var viewModel: ProgressionViewModel!
    
    func bind() {
        progressionLabel.text = viewModel.progressionText()
        viewModel.onProgressionTextChanged = { [unowned self] text in
            self.progressionLabel.text = text
        }
        
        progressionCountLabel.text = viewModel.progressionCountText()
        viewModel.onProgressionCountTextChanged = { [unowned self] text in
            self.progressionCountLabel.text = text
        }
    }
    
}
