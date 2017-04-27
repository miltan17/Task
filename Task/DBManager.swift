
import Foundation
import CoreData

class DBManager{
    
    private init(){
        
    }
    
    class func getContext() -> NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    //MARK: - EVENT OPERATIONS
    
    class func saveEvent(_ eventName: String) -> Bool{
        var flag = false
        
        if fetchEventWithName(eventName) != nil{
            print("Event Exists")
            return flag
        }
        let managedContext = self.getContext()
        let event = Event(context: managedContext)
        event.name = eventName
        do{
            try managedContext.save()
            flag = true
        }catch{
            print("error\(error)")
        }
        return flag
    }
    
    class func fetchAllEvents() -> [Event]?{
        let managedContext = self.getContext()
        var events:[Event]? = nil
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        do{
            events = try managedContext.fetch(request)
        }catch{
            print("Error \(error)")
        }
        
        return events
    }
    
    class func fetchEventWithName(_ name: String) -> Event?{
        let context = self.getContext()
        var event: Event? = nil
        var events: [Event]? = nil
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do{
            events = try context.fetch(request)
            event = events?.first
        }catch{
            print("Error \(error)")
        }
        return event
    }
    
    class func deleteEventWithName(_ name: String) -> Bool{
        var flag = false
        if let event = fetchEventWithName(name){
            let context = self.getContext()
            do{
                try context.delete(event)
                flag = true
            }catch{
                print("Error: \(error)")
            }
        }else{
            print("Event Not Found")
        }
        return flag
    }
    
    class func updateEventWithName(_ oldName: String, newName: String) -> Bool{
        var flag = false
        if let event = fetchEventWithName(oldName){
            let context = getContext()
            event.name = newName
            do{
                try context.save()
                flag = true
            }catch{
                print("Error \(error)")
            }
        }else{
            print("Event Not Found")
        }
        return flag
    }
    
    //MARK: - WORK OPERATIONS
    class func saveWork(){
        
    }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Task")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
