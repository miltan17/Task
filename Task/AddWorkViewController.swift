//
//

import UIKit

class AddWorkViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var add = false
    
    var event: Event? = nil
    var work: Work? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        if !add {
            initWorkToTheFields()
        }
    }
    
    
    func initWorkToTheFields(){
        titleTextField.text = work?.title
        detailsTextField.text = work?.details
        datePicker.date = work?.date! as! Date
    }
    

    @IBAction func doneButtonAction(_ sender: Any) {
        if add{
            addWork()
        }else{
            updateWork()
        }
        (previousViewController as! WorkViewController).eventName = event?.name!
        navigationController?.popToViewController(previousViewController!, animated: true)
    }
    
    func addWork(){
        let title = titleTextField.text!
        let details = detailsTextField.text!
        let date = datePicker.date
//        let date = det.addingTimeInterval(6.0 * 60.0 * 60.0)
//
        if DBManager.saveWorkForEvent(event!, title, details, date.stringValue){
            print("Added")
        }
        else{
            print("Failed")
        }
    }
    
    func updateWork(){
        let title = titleTextField.text
        let details = detailsTextField.text
        
        let date = datePicker.date
        let dateInString = date.stringValue
        
        let finalDate = dateInString.dateValue
        
        if DBManager.updateWorkForEvent(oldwork: work!, title!, details!, finalDate!) {
            print("Updated")
        }else{
            print("Failed to Update")
        }
    }
}

extension Date{
    var stringValue: String{
        return self.toString()
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let str = formatter.string(from: self as Date)
        return str
    }
}

extension String{
    var dateValue: NSDate?{
        return self.toDate()
    }
    
    func toDate() -> NSDate? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: self) {
            return date as NSDate?
        }else{
            // if format failed, Put some code here
            return nil // an example
        }
    }
}

extension UIViewController{
    var previousViewController:UIViewController?{
        if let controllersOnNavStack = self.navigationController?.viewControllers, controllersOnNavStack.count >= 2 {
            let n = controllersOnNavStack.count
            return controllersOnNavStack[n - 2]
        }
        return nil
    }
}
