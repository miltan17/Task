

import UIKit

class WorkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var workTable: UITableView!

    var event: Event? = nil
    var works = [Work]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DBManager.saveWorkForEvent(event!)
        getWorks()
    }
    
    func getWorks(){
        if ((event?.works) != nil){
            for work in (event?.works)!{
                works.append(work as! Work)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return works.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = workTable.dequeueReusableCell(withIdentifier: "workCell", for: indexPath)
        
        cell.textLabel?.text = works[indexPath.row].title!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: works[indexPath.row].date! as Date)
        
        cell.detailTextLabel?.text =  date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "addWorkViewController") as! AddWorkViewController
        destinationVC.work = works[indexPath.row]
        destinationVC.event = event!
        destinationVC.title = "Update " + works[indexPath.row].title!
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if DBManager.removeWorkFromEvent(event!, works[indexPath.row]){
                works.remove(at: indexPath.row)
                workTable.reloadData()
                print("Deleted")
            }else{
                print("Problem in deleting")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addWork"{
            var index = workTable.indexPathForSelectedRow?.row
            
            let destinationVC: AddWorkViewController = segue.destination as! AddWorkViewController
//            destinationVC.event = self.fetchEventWithName(events[index!])
            destinationVC.add = true
            destinationVC.event = event!
            destinationVC.title = "Add Work"
        }
    }
}


