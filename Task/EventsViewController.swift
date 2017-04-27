//
//
//

import UIKit

class EventsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        saveEvent("Second Event")
//        deleteEventsWithName("Second Event")
//        fetchAllEvents()
//        fetchEventWithName("First Event")
            updateEvent("Second Event", newName: "Third Event")
    }
    
    public func updateEvent(_ oldName: String, newName: String){
        if DBManager.updateEventWithName(oldName, newName: newName){
            print("Updated to \(newName)")
        }else{
            print("Cannot Update")
        }

    }
    
    public func deleteEventsWithName(_ name: String){
        if DBManager.deleteEventWithName(name){
            print("Successfully Deleted.")
        }else{
            print("Error Deleting Event")
        }
    }
    
    public func fetchEventWithName(_ name: String){
        if let event = DBManager.fetchEventWithName(name){
            print(event.name!)
        }else{
            print("Not Found")
        }
    }
    
    public func fetchAllEvents(){
        if let events = DBManager.fetchAllEvents(){
            for event in events{
                print(event.name!)
            }
        }
    }
    
    public func saveEvent(_ name: String){
        if DBManager.saveEvent(name){
            print("Saved Correctly")
        }else{
            print("Not Saved")
        }
    }

}
