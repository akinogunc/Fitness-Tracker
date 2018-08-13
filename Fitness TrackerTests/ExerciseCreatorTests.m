//
//  ExerciseCreatorTests.m
//  Fitness TrackerTests
//
//  Created by Maruf Nebil Ogunc on 13.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ExerciseCreator.h"

@interface ExerciseCreatorTests : XCTestCase{
    ExerciseCreator * exercise;
}

@end

@implementation ExerciseCreatorTests

- (void)setUp {
    [super setUp];
    
    exercise = [[ExerciseCreator alloc] init];
    [exercise viewDidLoad];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testSetsLabelInitialization{
    
    XCTAssert(exercise.setsLabel, @"Sets label is not initialized");
    XCTAssertNotNil(exercise.setsLabel, @"Sets label is not initialized");
}

-(void)testSetsIncreaseAndDecrease{
    
    [exercise decreaseSets];
    
    XCTAssertEqual(exercise.setCount, 0, @"set count is below 0");
    
    [exercise increaseSets];
    [exercise increaseSets];
    
    XCTAssertEqual(exercise.setCount, 2, @"set count is not 2");
    XCTAssertTrue([exercise.setsLabel.text isEqualToString:@"2 Sets"],@"sets label is not changed correctly");
    
}

@end
