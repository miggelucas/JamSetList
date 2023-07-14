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
    @NSManaged public var instrument: String?
    @NSManaged public var creationDate: Date?
    
    public var unwrappedName: String {
        name ?? "unknow Band name"
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
    
    var unwreappedInstrumnent: Instrument {
        guard let instrumentRaw = self.instrument else { return .vocal }
        
        return Instrument(rawValue: instrumentRaw) ?? .vocal
        
    }
    
    static public func createDummyBand() -> Band {
        let dummyBand = Band()
        dummyBand.id = UUID()
        dummyBand.name = "iCarly"
        dummyBand.instrument = "guitar"
    
        
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
