//
//  WorkoutSaverTests.swift
//  Fitness TrackerTests
//
//  Created by Maruf Nebil Ogunc on 2.10.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import XCTest

class WorkoutSaverTests: XCTestCase {

    var workoutSaver = WorkoutSaver()

    override func setUp() {
        workoutSaver.viewDidLoad()

    }

    func testCreateMuscleGroupsArray() {
        
        workoutSaver.chestRadioButton.isSelected = true
        workoutSaver.backRadioButton.isSelected = true

        let result = workoutSaver.createMuscleGroupsArray()

        XCTAssertTrue(result.count == 2)
        XCTAssertTrue(result.contains("chest"))
    }


}

