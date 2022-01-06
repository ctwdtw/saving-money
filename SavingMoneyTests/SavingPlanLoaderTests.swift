//
//  SavingPlanLoaderTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/23.
//

import XCTest
import SavingMoney

class SavingPlanLoaderTests: XCTestCase {
    func test_load_messageStore() {
        let (sut, store) = makeSUT()
        
        _ = try? sut.load()
        XCTAssertEqual(store.messages, [.readData(url: sut.planURL)])
    }
    
    func test_load_throwsEmptySavingPlanErrorOnNilData() {
        let (sut, store) = makeSUT()
        store.stub(data: nil)

        XCTAssertThrowsError(try sut.load()) { error in
            XCTAssertEqual(error as NSError?, LocalSavingPlanLoader.Error.emptySavingPlan as NSError?)
        }
    }
    
    func test_load_throwsInvalidDataErrorOnInvalidData() {
        let (sut, store) = makeSUT()
        store.stub(data: "invalidData".data(using: .utf8)!)
        
        XCTAssertThrowsError(try sut.load()) { error in
            XCTAssertEqual(error as NSError?, LocalSavingPlanLoader.Error.invalidData as NSError?)
        }
    }
    
    func test_load_deliversSavingPlanOnValidData() {
        let (sut, store) = makeSUT()
        let (model, data) = makePlan(name: "awesome-saving-plan", initialAmount: 1)
        store.stub(data: data)
        
        do {
            let plan = try sut.load()
            XCTAssertEqual(plan, model)
            
        } catch {
            XCTFail("Expect not throw")
        }
    
    }
    
    func test_save_messageStore() {
        let (sut, store) = makeSUT()
        let (model, data) = makePlan(name: "awesome-saving-plan", initialAmount: 1)
        
        try? sut.save(model)
        
        XCTAssertEqual(store.messages, [.writeData(data, url: sut.planURL)])
    }
    
    func test_save_deliversSaveFailureErrorOnWritingDataFailure() {
        let (sut, store) = makeSUT()
        store.stub(error: anyNSError())
        let (model, _) = makePlan(name: "awesome-saving-plan", initialAmount: 1)
        
        XCTAssertThrowsError(try sut.save(model)) { error in
            XCTAssertEqual(error as NSError?, LocalSavingPlanLoader.Error.saveFailure as NSError?)
        }
    }
    
    func test_delete_messageStore() {
        let (sut, store) = makeSUT()
        
        try? sut.delete()
        XCTAssertEqual(store.messages, [.removeData(url: sut.planURL)])
    }
    
    func test_delete_deliverDeleteFailureErrorOnDeleteFailure() {
        let (sut, store) = makeSUT()
        store.stub(error: anyNSError())
        
        XCTAssertThrowsError(try sut.delete()) { error in
            XCTAssertEqual(error as NSError?, LocalSavingPlanLoader.Error.deleteFailure as NSError?)
        }
    }
    
    private struct TestPlan: Encodable {
        let name: String
        let startDate: Date
        let initialAmount: Int
    }
    
    private func makePlan(name: String, startDate: Date = Date.fixedDate, initialAmount: Int) -> (model: SavingPlan, data: Data) {
        let model = SavingPlan(name: name, startDate: startDate, initialAmount: initialAmount)
        let data = try! JSONEncoder().encode(TestPlan(name: name, startDate: startDate, initialAmount: initialAmount))
        return (model, data)
    }
    
    private func makeSUT() -> (LocalSavingPlanLoader, DataStoreSpy) {
        let fileManager = DataStoreSpy()
        let sut = LocalSavingPlanLoader(dataStore: fileManager)
        return (sut, fileManager)
    }
    
    private func anyNSError() -> Error {
        return NSError(domain: "any-nserror", code: -1, userInfo: nil)
    }
    
}

private class DataStoreSpy: DataStore {
    private var stubbedData: Data?
    
    func stub(data: Data?)  {
        stubbedData = data
    }
    
    enum Message: Equatable {
        case readData(url: URL)
        case writeData(Data, url: URL)
        case removeData(url: URL)
    }
    
    private(set) var messages: [Message] = []
    
    func readData(at url: URL) -> Data? {
        messages.append(.readData(url: url))
        return stubbedData
    }
    
    private var stubbedError: Error?
    
    func stub(error: Error) {
        stubbedError = error
    }
    
    func writeData(_ data: Data, at url: URL) throws {
        messages.append(.writeData(data, url: url))
        
        if let error = stubbedError {
            throw error
        }
    }
    
    func removeData(at url: URL) throws {
        messages.append(.removeData(url: url))
        
        if let error = stubbedError {
            throw error
        }
    }
    
}
