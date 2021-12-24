//
//  DataStore.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/24.
//

import Foundation
public protocol DataStore {
    func readData(at url: URL) -> Data?
    func writeData(_ data: Data, at url: URL) throws
}

extension FileManager: DataStore {
    public func readData(at url: URL) -> Data? {
        contents(atPath: url.path)
    }
    
    public func writeData(_ data: Data, at url: URL) throws {
        try data.write(to: url)
    }
}
