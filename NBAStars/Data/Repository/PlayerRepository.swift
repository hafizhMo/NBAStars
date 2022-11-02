//
//  PlayerRepository.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import Foundation

class PlayerRepository {
    
    private var localDataStore: PlayerLocalDataStore
    private var remoteDataStore: PlayerRemoteDataStore
    
    private init(localDataStore: PlayerLocalDataStore, remoteDataStore: PlayerRemoteDataStore) {
        self.localDataStore = localDataStore
        self.remoteDataStore = remoteDataStore
    }
    
    static let shared = PlayerRepository(localDataStore: PlayerLocalDataStore(), remoteDataStore: PlayerRemoteDataStore())
    
    private let versionDataStore = VersionRepository.shared
    private let teamDataStore = TeamRepository.shared
    
    func getPlayers(successHandler: @escaping ([Player]) -> Void,
                    failureHandler: @escaping (String?) -> Void) {
        
        versionDataStore.getVersion { remoteVersion in
            if let version = UserDefaults.standard.version, version == remoteVersion {
                successHandler(self.localDataStore.getAllPlayer())
                return
            }
            UserDefaults.standard.version = remoteVersion
            
            self.teamDataStore.getTeams { teams in
                self.remoteDataStore.refresh { error in
                    if let error = error {
                        failureHandler(error.localizedDescription)
                    }
                    
                    DispatchQueue.global().async {
                        self.localDataStore.insertBatch(players: self.remoteDataStore.players)
                        successHandler(self.localDataStore.getAllPlayer())
                    }
                }
            } failureHandler: { error in
                print(error!)
            }
        }
    }
    
}
