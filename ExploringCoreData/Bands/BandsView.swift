//
//  BandsView.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 24/06/23.
//

import SwiftUI

struct BandsView: View {
    
    @ObservedObject var viewModel: BandsViewModel
    
    init(viewModel: BandsViewModel = BandsViewModel()) {
        self.viewModel = viewModel
    }
    
    private var emptyView: some View {
        VStack(spacing: 40) {
            Image(systemName: "music.mic.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text("1. Nessa tela você pode visualizar as bandas.")
                Text("2. Utilize o botão superior para estar adicionando novas bandas para sua lista.")
                Text("3. Para adicionar músicas para essa banda, basta clicar nela.")
                Text("4. Caso deseje, você pode exluir uma banda a deslizando para a esquerda.")
                
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
                    bandList
                case .empty:
                    emptyView
                }
                
            }
            .navigationTitle("Bandas")
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
        }
    }
    
    
    private var bandList: some View {
        List{
            ForEach(viewModel.bands) { band in
                NavigationLink {
                    SongsView(viewModel: SongsViewModel(band: band))
                    
                } label: {
                    BandRow(band: band)
                        .contextMenu {
                            Button("Delete", role: .destructive) {
                                withAnimation(.easeIn(duration: 1)) {
                                    viewModel.deleteBand(for: band)
                                }
                            }
                            
                        }
                    
                }
            }
//            .onMove(perform: { indices, newOffset in
//                print(indices)
//                print(newOffset)
//            })
            
            .onDelete { offsets in
                withAnimation(.easeInOut(duration: 1)) {
                    offsets.forEach { index in
                        viewModel.deleteBand(atIndex: index)
                    }
                }
            }
        }
    }
    
    private var sheetView: some View {
        AddBandView(viewModel: viewModel.addBandViewModel)
        
    }
    
    
}

struct BandsView_Previews: PreviewProvider {
    static var previews: some View {
        BandsView()
    }
}
