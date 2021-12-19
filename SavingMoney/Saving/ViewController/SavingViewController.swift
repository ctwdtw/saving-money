//
//  SavingViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class SavingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet public weak var tableView: UITableView!
    
    @IBOutlet public private(set) weak var progressionLabel: UILabel!
    
    private var viewModel: SavingViewModel!
    
    init?(coder: NSCoder, viewModel: SavingViewModel) {
        super.init(coder: coder)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = viewModel.planName
        progressionLabel.text = viewModel.progressionText()
    }
    
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavingCell", for: indexPath) as! SavingCell
        
        cell.weekLabel.text = viewModel.weekText(at: indexPath.row)
        cell.dateLabel.text = viewModel.dateText(at: indexPath.row)
        cell.targetAmountLabel.text = viewModel.targetAmountText(at: indexPath.row)
        cell.accumulatedAmountLabel.text = viewModel.accumulatedAmountLabel(at: indexPath.row)
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 52
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52.0
    }
}
