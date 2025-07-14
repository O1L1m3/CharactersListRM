//  Created by Emilio

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "Model") 
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
//            if let url = storeDescription.url {
//                print("Core Data store URL: \(url.absoluteString)")
//            }
        }
    }
}
