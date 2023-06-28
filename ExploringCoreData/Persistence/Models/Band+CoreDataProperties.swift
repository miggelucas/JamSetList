//
//  Band+CoreDataProperties.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 28/06/23.
//
//

import Foundation
import CoreData


extension Band {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Band> {
        return NSFetchRequest<Band>(entityName: "Band")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var songs: NSSet?
    
    public var unwrappedName: String {
        name ?? "unknow name"
    }
    
    public var unwrappedId: UUID {
        id ?? UUID()
    }

    public var unwrappedSongs: Set<Song> {
        return songs as? Set<Song> ?? []
    }
    
    public var songsArray: [Song] {
        return Array(unwrappedSongs)
    }
    
    static public func createDummyBand() -> Band {
        let dummyBand = Band()
        dummyBand.id = UUID()
        dummyBand.name = "iCarly"
    
        
        return dummyBand
    }

}

// MARK: Generated accessors for songs
extension Band {

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: Song)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: Song)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: NSSet)

}

extension Band : Identifiable {

}
