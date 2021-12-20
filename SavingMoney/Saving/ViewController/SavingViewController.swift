//
//  SavingViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class SavingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet public private(set) weak var titleItem: UINavigationItem!
    
    @IBOutlet public private(set) weak var restartBarBtnItem: UIBarButtonItem!
    
    @IBOutlet public weak var tableView: UITableView!
    
    @IBOutlet public private(set) weak var progressionController: ProgressionController!
    
    private var viewModel: SavingViewModel!
    
    private var cellControllers: [SavingCellController]!
    
    private var onNext: (() -> Void)!
    
    init?(coder: NSCoder, viewModel: SavingViewModel, cellControllers: [SavingCellController], onNext: @escaping () -> Void) {
        super.init(coder: coder)
        self.viewModel = viewModel
        self.cellControllers = cellControllers
        self.onNext = onNext
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        bindTitleNavigationItem()
        progressionController.bind()
    }
    
    private func bindTitleNavigationItem() {
        titleItem.title = viewModel.planName
    }
        
    @IBAction func restartPlanBarBtnPressed(_ sender: Any) {
        onNext()
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
