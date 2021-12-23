//
//  SavingPlanLoaderTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/23.
//

import XCTest
import SavingMoney

class SavingPlanLoader {
    enum Error: Swift.Error {
        case storeFailure
    }
    
    private var store: SavingPlanStoreSpy
    
    init(store: SavingPlanStoreSpy) {
        self.store = store
    }
    
    func load() throws {
        do {
            try store.load()
            
        } catch {
            throw Error.storeFailure
        }
        
    }
}

class SavingPlanLoaderTests: XCTestCase {
    func test_load_messageStore() {
        let (sut, store) = makeSUT()
        
        try? sut.load()
        XCTAssertEqual(store.messages, [.load])
    }
    
    func test_load_throwsStoreFailedOnStoreError() {
        let (sut, store) = makeSUT()
        store.stub(.failure(anyNSError()))
        
        XCTAssertThrowsError(try sut.load()) { error in
            XCTAssertEqual(error as NSError?, SavingPlanLoader.Error.storeFailure as NSError?)
        }
    }
    
    private func makeSUT() -> (SavingPlanLoader, SavingPlanStoreSpy) {
        let store = SavingPlanStoreSpy()
        let sut = SavingPlanLoader(store: store)
        return (sut, store)
    }
    
    private func anyNSError() -> Error {
        return NSError(domain: "any-nserror", code: -1, userInfo: nil)
    }
    
}

class SavingPlanStoreSpy {
    enum Message: Equatable {
        case load
    }
    
    typealias SavingPlanResult = Result<Data, Error>
    
    private(set) var messages: [Message] = []
    
    var stubbedResult: SavingPlanResult?
    func stub(_ result: SavingPlanResult)  {
        stubbedResult = result
    }
    
    func load() throws {
        messages.append(.load)
        switch stubbedResult {
        case .success(let data):
            break
        case .failure(let error):
            throw error
        default:
            break
        }
    }

}
