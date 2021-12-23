//
//  SavingPlanLoaderTests.swift
//  SavingMoneyTests
//
//  Created by Paul Lee on 2021/12/23.
//

import XCTest
import SavingMoney

protocol FileManageable {
    func contents(atPath path: String) -> Data?
}

extension FileManager: FileManageable {}

class SavingPlanLoader {
    enum Error: Swift.Error {
        case dataNotFound
        case invalidData
    }
    
    private var fileManager: FileManageable
    
    init(fileManager: FileManageable) {
        self.fileManager = fileManager
    }
    
    var planURL: URL {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("savingPlan.cache")
    }
        
    func load() throws {
        guard let _ = fileManager.contents(atPath: planURL.path) else {
            throw Error.dataNotFound
        }
        
        throw Error.invalidData
        
    }
}


class SavingPlanLoaderTests: XCTestCase {
    func test_load_messageStore() {
        let (sut, fileManager) = makeSUT()
        
        try? sut.load()
        XCTAssertEqual(fileManager.messages, [.requestContent(path: sut.planURL.path)])
    }
    
    func test_load_throwsDataNotFoundErrorOnNilData() {
        let (sut, store) = makeSUT()
        store.stub(data: nil, for: sut.planURL)

        XCTAssertThrowsError(try sut.load()) { error in
            XCTAssertEqual(error as NSError?, SavingPlanLoader.Error.dataNotFound as NSError?)
        }
    }
    
    func test_load_throwsInvalidDataErrorOnEmptyData() {
        let (sut, store) = makeSUT()
        store.stub(data: Data(), for: sut.planURL)
        
        XCTAssertThrowsError(try sut.load()) { error in
            XCTAssertEqual(error as NSError?, SavingPlanLoader.Error.invalidData as NSError?)
        }
    }
    
    private func makeSUT() -> (SavingPlanLoader, FileManagerSpy) {
        let fileManager = FileManagerSpy()
        let sut = SavingPlanLoader(fileManager: fileManager)
        return (sut, fileManager)
    }
    
    private func anyNSError() -> Error {
        return NSError(domain: "any-nserror", code: -1, userInfo: nil)
    }
    
}

class FileManagerSpy: FileManageable {
    enum Message: Equatable {
        case requestContent(path: String)
    }
    
    private(set) var messages: [Message] = []
    
    func contents(atPath path: String) -> Data? {
        messages.append(.requestContent(path: path))
        return stubbedData
    }
    
    private var stubbedData: Data?
    
    func stub(data: Data?, for url: URL)  {
        stubbedData = data
    }
    
}
