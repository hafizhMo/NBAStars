//
//  PlayerRemoteDataStore.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import Foundation
import CloudKit

class PlayerRemoteDataStore {
    
    private let database = CKManager.database
    private(set) var players = [PlayerModel]()
    
    func refresh(_ completion: @escaping (Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Player", predicate: predicate)
        players(forQuery: query, completion)
    }
    
    private func players(forQuery query: CKQuery, _ completion: @escaping (Error?) -> Void) {
        database.perform(query, inZoneWith: CKRecordZone.default().zoneID) { [weak self] results, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let results = results else { return }
            self.players = results.compactMap {
                PlayerModel(record: $0)
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
}
