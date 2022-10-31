//
//  TeamViewModel.swift
//  NBAStars
//
//  Created by Hafizh Mo on 31/10/22.
//

import UIKit
import Combine

class TeamViewModel {
    
    enum State {
        case initialize
        case onLoading
        case onSuccess
        case onFailure
    }
    
    @Published private(set) var teams: [Team] = []
    @Published private(set) var state: State = .initialize
    private let repo = TeamRepository.shared
    
    func fetchMember(){
        state = .onLoading
        
        repo.getTeams(successHandler: { datas in
            self.teams = datas
            self.state = datas.isEmpty ? .onFailure : .onSuccess
        }) { error in
            self.state = .onFailure
            print("### \(#function): Failed to fetch players in remote: \(error ?? "")")
        }
    }
    
}
