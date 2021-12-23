//
//  SavingPlanLoaderTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/23.
//

import XCTest

class SavingPlanLoader {
    private var store: SavingPlanStoreSpy
    
    init(store: SavingPlanStoreSpy) {
        self.store = store
    }
    
    func load() {
        store.load()
    }
}

class SavingPlanLoaderTests: XCTestCase {
    func test_load_messageStore() {
        let (sut, store) = makeSUT()
        
        sut.load()
        XCTAssertEqual(store.messages, [.load])
    }
    
    private func makeSUT() -> (SavingPlanLoader, SavingPlanStoreSpy) {
        let store = SavingPlanStoreSpy()
        let sut = SavingPlanLoader(store: store)
        return (sut, store)
    }
    
}

class SavingPlanStoreSpy {
    enum Message: Equatable {
        case load
    }
    
    private(set) var messages: [Message] = []
    
    func load() {
        messages.append(.load)
    }
    
}
