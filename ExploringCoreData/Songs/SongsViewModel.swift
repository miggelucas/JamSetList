//
//  SongsViewModel.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 26/06/23.
//

import Foundation

class SongsViewModel: ObservableObject {
    
    @Published var band: Band
    
    @Published var isPresentingSheet: Bool = false
    @Published var songName: String = ""
    
    enum State {
        case empty, content
    }
    
    var state: State {
        if songs.isEmpty {
            return .empty
        } else {
            return .content
        }
    }

    init(band: Band) {
        self.band = band
    }
    
    var dataManager: CoreDataManager {
        CoreDataManager.shared
    }
    
    var songs: [Song] {
        band.songsArray
    }

    func addSongPressed() {
        dataManager.addSong(title: songName, from: band)
        isPresentingSheet = false
        songName = ""
        
        if let fetchedBand = dataManager.refeshBand(for: band) {
            print("fetchedBand \(fetchedBand.unwrappedId)")
            band = fetchedBand
        } else {
            print("Não foi possível encontrar a banda para ser atualizada")
        }
        
    }
    
    func deleteSong(_ song: Song) {
        dataManager.deleteSong(song)
    }
    
    func deleteSong(atIndex Index: Int) {
        let selectedSong: Song = songs[Index]
        dataManager.deleteSong(selectedSong)
    }
}
