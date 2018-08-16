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
        XCTAssertTrue((UIApplication.shared.keyWindow?.rootViewController?.isKind(of: WorkoutCreator))!)
        // [homeViewController createWorkout];
        
        /*   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
         XCTAssertTrue([UIApplication.sharedApplication.keyWindow.rootViewController isKindOfClass:[WorkoutCreator class]], @"Did not navigate to Workout Creator");
         });*/

    }
    
    
}
