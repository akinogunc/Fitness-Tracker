//
//  WorkoutsListTests.m
//  Fitness TrackerTests
//
//  Created by Maruf Nebil Ogunc on 13.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WorkoutsList.h"

@interface WorkoutsListTests : XCTestCase{
    WorkoutsList * workoutsList;
}

@end

@implementation WorkoutsListTests

- (void)setUp {
    [super setUp];
    workoutsList = [[WorkoutsList alloc] init];
    
    //Creating a test exercise
    NSDictionary * exerciseDictionary = [[NSDictionary alloc] init];
    exerciseDictionary = @{ @"name" : @"test exercise", @"cardio_minutes" :@"12", @"isCardio" : @YES};
    NSMutableArray * exercisesArray = [[NSMutableArray alloc] init];
    [exercisesArray addObject:exerciseDictionary];
    
    //Turning the test exercise to a string
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:exercisesArray options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //Saving the string as a json file
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"test1.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    [[jsonString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:YES];
    
    NSMutableArray * testWorkoutsArray = [[NSMutableArray alloc] initWithObjects:@"test1.json", nil];
    workoutsList.workoutsArray = testWorkoutsArray;

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testReadWorkoutJSONbyName{
    
    XCTAssertNotNil([workoutsList readWorkoutJSONbyName:@"test1.json"]);
    XCTAssertTrue([[[[workoutsList readWorkoutJSONbyName:@"test1.json"] objectAtIndex:0] objectForKey:@"cardio_minutes"] isEqualToString:@"12"]);
    XCTAssertNil([workoutsList readWorkoutJSONbyName:@"test"]);
    XCTAssertNil([workoutsList readWorkoutJSONbyName:@"test2.json"]);

}

-(void)testCalculateWorkoutDuration{
    
    XCTAssertNotNil([workoutsList calculateWorkoutDuration:0]);
    XCTAssertTrue([[workoutsList calculateWorkoutDuration:0] isEqualToString:@"12.0"]);

}

@end
