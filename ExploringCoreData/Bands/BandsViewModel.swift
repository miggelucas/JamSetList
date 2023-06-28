//
//  BandsViewModel.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 24/06/23.
//

import Foundation
import SwiftUI

class BandsViewModel: ObservableObject {
    
    @Published var bands: [Band]
    
    @Published var isPresentingSheet: Bool = false
    @Published var bandName: String = ""
    
    enum State {
        case empty, content
    }
    
    var state: State {
        if bands.isEmpty {
            return .empty
        } else {
            return .content
        }
    }
    
    let dataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.dataManager = coreDataManager
        self.bands = dataManager.fetchBands()
    }
    
    private func refreshBands() {
        self.bands = dataManager.fetchBands()
    }
    
    func addBandPressed() {
        dataManager.addBand(name: bandName)
        isPresentingSheet = false
        bandName = ""
        
        refreshBands()
        
    }
    
    func deleteBand(for band: Band) {
        dataManager.deleteBand(for: band)
        refreshBands()
    }
    
    func deleteBand(atIndex index: Int) {
        let selectedBand: Band = bands[index]
        dataManager.deleteBand(for: selectedBand)
        refreshBands()
    }
}
