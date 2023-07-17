//
//  SongRow.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 16/07/23.
//

import SwiftUI

struct SongRow: View {
    let song: Song
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(song.unwrappedName)
                .font(.callout)
                .foregroundStyle(.primary)
            
            HStack {
                Text(song.unwrappedArtistName)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("Tom: \(song.unwrappedKey.rawValue)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                if let _ = song.isDropTune {
                    Spacer()
                    
                    Text("Drop")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
            }
           
        }
    }
}

//#Preview {
//    SongRow()
//}
