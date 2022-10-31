//
//  Position+CoreDataProperties.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//
//

import Foundation
import CoreData


extension Position {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Position> {
        return NSFetchRequest<Position>(entityName: "Position")
    }

    @NSManaged public var name: String?
    @NSManaged public var codeName: String?
    @NSManaged public var players: NSSet?

}

// MARK: Generated accessors for players
extension Position {

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: Player)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: Player)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)

}

extension Position : Identifiable {

}
