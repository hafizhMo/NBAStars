//
//  TeamLocalDataStore.swift
//  NBAStars
//
//  Created by Hafizh Mo on 27/10/22.
//

import Foundation
import CoreData

class TeamLocalDataStore {
    
    private let context = CDManager.shared.context
    
    func getAllTeam() -> [Team] {
        let fetchRequest: NSFetchRequest = Team.fetchRequest()
        
        guard let teams = try? context.fetch(fetchRequest) else {
            return []
        }
        return teams
    }
    
    func getTeamByRecordName(recordName: String) -> Team? {
        let fetchRequest: NSFetchRequest = Team.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "recordName = %@", recordName)
        
        guard let team = try? context.fetch(fetchRequest).first else {
            return nil
        }
        return team
    }
    
    func insertBatch(teams: [TeamModel]) {
        do {
            teams.forEach { team in
                let localTeam = Team(context: context)
                localTeam.name = team.name
                localTeam.fullname = team.fullname
                localTeam.codeName = team.codeName
                team.image.generateImage { photo in
                    localTeam.imageLogo = photo
                }
                
                localTeam.recordName = team.id.recordName
            }
            try context.save()
            context.reset()
            print("### \(#function): One by one inserted \(teams.count)")
        } catch {
            print("### \(#function): Failed to insert players in batch: \(error)")
        }
    }
    
}
