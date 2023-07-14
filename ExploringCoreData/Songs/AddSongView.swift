//
//  AddSongView.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 29/06/23.
//

import SwiftUI

struct AddSongView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var bandName: String
    
    @State var textFieldLabel: String = "Nome da música"
    
    @State var songName: String = ""
    @State var songKey: SongKey = .original
    
    var songHandler: ((String, SongKey)) -> Void
    
    
    func submitPressed() {
        if songName.isEmpty {
            self.textFieldLabel = "Toda música precisa de um nome!"
        } else {
            dismiss()
            songHandler((songName, songKey))
        }
    }
    
    var body: some View {
        VStack {
            Text(bandName)
                .font(.title)
                .padding()
            
            Form {
                Section("Adicionar Música") {
                    TextField(textFieldLabel, text: $songName)
                        .submitLabel(.done)
                        .textInputAutocapitalization(.sentences)
                        .onSubmit {
                            submitPressed()
                        }
                
                  
                }
                Picker("Tom da Música", selection: $songKey) {
                    ForEach(SongKey.allCases, id: \.self) { key in
                        Text(key.rawValue)
                    }
                }.pickerStyle(.menu)
            }
            
            Button {
                submitPressed()
                
            } label: {
                Text("Adicionar")
                
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        
        }

    }
}

struct AddSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddSongView(bandName: "AAAa") { nome, tom in
            print("nome da banda: \(nome)")
            print("Tom: \(tom)")
        }
    }
}
