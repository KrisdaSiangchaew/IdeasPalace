//
//  HomeView.swift
//  IdeasPalace
//
//  Created by Kris Siangchaew on 13/11/2563 BE.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        NavigationView {
            VStack {
                Button {
                    dataController.deleteAll()
                    try? dataController.createSampleData()
                } label: {
                    Text("Add Data")
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
