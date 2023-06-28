//
//  SongsView.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 26/06/23.
//

import SwiftUI

struct SongsView: View {
    
    @ObservedObject var viewModel: SongsViewModel
    
    init(viewModel: SongsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(viewModel.songs) { song in
                Text(song.unwrappedName)
                    .contextMenu {
                        Button("Delete", role: .destructive) {
                            withAnimation(.easeInOut(duration: 1)) {
                                viewModel.deleteSong(song)
                            }
                        }
                    }
            }
            .onDelete { offset in
                withAnimation(.easeInOut(duration: 1)) {
                    offset.forEach { index in
                        viewModel.deleteSong(atIndex: index)
                    }
                }
                
            }
            .toolbar {
                Button {
                    viewModel.isPresentingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            .sheet(isPresented: $viewModel.isPresentingSheet) {
                VStack {
                    Form {
                        Section("ADICIONAR Música") {
                            TextField("Nome da música", text: $viewModel.songName)
                                .submitLabel(.done)
                                .onSubmit {
                                    viewModel.addSongPressed()
                                }
                        }
                    }
                    
                    Button {
                        viewModel.addSongPressed()
                        
                    } label: {
                        Text("Adicionar")
                        
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    
                    
                }
            }
            
            .navigationTitle(viewModel.band.unwrappedName)
        }
    }
}


struct SongsView_Previews: PreviewProvider {
    static var band: Band {
        let band = Band()
        band.id = UUID()
        band.name = "Gulliver"
        return band
    }
    
    static var previews: some View {
        SongsView(viewModel: SongsViewModel(band: band))
    }
}
