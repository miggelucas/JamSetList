//
//  Song+CoreDataProperties.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 28/06/23.
//
//

import Foundation
import CoreData


extension Song {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var key: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var artist: String?
    @NSManaged public var isDropTune: String?
    @NSManaged public var band: Band?
    
    
    public var unwrappedID: UUID {
        id ?? UUID()
    }
    
    public var unwrappedName: String {
        name ?? "unknow song name"
    }
    
    
    public var unwrappedArtistName: String {
        artist ?? "unknow artist name"
    }
    
    var unwrappedKey: SongKey {
        if let rawKey = key {
            switch rawKey {
            case "-3":
                return .minus3
            case "-2":
                return .minus2
            case "-1":
                return .minus1
            case "+1":
                return .added1
            case "+2":
                return .added2
            case "+3":
                return .added3
                
            default:
                return .original
            }
        } else {
            return .original
        }
    }
    
    public var uwnrappedIsDroptune: Bool {
        if isDropTune != nil {
            return true
        } else {
            return false
        }
    }
    

}


extension Song : Identifiable {

}
