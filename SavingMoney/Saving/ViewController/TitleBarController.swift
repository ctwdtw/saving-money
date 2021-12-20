//
//  TitleBarController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/20.
//

import Foundation
import UIKit
public class TitleBarController: NSObject {
    @IBOutlet public private(set) weak var titleItem: UINavigationItem!
    
    @IBOutlet public private(set) weak var restartBarBtnItem: UIBarButtonItem!
    
    var onNext: (() -> Void)?
    
    var viewModel: TitleBarViewModel!
    
    @IBAction func restartPlanBarBtnPressed(_ sender: Any) {
        onNext?()
    }
    
    func bind() {
        titleItem.title = viewModel.title
    }
    
}
