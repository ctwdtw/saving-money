//
//  SavingMoneyViewControllerTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/17.
//

import XCTest
import SavingMoney

class SavingMoneyViewControllerTests: XCTestCase {
    func test_viewDidLoad_displayPlanName() {
        let plan = SavingPlan(name: "Awesome Saving Plan", initialAmount: 1, accumulatedAmount: 0)
        let sut = makeSUT(model: plan)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.planName, "Awesome Saving Plan")
    }
    
    func test_viewDidLoad_renderSavingPlan() {
        let plan = SavingPlan(name: "Awesome Saving Plan", startDate: Date.jan3rd2022, initialAmount: 1, accumulatedAmount: 0)
        
        let sut = makeSUT(model: plan)
        
        sut.loadViewIfNeeded()
        assertThat(sut, renders: plan)
    }
    
    private func assertThat(_ sut: SavingViewController, renders model: SavingPlan, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(sut.numberOfRenderedWeeklyPlanView, 52, "should have 52 weeks plan" , file: file, line: line)
        
        for weekNumber in (1...52) {
            guard let cell = sut.savingPlanView(at: weekNumber-1) as? SavingCell else {
                XCTFail("Expect `SavingCell` at index: \(weekNumber-1)")
                break
            }
            
            XCTAssertEqual(cell.weekLabel.text, "\(weekNumber)", "week", file: file, line: line)
            XCTAssertEqual(cell.dateLabel.text, dateText(for: weekNumber), "displayed date", file: file, line: line)
            XCTAssertEqual(cell.targetAmountLabel.text, "\(model.initialAmount * weekNumber)", "accumulated amount", file: file, line: line)
            XCTAssertEqual(cell.accumulatedAmountLabel.text, "\(model.initialAmount*(weekNumber*(weekNumber+1)/2))", "target amount for week \(weekNumber)", file: file, line: line)
        }
    }
    
    private func dateText(`for` weekNumber: Int) -> String {
        switch weekNumber {
        case 1:return "01/03/2022"
        case 2:return "01/10/2022"
        case 3:return "01/17/2022"
        case 4:return "01/24/2022"
        case 5:return "01/31/2022"
        case 6:return "02/07/2022"
        case 7:return "02/14/2022"
        case 8:return "02/21/2022"
        case 9:return "02/28/2022"
        case 10:return "03/07/2022"
        case 11:return "03/14/2022"
        case 12:return "03/21/2022"
        case 13:return "03/28/2022"
        case 14:return "04/04/2022"
        case 15:return "04/11/2022"
        case 16:return "04/18/2022"
        case 17:return "04/25/2022"
        case 18:return "05/02/2022"
        case 19:return "05/09/2022"
        case 20:return "05/16/2022"
        case 21:return "05/23/2022"
        case 22:return "05/30/2022"
        case 23:return "06/06/2022"
        case 24:return "06/13/2022"
        case 25:return "06/20/2022"
        case 26:return "06/27/2022"
        case 27:return "07/04/2022"
        case 28:return "07/11/2022"
        case 29:return "07/18/2022"
        case 30:return "07/25/2022"
        case 31:return "08/01/2022"
        case 32:return "08/08/2022"
        case 33:return "08/15/2022"
        case 34:return "08/22/2022"
        case 35:return "08/29/2022"
        case 36:return "09/05/2022"
        case 37:return "09/12/2022"
        case 38:return "09/19/2022"
        case 39:return "09/26/2022"
        case 40:return "10/03/2022"
        case 41:return "10/10/2022"
        case 42:return "10/17/2022"
        case 43:return "10/24/2022"
        case 44:return "10/31/2022"
        case 45:return "11/07/2022"
        case 46:return "11/14/2022"
        case 47:return "11/21/2022"
        case 48:return "11/28/2022"
        case 49:return "12/05/2022"
        case 50:return "12/12/2022"
        case 51:return "12/19/2022"
        case 52:return "12/26/2022"
        default: return ""
        }
    }
   
    private func targetAmount(_ week: Int, initialAmount: Int) -> String {
        return "\(initialAmount * week)"
    }
    
    func makeSUT(model: SavingPlan, file: StaticString = #filePath, line: UInt = #line) -> SavingViewController {
        return SavingUIComposer.compose(model: model)
    }
}

extension SavingViewController {
    var planName: String {
        return title ?? ""
    }
    
    var savingSection: Int {
        return 0
    }
    
    var numberOfRenderedWeeklyPlanView: Int {
        tableView.numberOfRows(inSection: savingSection)
    }
    
    func savingPlanView(at row: Int) -> UITableViewCell? {
        return tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: row, section: savingSection))
    }
}

private extension Date {
    static var jan3rd2022: Date {
        return Date(timeIntervalSince1970: 1641139200)
    }
}
