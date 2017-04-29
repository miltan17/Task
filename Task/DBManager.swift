
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
    class func saveWorkForEvent(_ event: Event, _ title: String, _ details: String, _ date: String) -> Bool{
        var flag = false
        let context = getContext()
        let work = Work(context: context)
        work.title = title
        work.details = details
        work.date = date.dateValue! as NSDate?
        event.addToWorks(work)
        do{
            try context.save()
            flag = true
        }
        catch{
            print(error)
        }
        return flag
    }
    
    
    class func updateWorkForEvent(oldwork: Work, _ title: String, _ details: String, _ date: NSDate) -> Bool{
        var flag = false
        let context = getContext()
        oldwork.title = title
        oldwork.details = details
        oldwork.date = date
        do{
            try context.save()
            flag = true
        }catch{
            print(error)
        }
        return flag
    }
    
    class func removeWorkFromEvent(_ event: Event, _ work: Work) -> Bool{
        var flag = false
        let context = getContext()
        event.removeFromWorks(work)
        do{
            try context.delete(work)
            flag = true
        }catch{
            print(error)
        }
        return flag
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


//extension Date{
//    var stringValue: String{
//        return self.toString()
//    }
//    
//    func toString() -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let str = formatter.string(from: self as Date)
//        return str
//    }
//}
//
//extension String{
//    var dateValue: Date?{
//        return self.toDate()
//    }
//    
//    func toDate() -> Date? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        if let date = formatter.date(from: self) {
//            return date as Date?
//        }else{
//            // if format failed, Put some code here
//            return nil // an example
//        }
//    }
//}

