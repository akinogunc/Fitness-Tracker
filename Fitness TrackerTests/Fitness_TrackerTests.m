//
//  Fitness_TrackerTests.m
//  Fitness TrackerTests
//
//  Created by Maruf Nebil Ogunc on 3.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WorkoutViewController.h"
#import "ViewController.h"

@interface Fitness_TrackerTests : XCTestCase
@property(strong,nonatomic) ViewController * vcToTest;
@end

@implementation Fitness_TrackerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testWorkoutNavigation {
    [self.vcToTest createWorkout];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        XCTAssertTrue([UIApplication.sharedApplication.keyWindow.rootViewController isKindOfClass:[WorkoutViewController class]], @"Did not navigate to WorkoutViewController");
    });
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
