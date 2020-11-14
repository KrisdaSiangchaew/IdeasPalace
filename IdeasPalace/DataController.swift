//
//  DataController.swift
//  IdeasPalace
//
//  Created by Kris Siangchaew on 13/11/2563 BE.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { (desription, error) in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    func createSampleData() throws {
        let viewContext = container.viewContext
        
        for i in 1...3 {
            let palace = Palace(context: viewContext)
            palace.id = UUID()
            palace.title = "Palace \(i)"
            palace.archived = Bool.random()
            palace.modifiedDate = Date()
            palace.ideas = []
            
            for j in 1...5 {
                let idea = Idea(context: viewContext)
                idea.title = "Item \(j)"
                idea.date = Date()
                idea.pinx = Int16.random(in: 0...3024)
                idea.piny = Int16.random(in: 0...4032)
                idea.palace = palace
            }
        }
        
        try viewContext.save()
    }
    
    static var previews: DataController = {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext
        
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        
        return dataController
    }()
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    func deleteAll() {
        let fetchReq1: NSFetchRequest<NSFetchRequestResult> = Idea.fetchRequest()
        let batchDeleteReq1 = NSBatchDeleteRequest(fetchRequest: fetchReq1)
        _ = try? container.viewContext.execute(batchDeleteReq1)
        
        let fetchReq2: NSFetchRequest<NSFetchRequestResult> = Palace.fetchRequest()
        let batchDeleteReq2 = NSBatchDeleteRequest(fetchRequest: fetchReq2)
        _ = try? container.viewContext.execute(batchDeleteReq2)
    }
}
