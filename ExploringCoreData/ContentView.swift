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
        BandsView()

    }

    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
