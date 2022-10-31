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
    
    func getPlayers(successHandler: @escaping ([Player]) -> Void,
                    failureHandler: @escaping (String?) -> Void) {
        var players = localDataStore.getAllPlayer()
        
        if players.isEmpty {
            remoteDataStore.refresh { error in
                if let error = error {
                    failureHandler(error.localizedDescription)
                }

                DispatchQueue.global().async {
                    self.localDataStore.insertBatch(players: self.remoteDataStore.players)

                    players = self.localDataStore.getAllPlayer()
                    successHandler(players)
                }
            }
            return
        }
        successHandler(players)
    }
    
}
