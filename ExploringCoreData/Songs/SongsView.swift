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
        
        VStack {
            switch viewModel.state {
            case .content:
                listView
            case .empty:
                Text("empty State")
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
            sheetView
        }
        
        .navigationTitle(viewModel.band.unwrappedName)
        
    }
    
    private var listView: some View {
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
            
        }
    }

    
    private var sheetView: some View {
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
}


struct SongsView_Previews: PreviewProvider {

    static var previews: some View {
        let coreDataManager = CoreDataManager.preview
        let dummyBand = coreDataManager.fetchBands().first!
        SongsView(viewModel: SongsViewModel(band: dummyBand))
    }
}
