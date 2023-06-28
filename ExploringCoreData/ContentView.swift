//
//  ContentView.swift
//  ExploringCoreData
//
//  Created by Lucas Migge de Barros on 24/06/23.
//

import SwiftUI


struct ContentView: View {
    
    @State var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            SetListView()
                .tabItem {
                    Label("Set List", systemImage: "list.clipboard")
                }
                .tag(0)
            
            BandsView()
                .tabItem({
                    Label("Bandas", systemImage: "music.mic.circle.fill")
                })
                .tag(1)
            
        }
        

    }

    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
