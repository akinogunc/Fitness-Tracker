//
//  ExerciseCreatorTests.swift
//  Fitness TrackerTests
//
//  Created by Maruf Nebil Ogunc on 17.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import XCTest

class ExerciseCreatorTests: XCTestCase {
    
    var exercise = ExerciseCreator()
    
    override func setUp() {
        super.setUp()

        exercise.viewDidLoad()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSetsLabelInitialization(){
        XCTAssertNotNil(exercise.setsLabel)
        XCTAssertNotNil(exercise.repsLabel)
        XCTAssertNotNil(exercise.restLabel)
        XCTAssertNotNil(exercise.cardioTimeLabel)
    }

    func testSetsIncreaseAndDecrease() {
        
        exercise.decreaseSets()
        
        XCTAssertEqual(exercise.setCount, 0)
        
        exercise.increaseSets()
        exercise.increaseSets()

        XCTAssertEqual(exercise.setCount, 2)
        XCTAssertTrue(exercise.setsLabel.text == "2 Sets")

    }
    
    
}
