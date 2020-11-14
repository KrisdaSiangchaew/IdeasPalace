//
//  IdeasPalaceApp.swift
//  IdeasPalace
//
//  Created by Kris Siangchaew on 13/11/2563 BE.
//

import SwiftUI

@main
struct IdeasPalaceApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
