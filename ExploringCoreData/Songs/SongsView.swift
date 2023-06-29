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
    
    private var emptyStateView: some View {
        VStack(spacing: 40) {
            Image(systemName: "music.note.list")
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text("1. Nessa tela você pode visualizar as músicas dessa banda")
                Text("2. Utilize o botão superior para estar adicionando novas músicas para a lista.")
                Text("3. Para acessar mais informações dessa música, basta clicar nela")
                Text("4. Caso deseje, você pode exluir uma música deslizando para a esquerda.")
                
            }
            
            .font(.headline)
            
        }
        .foregroundColor(.secondary)
        .padding(.horizontal, 50)
        
        
        
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .content:
                    listView
                case .empty:
                    emptyStateView
                }
                  
                
            }
            .toolbar {
                Button {
                    viewModel.isPresentingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            .sheet(isPresented: $viewModel.isPresentingSheet, onDismiss: {
                viewModel.didDismissSheet()
            }) {
                sheetView
            }
            
            .navigationTitle(viewModel.band.unwrappedName)
            
        }
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
                        .textInputAutocapitalization(.sentences)
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
