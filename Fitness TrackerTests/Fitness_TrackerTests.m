//
//  Fitness_TrackerTests.m
//  Fitness TrackerTests
//
//  Created by Maruf Nebil Ogunc on 3.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HomeViewController.h"
#import "WorkoutCreator.h"
#import "ExerciseCreator.h"

@interface Fitness_TrackerTests : XCTestCase{
    HomeViewController * homeViewController;
    ExerciseCreator * exercise;
}

@end

@implementation Fitness_TrackerTests

- (void)setUp {
    [super setUp];

    homeViewController = [[HomeViewController alloc] init];
    exercise = [[ExerciseCreator alloc] init];
    [exercise viewDidLoad];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testWorkoutNavigation {
    
    [homeViewController createWorkout];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        XCTAssertTrue([UIApplication.sharedApplication.keyWindow.rootViewController isKindOfClass:[WorkoutCreator class]], @"Did not navigate to Workout Creator");
    });
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
