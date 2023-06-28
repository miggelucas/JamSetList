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
    @NSManaged public var band: Band?
    @NSManaged public var setList: SetList?
    
    public var unwrappedID: UUID {
        id ?? UUID()
    }
    
    public var unwrappedName: String {
        name ?? "unknow song name"
    }
    
    
//    enum Key: String {
//        case original, minus1, minus2, minus3, added1, added2, added3
//    }
    
    public var unwrappedKey: String {
        key ?? "Original"
    }
    

}

extension Song : Identifiable {

}
