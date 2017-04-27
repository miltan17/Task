//
//
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var events = [String]()
    
    @IBOutlet weak var eventTableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
//        deleteEventsWithName("Second Event")
        fetchAllEvents()
//        fetchEventWithName("First Event")
//        updateEvent("Second Event", newName: "Third Event")
    }

    @IBAction func addEvent(_ sender: Any) {
        let alert = UIAlertController(title: "Add Event",
                                      message: "Unique name for your event",
                                      preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Type Event Name"
            textField.clearButtonMode = .whileEditing
        }
        let submitAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0]
            self.saveEvent(textField.text!)
            self.events.append(textField.text!)
            self.eventTableView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertToUpdateEvent(_ index: Int){
        let alert = UIAlertController(title: "Update Event",
                                      message: "Update name for your event",
                                      preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.text = self.events[index]
            textField.placeholder = "Type Event Name"
            textField.clearButtonMode = .whileEditing
        }
        let submitAction = UIAlertAction(title: "Update", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0]
            self.updateEvent(self.events[index], newName: textField.text!)
            self.events[index] = textField.text!
            self.eventTableView.reloadData()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK:- TABLEVIEW DELEGATE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        cell.textLabel?.text = events[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteEventsWithName(events[indexPath.row])
            events.remove(at: indexPath.row)
            eventTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        showAlertToUpdateEvent(indexPath.row)
    }
    
    // MARK:- EVENT DATA OPERATIONS
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
        if let fetchedEvents = DBManager.fetchAllEvents(){
            for event in fetchedEvents{
                events.append(event.name!)
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
