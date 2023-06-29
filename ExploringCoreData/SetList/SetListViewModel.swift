//
//  SetListViewModel.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 28/06/23.
//

import Foundation

class SetListViewModel: ObservableObject {
    
    var songs: [Song]
    
    init() {
        self.songs = CoreDataManager.shared.fetchSongs()
    }
    
}

