//
//  DBManagerTests.swift
//  Task
//
//  Created by MbProRetina on 4/27/17.
//  Copyright © 2017 MbProRetina. All rights reserved.
//

import XCTest
//import CoreData
@testable import Task

class DBManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSaveEvent(){
        XCTAssertTrue(DBManager.saveEvent("Event 1"))
    }
    
    func testDeleteEvent(){
        DBManager.saveEvent("Event 1")
        XCTAssertTrue(DBManager.deleteEventWithName("Event 1"))
    }
    
    func testUpdateEvent(){
        DBManager.saveEvent("Event 1")
        XCTAssertTrue(DBManager.updateEventWithName("Event 1", newName: "Event 2"))
    }
    
    func testSaveWorkForEvent(){
        DBManager.saveEvent("Event")
        let event: Event = DBManager.fetchEventWithName("Event")!
        XCTAssertTrue(DBManager.saveWorkForEvent(event))
    }
}
