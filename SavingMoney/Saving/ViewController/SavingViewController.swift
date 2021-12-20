//
//  SavingViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class ProgressionViewController: NSObject {
    @IBOutlet public private(set) weak var progressionLabel: UILabel!
    
    @IBOutlet public private(set) weak var progressionCountLabel: UILabel!
    
    var viewModel: SavingViewModel!
    
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

public class SavingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet public private(set) weak var titleNavigationItem: UINavigationItem!
    
    @IBOutlet public weak var tableView: UITableView!
    
    @IBOutlet public private(set) weak var restartBarBtnItem: UIBarButtonItem!
    
    @IBOutlet public private(set) weak var progressionViewController: ProgressionViewController!
    
    private var viewModel: SavingViewModel!
    
    private var cellControllers: [SavingCellController]!
    
    init?(coder: NSCoder, viewModel: SavingViewModel, cellControllers: [SavingCellController]) {
        super.init(coder: coder)
        self.viewModel = viewModel
        self.cellControllers = cellControllers
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        bindTitleNavigationItem()
        progressionViewController.bind()
    }
    
    private func bindTitleNavigationItem() {
        titleNavigationItem.title = viewModel.planName
    }
        
    @IBAction func restartPlanBarBtnPressed(_ sender: Any) {
        viewModel.restart()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellControllers[indexPath.row].view(for: tableView, at: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellControllers.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52.0
    }
}
