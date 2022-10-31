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
    
    func getTeams(successHandler: @escaping ([Team]) -> Void,
                    failureHandler: @escaping (String?) -> Void) {
        var teams = localDataStore.getAllTeam()
        
        if teams.isEmpty {
            remoteDataStore.refresh { error in
                if let error = error {
                    failureHandler(error.localizedDescription)
                }

                DispatchQueue.global().async {
                    self.localDataStore.insertBatch(teams: self.remoteDataStore.teams)

                    teams = self.localDataStore.getAllTeam()
                    successHandler(teams)
                }
            }
            return
        }
        successHandler(teams)
    }
}
