//
//  HomeViewControllerTests.swift
//  Fitness TrackerTests
//
//  Created by AKIN on 16.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import XCTest

class HomeViewControllerTests: XCTestCase {
    
    let homeViewController = HomeViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateWorkoutNavigation() {
        
        homeViewController.createWorkout()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {() -> Void in
            XCTAssertTrue(UIApplication.shared.keyWindow?.rootViewController is WorkoutCreator)
        })
        
    }
    
    func addFakeWorkout() -> Void {
        
        let calendar = Calendar(identifier: .gregorian)
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        let date = calendar.date(byAdding: .day, value: 4, to: sunday!)
        
        var completedWorkoutsArray = NSMutableArray()
        
        //getting completed workouts array from user defaults
        if let savedWorkoutsObject = UserDefaults.standard.object(forKey: "completedWorkouts") as? NSArray{
            completedWorkoutsArray = savedWorkoutsObject.mutableCopy() as! NSMutableArray
        }
        
        let completedWorkoutDict = NSMutableDictionary()
        completedWorkoutDict["name"] = "sadasd"
        completedWorkoutDict["muscle_groups"] = ["biceps" , "back"]
        completedWorkoutDict["date"] = date
        
        //Adding the completed workout to array
        completedWorkoutsArray.add(completedWorkoutDict)
        
        UserDefaults.standard.set(completedWorkoutsArray, forKey: "completedWorkouts")
        UserDefaults.standard.synchronize()
        
    }
    
    func removeFakeWorkout() -> Void {
        
        var completedWorkoutsArray = NSMutableArray()
        
        //getting completed workouts array from user defaults
        if let savedWorkoutsObject = UserDefaults.standard.object(forKey: "completedWorkouts") as? NSArray{
            completedWorkoutsArray = savedWorkoutsObject.mutableCopy() as! NSMutableArray
        }
        
        for i in 0..<completedWorkoutsArray.count{
            let completedWorkoutDict = completedWorkoutsArray.object(at: i) as! NSDictionary
            let arr = completedWorkoutDict["muscle_groups"] as! NSArray
            
            if(arr[0] as! String == "biceps,back"){
                completedWorkoutsArray.removeObject(at: i)
                break
            }
        }
        
        UserDefaults.standard.set(completedWorkoutsArray, forKey: "completedWorkouts")
        UserDefaults.standard.synchronize()
    }

}
