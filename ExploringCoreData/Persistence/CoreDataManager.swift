//
//  CoreDataManager.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 24/06/23.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static var shared: CoreDataManager = CoreDataManager()
    
    static var preview: CoreDataManager {
        let manager = CoreDataManager(inMemory: true)
        
        let dummyBand = Band(context: manager.context)
        dummyBand.id = UUID()
        dummyBand.name = "Los Sebosos Postizos"

        return manager
    }
    
    
    var container: NSPersistentContainer
    
    init(inMemory: Bool = false, persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "Persistence")) {
        
        self.container = persistentContainer
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error loading persistence container: \(error.userInfo)")
            }
        }
        
        
    }
    
    var context: NSManagedObjectContext  {
        container.viewContext
    }
    
    
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error at saving context: \(error)")
            }
        }
    }
    
    
    func addBand(name: String) {
        let band = Band(context: context)
        band.id = UUID()
        band.name = name
        
        saveContext()
        
    }
    
    
    func fetchBands() -> [Band] {
        let request: NSFetchRequest<Band> = Band.fetchRequest()
        
        var fetchedBands: [Band] = []
        
        do {
            fetchedBands = try context.fetch(request)
        } catch {
            print("error fetching bands: \(error)")
        }
        
        return fetchedBands
        
    }
    
    func deleteBand(for band: Band) {
        context.delete(band)
        saveContext()
    }
    
    
    func addSong(title songName: String, from band: Band) {
        let song = Song(context: context)
        song.name = songName
        song.id = UUID()
        band.addToSongs(song)
        
        saveContext()
    }
    
    func deleteSong(_ song: Song) {
        context.delete(song)
        saveContext()
    }
    
    func refeshBand(for band: Band) -> Band? {
        let request: NSFetchRequest<Band> = Band.fetchRequest()
        
        let predicate: NSPredicate = NSPredicate(format: "id == %@", band.unwrappedId as CVarArg)
        
        request.predicate = predicate
        
        var band: Band?
        
        do {
            if let fetchedBand = try context.fetch(request).first {
                band = fetchedBand
            } else {
                print("could not find band for refresh")
            }
            
        } catch {
            print("Failed to refresh Band")
        }
        
        return band
    }
    
   
}
