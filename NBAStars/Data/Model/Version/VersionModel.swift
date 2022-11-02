//
//  VersionModel.swift
//  NBAStars
//
//  Created by Hafizh Mo on 02/11/22.
//

import CloudKit

class VersionModel {
    let id: CKRecord.ID
    let version: String
    
    init?(record: CKRecord) {
        self.id = record.recordID
        self.version = record["codeNumber"] as! String
    }
}

extension VersionModel: Hashable {
    static func == (lhs: VersionModel, rhs: VersionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
