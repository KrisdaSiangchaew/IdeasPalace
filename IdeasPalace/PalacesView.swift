//
//  PalacesView.swift
//  IdeasPalace
//
//  Created by Kris Siangchaew on 13/11/2563 BE.
//

import SwiftUI

struct PalacesView: View {
    let showArchived: Bool
    let palaces: FetchRequest<Palace>
    
    init(showArchived: Bool) {
        self.showArchived = showArchived
        
        palaces = FetchRequest<Palace>(
            entity: Palace.entity(),
            sortDescriptors: [
            NSSortDescriptor(keyPath: \Palace.modifiedDate, ascending: false)
            ],
            predicate: NSPredicate(format: "archived = %d", showArchived)
        )
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(palaces.wrappedValue) { palace in
                    Section(header: Text(palace.title ?? "")) {
                        ForEach(palace.ideas?.allObjects as? [Idea] ?? []) { idea in
                            Text(idea.title ?? "")
                        }
                    }
                }
            }
            .listStyle(InsetListStyle())
            .navigationTitle(showArchived ? "Archived" : "Current")
        }
    }
}

struct PalacesView_Previews: PreviewProvider {
    static var dataController = DataController.previews
    
    static var previews: some View {
        PalacesView(showArchived: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
