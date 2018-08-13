//
//  HomeViewControllerTests.m
//  Fitness TrackerTests
//
//  Created by Maruf Nebil Ogunc on 13.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HomeViewController.h"
#import "WorkoutCreator.h"

@interface HomeViewControllerTests : XCTestCase{
    HomeViewController * homeViewController;

}

@end

@implementation HomeViewControllerTests

- (void)setUp {
    [super setUp];

    homeViewController = [[HomeViewController alloc] init];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreateWorkoutNavigation{
    
    [homeViewController createWorkout];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        XCTAssertTrue([UIApplication.sharedApplication.keyWindow.rootViewController isKindOfClass:[WorkoutCreator class]], @"Did not navigate to Workout Creator");
    });
}

@end
