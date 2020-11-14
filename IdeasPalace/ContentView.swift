//
//  ContentView.swift
//  IdeasPalace
//
//  Created by Kris Siangchaew on 13/11/2563 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(
                        title: { Text("Home") },
                        icon: { Image(systemName: "house") }
                    )
                }
                    
            PalacesView(showArchived: false)
                .tabItem {
                    Label(
                        title: { Text("Current") },
                        icon: { Image(systemName: "list.bullet") }
                    )
                }
                    
            PalacesView(showArchived: true)
                .tabItem {
                    Label(
                        title: { Text("Archived") },
                        icon: { Image(systemName: "archivebox") }
                    )
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController.previews
    
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
