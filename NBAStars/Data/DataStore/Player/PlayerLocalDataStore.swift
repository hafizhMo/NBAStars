//
//  PlayerLocalDataStore.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import Foundation
import CoreData

class PlayerLocalDataStore {

    private let context = CDManager.shared.context
    private let teamDS = TeamLocalDataStore()
    
    func getAllPlayer() -> [Player] {
        let fetchRequest: NSFetchRequest = Player.fetchRequest()
        
        guard let players = try? context.fetch(fetchRequest) else {
            return []
        }
        return players
    }
    
    func insertBatch(players: [PlayerModel]) {
        do {
            players.forEach { player in
                let localPlayer = Player(context: context)
                localPlayer.name = player.name
                localPlayer.birthday = player.birthday
                localPlayer.backNumber = player.backNumber
                player.image.generateImage { photo in
                    localPlayer.imagePhoto = photo
                }
//                print(player.team!)
//                localPlayer.team = team.getTeam(team: player.team!)
            }
            try context.save()
            context.reset()
            print("### \(#function): One by one inserted \(players.count)")
        } catch {
            print("### \(#function): Failed to insert players in batch: \(error)")
        }
    }
    
    func assignTeam(name: String, team: TeamModel) {
        let fetchRequest: NSFetchRequest = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        guard let player = try? context.fetch(fetchRequest).first else {
            return
        }
        
        do {
            player.team = teamDS.getTeam(team: team)
            
            try context.save()
//            context.reset()
            print("### \(#function): inserted \(team.name)")
        } catch {
            print("### \(#function): Failed to insert team: \(error)")
        }
    }
}
