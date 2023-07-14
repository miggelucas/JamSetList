//
//  BandRow.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 14/07/23.
//

import SwiftUI

struct BandRow: View {
    let band: Band
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(band.unwrappedName)
                .font(.headline)
                .foregroundStyle(.primary)
            Text(band.unwreappedInstrumnent.rawValue)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
        }

    }
}

//#Preview {
//    BandRow(band:)
//}
