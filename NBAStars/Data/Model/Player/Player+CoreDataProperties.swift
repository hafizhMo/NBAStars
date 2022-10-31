//
//  Player+CoreDataProperties.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String
    @NSManaged public var backNumber: Int64
    @NSManaged public var birthday: Date
    @NSManaged public var imagePhoto: Data?
    @NSManaged public var position: Position?
    @NSManaged public var team: Team?

}

extension Player : Identifiable {

}
