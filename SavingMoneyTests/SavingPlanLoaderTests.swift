//
//  SavingPlanLoaderTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/23.
//

import XCTest
import SavingMoney

protocol DataStore {
    func readData(at url: URL) -> Data?
}

//extension FileManager: DataStore {}

class SavingPlanLoader {
    enum Error: Swift.Error {
        case emptySavingPlan
        case invalidData
        case saveFailure
    }
    
    private var dataStore: DataStore
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }
    
    var planURL: URL {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("savingPlan.cache")
    }
    
    private struct CodablePlan: Codable {
        let name: String
        let startDate: Date
        let initialAmount: Int
    }
        
    func load() throws -> SavingPlan {
        guard let data = dataStore.readData(at: planURL) else {
            throw Error.emptySavingPlan
        }
        
        do {
            let codablePlan = try JSONDecoder().decode(CodablePlan.self, from: data)
            return SavingPlan(name: codablePlan.name, startDate: codablePlan.startDate, initialAmount: codablePlan.initialAmount)
            
        } catch {
            throw Error.invalidData
            
        }

    }
    
    func save(_ savingPlan: SavingPlan) throws {
        
    }
}


class SavingPlanLoaderTests: XCTestCase {
    func test_load_messageStore() {
        let (sut, store) = makeSUT()
        
        _ = try? sut.load()
        XCTAssertEqual(store.messages, [.readData(url: sut.planURL)])
    }
    
    func test_load_throwsEmptySavingPlanErrorOnNilData() {
        let (sut, store) = makeSUT()
        store.stub(data: nil, for: sut.planURL)

        XCTAssertThrowsError(try sut.load()) { error in
            XCTAssertEqual(error as NSError?, SavingPlanLoader.Error.emptySavingPlan as NSError?)
        }
    }
    
    func test_load_throwsInvalidDataErrorOnInvalidData() {
        let (sut, store) = makeSUT()
        store.stub(data: "invalidData".data(using: .utf8)!, for: sut.planURL)
        
        XCTAssertThrowsError(try sut.load()) { error in
            XCTAssertEqual(error as NSError?, SavingPlanLoader.Error.invalidData as NSError?)
        }
    }
    
    func test_load_deliversSavingPlanOnValidData() {
        let (sut, store) = makeSUT()
        let (model, data) = makePlan(name: "awesome-saving-plan", initialAmount: 1)
        store.stub(data: data, for: sut.planURL)
        
        do {
            let plan = try sut.load()
            XCTAssertEqual(plan, model)
            
        } catch {
            XCTFail("Expect not throw")
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
    
    private func makeSUT() -> (SavingPlanLoader, DataStoreSpy) {
        let fileManager = DataStoreSpy()
        let sut = SavingPlanLoader(dataStore: fileManager)
        return (sut, fileManager)
    }
    
    private func anyNSError() -> Error {
        return NSError(domain: "any-nserror", code: -1, userInfo: nil)
    }
    
}

private class DataStoreSpy: DataStore {
    private var stubbedData: Data?
    
    func stub(data: Data?, for url: URL)  {
        stubbedData = data
    }
    
    enum Message: Equatable {
        case readData(url: URL)
    }
    
    private(set) var messages: [Message] = []
    
    func readData(at url: URL) -> Data? {
        messages.append(.readData(url: url))
        return stubbedData
    }
    
}
