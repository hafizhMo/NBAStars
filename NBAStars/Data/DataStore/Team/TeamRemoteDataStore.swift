//
//  TeamRemoteDataStore.swift
//  NBAStars
//
//  Created by Hafizh Mo on 27/10/22.
//

import Foundation
import CloudKit

class TeamRemoteDataStore {
    
    private let database = CKManager.database
    private(set) var team = [TeamModel]()
    static var currentDataStore = TeamLocalDataStore()
    
    func refresh(_ completion: @escaping (Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Team", predicate: predicate)
        teams(forQuery: query, completion)
    }
    
    private func teams(forQuery query: CKQuery, _ completion: @escaping (Error?) -> Void) {
        database.perform(query, inZoneWith: CKRecordZone.default().zoneID) { [weak self] results, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let results = results else { return }
            self.team = results.compactMap {
                TeamModel(record: $0)
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
    func fetchTeam(for references: CKRecord.Reference, _ completion: @escaping (TeamModel) -> Void) {
        let recordIDs = [references.recordID]
        let operation = CKFetchRecordsOperation(recordIDs: recordIDs)
        operation.qualityOfService = .utility

        operation.fetchRecordsCompletionBlock = { records, error in
            let team = records?.values.map(TeamModel.init) ?? []
            DispatchQueue.main.async {
                completion(team[0])
            }
        }
        database.add(operation)
    }
}
