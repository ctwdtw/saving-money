//
//  SavingViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public class SavingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet public private(set) weak var titleBarController: TitleBarController!
    
    @IBOutlet public private(set) weak var progressionController: ProgressionController!
    
    @IBOutlet public weak var tableView: UITableView!
    
    private var cellControllers: [SavingCellController]!
    
    init?(coder: NSCoder, cellControllers: [SavingCellController]) {
        super.init(coder: coder)
        self.cellControllers = cellControllers
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView)
        titleBarController.bind()
        progressionController.bind()
    }
    
    private func configure(_ tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
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
