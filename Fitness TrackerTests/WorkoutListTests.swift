//
//  WorkoutListTests.swift
//  Fitness TrackerTests
//
//  Created by AKIN on 16.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import XCTest

class WorkoutListTests: XCTestCase {
    
    var workoutsList = WorkoutsList();

    override func setUp() {
        super.setUp()
        
        //Creating a test exercise
        let exerciseDictionary: NSDictionary = ["name" : "test exercise", "cardio_minutes" :"12", "isCardio" : true]
        let exercisesArray: NSMutableArray = NSMutableArray.init()
        exercisesArray.add(exerciseDictionary)
        
        //Turning the test exercise to a string
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: exercisesArray, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString: String = String.init(data: jsonData, encoding: String.Encoding.utf8)!
        
        //Saving the string as a json file
        let filePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var fileAtPath = filePath.strings(byAppendingPaths: ["test1.json"])

        
        FileManager.default.createFile(atPath: fileAtPath[0], contents: nil, attributes: nil)
        try! jsonString.data(using: String.Encoding.utf8)?.write(to: URL(fileURLWithPath: fileAtPath[0]), options: Data.WritingOptions.atomic)
        
        
        let testWorkoutsArray = NSMutableArray.init(object: "test1.json")
        workoutsList.workoutsArray = testWorkoutsArray;
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReadWorkoutJSONbyName() -> () {
        XCTAssertNil(workoutsList.readWorkoutJSONbyName(name: "asd"))
        
        let jsonFile = workoutsList.readWorkoutJSONbyName(name: "test1.json")
        XCTAssertNotNil(jsonFile)
        
        let dict = jsonFile?.object(at: 0) as! NSDictionary
        let val = dict["cardio_minutes"] as! String
        XCTAssertTrue(val == "12")
    }
    
    func testCalculateWorkoutDuration() -> (){
        
        XCTAssertNotNil(workoutsList.calculateWorkoutDuration(index: 0));
        XCTAssertTrue(workoutsList.calculateWorkoutDuration(index: 0) == "12.0");

    }
}
