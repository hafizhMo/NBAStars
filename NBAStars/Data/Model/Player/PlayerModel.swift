//
//  Player+CloudKit.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import CloudKit
import UIKit

class PlayerModel {
    let id: CKRecord.ID
    let name: String
    let backNumber: Int64
    let birthday: Date
    let image: CKAsset
    var team: TeamModel?
    
    init?(record: CKRecord) {
        self.id = record.recordID
        self.name = record["name"] as! String
        self.backNumber = record["backNumber"] as! Int64
        self.birthday = record["birthday"] as! Date
        self.image = record["imagePhoto"] as! CKAsset
        
        if let teamRecords = record["team"] as? CKRecord.Reference {
            TeamRemoteDataStore().fetchTeam(for: teamRecords) { teams in
                self.team = teams
                PlayerLocalDataStore().assignTeam(name: self.name, team: teams)
                print(teams.name)
            }
        }
    }
}

extension PlayerModel: Hashable {
    static func == (lhs: PlayerModel, rhs: PlayerModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
