//
//  PersistenceController.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import CoreData
import Foundation

class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ThoughtGardenModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(
                fileURLWithPath: "/dev/null"
            )
        }
        container.loadPersistentStores { desc, error in
            if let err = error { fatalError("CoreData load error: \(err)") }
        }
        container.viewContext.mergePolicy =
            NSMergeByPropertyObjectTrumpMergePolicy
    }
}
