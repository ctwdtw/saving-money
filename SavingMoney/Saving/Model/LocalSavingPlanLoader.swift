//
//  LocalSavingPlanLoader.swift
//  SavingMoney
//
//  Created by Paul Lee on 2021/12/24.
//

import Foundation

public class LocalSavingPlanLoader: SavingPlanLoader, SavingPlanCache {
    public enum Error: Swift.Error {
        case emptySavingPlan
        case invalidData
        case saveFailure
    }
    
    private var dataStore: DataStore
    
    public init(dataStore: DataStore) {
        self.dataStore = dataStore
    }
    
    public var planURL: URL {
        return FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("savingPlan.cache")
    }
    
    private struct CodablePlan: Codable {
        let name: String
        let startDate: Date
        let initialAmount: Int
    }
        
    public func load() throws -> SavingPlan {
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
    
    public func save(_ savingPlan: SavingPlan) throws {
        do {
            let codablePlan = CodablePlan(name: savingPlan.name, startDate: savingPlan.startDate, initialAmount: savingPlan.initialAmount)
            let data = try JSONEncoder().encode(codablePlan)
            try dataStore.writeData(data, at: planURL)

        } catch {
            throw Error.saveFailure

        }
    }
    
    public func delete() {
        
    }
}
