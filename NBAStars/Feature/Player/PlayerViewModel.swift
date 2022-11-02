//
//  PlayerViewModel.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import UIKit
import Combine

class PlayerViewModel {
    
    enum State {
        case initialize
        case onLoading
        case onSuccess
        case onFailure
    }
    
    @Published private(set) var players: [Player] = []
    @Published private(set) var filteredPlayers: [Player] = []
    @Published private(set) var state: State = .initialize
    private let repo = PlayerRepository.shared
    
    func fetchMember(){
        state = .onLoading
        
        self.repo.getPlayers(successHandler: { datas in
            self.players = datas
            self.state = datas.isEmpty ? .onFailure : .onSuccess
        }) { error in
            self.state = .onFailure
            print("### \(#function): Failed to fetch players in remote: \(error ?? "")")
        }
        
    }
    
    func filterPlayer(keyword: String) {
        filteredPlayers = players.filter({ player -> Bool in
            return player.name.lowercased().contains(keyword)
        })
    }
}
