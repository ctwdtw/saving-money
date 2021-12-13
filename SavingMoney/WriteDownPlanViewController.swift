//
//  WriteDownPlanViewController.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/12.
//

import UIKit

public typealias PlanModel = String

public class WriteDownPlanViewModel {
    var onNextStateChange: ((Bool) -> Void)?
    
    func planeNameChange(_ name: String?, spellingPhase: Bool) {
        guard let name = name, name.isEmpty == false else {
            onNextStateChange?(false)
            return
        }
        
        guard !spellingPhase else {
            onNextStateChange?(false)
            return
        }
        
        onNextStateChange?(true)
    }
    
    public init() {}
}

public class WriteDownPlanViewController: UIViewController {
    @IBOutlet public private(set) weak var nextBarBtnItem: UIBarButtonItem! {
        didSet {
            nextBarBtnItem.isEnabled = false
        }
    }
    
    @IBOutlet public private(set) weak var planTextField: UITextField!
    
    private var onNext: ((PlanModel) -> Void)?
    
    private var viewModel: WriteDownPlanViewModel?
    
    public init?(coder: NSCoder, viewModel: WriteDownPlanViewModel, onNext: @escaping ((PlanModel) -> Void)) {
        super.init(coder: coder)
        self.viewModel = viewModel
        self.onNext = onNext
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        bindNextBarBtnItem()
        bindPlanTextField()
    }
    
    private func bindNextBarBtnItem() {
        viewModel?.onNextStateChange = { [nextBarBtnItem] readyForNextStep in
            nextBarBtnItem?.isEnabled = readyForNextStep
        }
        
        nextBarBtnItem.target = self
        nextBarBtnItem.action = #selector(nextBarBtnItemTapped(_:))
    }
    
    private func bindPlanTextField() {
        planTextField.addTarget(self, action: #selector(planTextFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    @objc private func nextBarBtnItemTapped(_ sender: Any) {
        let model = planTextField.text ?? ""
        onNext?(model)
    }
    
    @objc private func planTextFieldEditingChanged(_ sender: UITextField) {
        viewModel?.planeNameChange(sender.text, spellingPhase: sender.isSpelling)
    }
    
}

extension UITextField {
    var isSpelling: Bool {
        return !(markedTextRange == nil)
    }
}
