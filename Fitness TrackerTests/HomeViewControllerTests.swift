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
    
    
}
