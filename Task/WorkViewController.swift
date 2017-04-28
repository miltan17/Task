//
//  WorkViewController.swift
//  Task
//
//  Created by MbProRetina on 4/27/17.
//  Copyright © 2017 MbProRetina. All rights reserved.
//

import UIKit

class WorkViewController: UIViewController {

    var event: Event? = nil
    var works = [Work]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DBManager.saveWorkForEvent(event!)
        getWorks()
        for work in works{
            print(work.title!)
            print(work.date!)
        }
    }
    
    func getWorks(){
        if ((event?.works) != nil){
            for work in (event?.works)!{
                works.append(work as! Work)
//                print((work as! Work).title)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
