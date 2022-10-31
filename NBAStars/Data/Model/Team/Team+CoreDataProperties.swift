//
//  Team+CoreDataProperties.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var name: String
    @NSManaged public var recordName: String
    @NSManaged public var fullname: String
    @NSManaged public var codeName: String
    @NSManaged public var division: Int16
    @NSManaged public var imageLogo: Data?
    @NSManaged public var players: NSSet?
    
    var divisionValue: NBADivision {
        get {
            return NBADivision(rawValue: division) ?? .Eastern
        }
        set {
            division = newValue.rawValue
        }
    }
}

// MARK: Generated accessors for players
extension Team {

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: Player)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: Player)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)

}

extension Team : Identifiable {

}
