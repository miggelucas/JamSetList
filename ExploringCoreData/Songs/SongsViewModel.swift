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
    
    private func refreshBand() {
        if let fetchedBand = dataManager.refeshBand(for: self.band) {
            band = fetchedBand
        }
    }
    
    var songs: [Song] {
        band.songArray
    }
    
    var bandName: String {
        band.unwrappedName
    }
    
    func didDismissSheet() {
        isPresentingSheet = false
    }

    func addSongPressed(add songInfo: SongInfo) {
        dataManager.addSong(add: songInfo, from: band) {
            self.didDismissSheet()
            self.refreshBand()
        }
        
    }
    
    func deleteSong(_ song: Song) {
        dataManager.deleteSong(song)
        refreshBand()
    }
    
    func deleteSong(atIndex Index: Int) {
        let selectedSong: Song = songs[Index]
        dataManager.deleteSong(selectedSong)
        refreshBand()
    }
}
