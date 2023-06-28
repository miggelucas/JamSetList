//
//  SetList+CoreDataProperties.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 28/06/23.
//
//

import Foundation
import CoreData


extension SetList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SetList> {
        return NSFetchRequest<SetList>(entityName: "SetList")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var instument: String?
    @NSManaged public var songs: NSSet?

}

// MARK: Generated accessors for songs
extension SetList {

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: Song)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: Song)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: NSSet)

}

extension SetList : Identifiable {

}
