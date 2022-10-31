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
    
    func getTeam(team: TeamModel) -> Team? {
        let fetchRequest: NSFetchRequest = Team.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", team.name)
        
        guard let team = try? context.fetch(fetchRequest).first else {
            do {
                let newTeam = Team(context: context)
                newTeam.name = team.name
                newTeam.fullname = team.fullname
                newTeam.codeName = team.codeName
                team.image.generateImage { photo in
                    newTeam.imageLogo = photo
                }
                
                try context.save()
            } catch {
                
            }
            return getTeam(team: team)
        }
        
        return team
    }
    
    func getAllTeam() -> [Team] {
        let fetchRequest: NSFetchRequest = Team.fetchRequest()
        
        guard let teams = try? context.fetch(fetchRequest) else {
            return []
        }
        
        return teams
    }
}
