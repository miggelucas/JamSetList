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
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(viewModel.bands) { band in
                    NavigationLink {
                        SongsView(viewModel: SongsViewModel(band: band))
                        
                    } label: {
                        Text(band.unwrappedName)
                            .contextMenu {
                                Button("Delete", role: .destructive) {
                                    withAnimation(.easeIn(duration: 1)) {
                                        viewModel.deleteBand(for: band)
                                    }
                                }
                                
                            }
                        
                    }
                }
                .onDelete { offsets in
                    withAnimation() {
                        offsets.forEach { index in
                            viewModel.deleteBand(atIndex: index)
                        }
                    }
                }
            }
            
            .navigationTitle("Bands")
            .toolbar {
                Button {
                    
                    viewModel.isPresentingSheet = true
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            
            .sheet(isPresented: $viewModel.isPresentingSheet) {
                //                sheetView
            }
            
        }
    }
    
    
    private var sheetView: some View {
        
        VStack {
            Form {
                Section("ADICIONAR BANDA") {
                    TextField("Nome da banda", text: $viewModel.bandName)
                        .submitLabel(.done)
                        .onSubmit {
                            viewModel.addBandPressed()
                        }
                }
            }
            
            Button {
                viewModel.addBandPressed()
                
            } label: {
                Text("Adicionar")
                
            }
            
            Spacer()
            
            
        }
        .toolbar {
            Button {
                viewModel.addBandPressed()
            } label: {
                Image(systemName: "plus")
            }

        }
        
    }
    
    
}

struct BandsView_Previews: PreviewProvider {
    static var previews: some View {
        BandsView()
    }
}
