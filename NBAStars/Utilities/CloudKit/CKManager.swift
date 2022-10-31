//
//  CKManager.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import Foundation
import CloudKit

class CKManager {
    static let database = CKContainer(identifier: "iCloud.com.hafizhmo.NBAStars").publicCloudDatabase
}

enum TableName: String {
    case Position
    case Player
    case Team
}
