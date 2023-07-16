//
//  AddSongView.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 29/06/23.
//

import SwiftUI

struct SongInfo {
    let name: String
    let artist: String
    let key: SongKey
    let dropTune: Bool
    
}

struct AddSongView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var bandName: String
    
    @State var nameTextLabel: String = "Nome da música"
    @State var artistTextLabel: String = "Nome da banda original / artista"
    
    @State var songName: String = ""
    @State var artistName: String = ""
    @State var songKey: SongKey = .original
    @State var dropTune: Bool = false
    
    var songHandler: (SongInfo) -> Void
    
    private func validateSongName() {
        if songName.isEmpty {
            self.nameTextLabel = "Toda música precisa de um nome!"
        }
    }
    
    private func validateArtistName() {
        if artistName.isEmpty {
            artistTextLabel = "Bote o nome da banda rapa!"
        }
    }
    
    private func createSongInfo() -> SongInfo {
        return SongInfo(name: songName,
                        artist: artistName,
                        key: songKey,
                        dropTune: dropTune)
    }
    
    
    func submitPressed() {
        if songName.isEmpty {
            self.nameTextLabel = "Toda música precisa de um nome!"
        } else {
            dismiss()
            songHandler((createSongInfo()))
        }
    }
    
    var body: some View {
        VStack {
            Text(bandName)
                .font(.title)
                .padding()
            
            Form {
                Section("Adicionar Música") {
                    TextField(nameTextLabel, text: $songName)
                        .submitLabel(.next)
                        .textInputAutocapitalization(.sentences)
                        .onSubmit {
                            validateSongName()
                        }
                }
                
                Section("Artista") {
                    TextField(artistTextLabel, text: $artistName)
                        .submitLabel(.next)
                        .textInputAutocapitalization(.sentences)
                        .onSubmit {
                            validateArtistName()
                        }
                    
                }
                
                Section("Detales") {
                    Picker("Tom da Música", selection: $songKey) {
                        ForEach(SongKey.allCases, id: \.self) { key in
                            Text(key.rawValue)
                        }
                    }.pickerStyle(.menu)
                    
                    Toggle("Afinação Droppad", isOn: $dropTune)
                        .toggleStyle(.switch)
                    
                }
                
            }
            
            
            Button {
                submitPressed()
                
            } label: {
                Text("Adicionar")
                    .font(.headline)
                    .padding(.horizontal)
                
            }
            .buttonStyle(.borderedProminent)
            
        }
        .padding(.vertical)
        
        Spacer()
        
    }
    
}


struct AddSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddSongView(bandName: "Amantes") { songInfo in
            print(songInfo)
        }
    }
}
