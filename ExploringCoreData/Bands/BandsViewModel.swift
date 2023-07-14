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
    @Published var chosenInstrument: Instrument = .eletricGuitar
    
    @Published var addBandViewModel: AddBandViewModel = AddBandViewModel()
    
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
        addBandViewModel.degalete = self
    }

    
    private func refreshBands() {
        self.bands = dataManager.fetchBands()
    }
    
    func didDismissSheet() {
        isPresentingSheet = false
        bandName = ""
        chosenInstrument = .eletricGuitar
    }
    
    func addBandPressed() {
        dataManager.addBand(name: bandName,
                            instrument: chosenInstrument)
        didDismissSheet()

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

extension BandsViewModel: addNewBandDelegate {
    func refreshBandList() {
        didDismissSheet()
        refreshBands()
    }
    
}
