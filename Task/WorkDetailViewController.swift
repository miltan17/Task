//
//  WorkDetailViewController.swift
//  Task
//
//  Created by MbProRetina on 4/30/17.
//  Copyright © 2017 MbProRetina. All rights reserved.
//

import UIKit

class WorkDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailTextField: UITextView!
    
    var work: Work? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        // Do any additional setup after loading the view.
    }
    
    func initData(){
        titleLabel.text = work?.title
        detailTextField.text = work?.details
        setDate()
    }
    
    func setDate(){
        let nextDate = work?.date
        let now = Date()
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.month, .day, .hour, .minute, .second]
        formatter.maximumUnitCount = 2
        
        let stringDate = formatter.string(from: now , to: nextDate as! Date)
        dateLabel.text = stringDate
    }

}
