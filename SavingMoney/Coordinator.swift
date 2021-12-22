//
//  Coordinator.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var router: UIViewController { get }
    func start()
}
