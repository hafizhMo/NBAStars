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
    let teamID: CKRecord.ID
    
    init?(record: CKRecord) {
        self.id = record.recordID
        self.name = record["name"] as! String
        self.backNumber = record["backNumber"] as! Int64
        self.birthday = record["birthday"] as! Date
        self.image = record["imagePhoto"] as! CKAsset
        self.teamID = (record["team"] as! CKRecord.Reference).recordID
        
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
