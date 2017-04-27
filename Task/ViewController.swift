//
//  ViewController.swift
//  Task
//
//  Created by MbProRetina on 4/27/17.
//  Copyright © 2017 MbProRetina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        saveEvent("Second Event")
//        fetchAllEvents()
//        fetchEventWithName("First Event")
    }
    
    public func fetchEventWithName(_ name: String){
        if let event = DBManager.fetchEventWithName(name){
            print(event.name!)
        }else{
            print("Not Found")
        }
    }
    
    public func fetchAllEvents(){
        var events = DBManager.fetchAllEvents()
        for event in events{
            print(event.name!)
        }
    }

    public func saveEvent(_ name: String){
        if DBManager.saveEvent(name){
            print("Saved Correctly")
        }else{
            print("Not Saved")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

