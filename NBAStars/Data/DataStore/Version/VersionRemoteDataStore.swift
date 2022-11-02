//
//  VersionRemoteDataStore.swift
//  NBAStars
//
//  Created by Hafizh Mo on 02/11/22.
//

import CloudKit

class VersionRemoteDataStore {
    
    private let database = CKManager.database
    private(set) var version: VersionModel?
    
    func refresh(_ completion: @escaping (Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Version", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        player(forQuery: query, completion)
    }
    
    private func player(forQuery query: CKQuery, _ completion: @escaping (Error?) -> Void) {
        database.perform(query, inZoneWith: CKRecordZone.default().zoneID) { [weak self] results, error in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            guard let result = results?.first else { return }
            self.version = VersionModel(record: result)
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
    
}
