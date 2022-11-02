//
//  VersionRepository.swift
//  NBAStars
//
//  Created by Hafizh Mo on 02/11/22.
//

import Foundation

class VersionRepository {
    
    private var remoteDataStore: VersionRemoteDataStore
    
    private init(remoteDataStore: VersionRemoteDataStore) {
        self.remoteDataStore = remoteDataStore
    }
    
    static let shared = VersionRepository(remoteDataStore: VersionRemoteDataStore())
    
    func getVersion(success: @escaping (String) -> ()) {
        remoteDataStore.refresh { error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            DispatchQueue.global().async {
                success(self.remoteDataStore.version!.version)
            }
        }
    }
}
