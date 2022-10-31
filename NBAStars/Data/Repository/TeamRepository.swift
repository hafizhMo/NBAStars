//
//  TeamRepository.swift
//  NBAStars
//
//  Created by Hafizh Mo on 31/10/22.
//

import Foundation

class TeamRepository {
    private var localDataStore: TeamLocalDataStore
    private var remoteDataStore: TeamRemoteDataStore
    
    private init(localDataStore: TeamLocalDataStore, remoteDataStore: TeamRemoteDataStore) {
        self.localDataStore = localDataStore
        self.remoteDataStore = remoteDataStore
    }
    
    static let shared = TeamRepository(localDataStore: TeamLocalDataStore(), remoteDataStore: TeamRemoteDataStore())
    
    func getAllTeam() -> [Team] {
        return localDataStore.getAllTeam()
    }
}
