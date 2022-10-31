//
//  TeamModel.swift
//  NBAStars
//
//  Created by Hafizh Mo on 27/10/22.
//

import Foundation
import CloudKit

class TeamModel {
    let id: CKRecord.ID
    let name: String
    let fullname: String
    let codeName: String
    let image: CKAsset
    
    init(record: CKRecord) {
        self.id = record.recordID
        self.name = record["name"] as! String
        self.fullname = record["fullname"] as! String
        self.codeName = record["codeName"] as! String
        self.image = record["imageLogo"] as! CKAsset
    }
}

extension TeamModel: Hashable {
    static func == (lhs: TeamModel, rhs: TeamModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
