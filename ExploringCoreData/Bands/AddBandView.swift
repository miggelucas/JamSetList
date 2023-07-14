//
//  AddBandView.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 14/07/23.
//

import SwiftUI


class AddBandViewModel: ObservableObject {
    
    var dataManager = CoreDataManager.shared
    
    var degalete: addNewBandDelegate?
    
    @Published var bandName = ""
    @Published var instrument: Instrument = .eletricGuitar
    
    func addBandPressed() {
        dataManager.addBand(name: bandName,
                            instrument: instrument)
        
        degalete?.refreshBandList()
        
    }
}

protocol addNewBandDelegate {
    func refreshBandList()
}

struct AddBandView: View {
    
    @ObservedObject var viewModel: AddBandViewModel
    
    @FocusState var isBandNameFocused: Field?
    
    enum Field: Int, Hashable {
        case name, none
    }
    
    init(viewModel: AddBandViewModel = AddBandViewModel(), focus: Field = .name) {
        self.viewModel = viewModel
        self.isBandNameFocused = focus
    }
    
    
    var body: some View {
        
        VStack {
            Form(content: {
                addBandNameView
                
                addInstrumentView

            })
            
            Button {
                viewModel.addBandPressed()
                
            } label: {
                Text("Adicionar")
                
            }
            
            Spacer()
            
            
        }
//        .toolbar {
//            Button {
//                viewModel.addBandPressed()
//            } label: {
//                Image(systemName: "plus")
//            }
//            
//        }
    }
    
    
    private var addBandNameView: some View {
        Section("ADICIONAR BANDA") {
            TextField("Nome da banda", text: $viewModel.bandName)
                .submitLabel(.return)
                .textInputAutocapitalization(.words)
                .onSubmit {
                    isBandNameFocused = AddBandView.Field.none
                }
                .focused($isBandNameFocused, equals: Field.name)
        }
    }
    
    private var addInstrumentView: some View {
        Section("Instrumento") {
            Picker("Vai tocar o que?", selection: $viewModel.instrument) {
                ForEach(Instrument.allCases, id: \.self) { instrument in
                    Text(instrument.rawValue)
                }
            }
            
            .pickerStyle(.menu)
        }
    }
}

//#Preview {
//    AddBandView()
//}
