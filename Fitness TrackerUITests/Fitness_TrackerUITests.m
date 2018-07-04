//
//  Fitness_TrackerUITests.m
//  Fitness TrackerUITests
//
//  Created by Maruf Nebil Ogunc on 3.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Fitness_TrackerUITests : XCTestCase

@end

@implementation Fitness_TrackerUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testWeightSegment{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Create Workout"] tap];
    [app.navigationBars[@"Create Workout"].buttons[@"Add"] tap];
    [[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"up"] elementBoundByIndex:0] tap];
    [[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"up"] elementBoundByIndex:0] tap];

    XCUIElement * setsLabelElement = app.staticTexts[@"SetsLabel"];
    XCTAssertTrue([setsLabelElement.label isEqualToString:@"2 Sets"], @"Sets label is not changed correctly");
    
    
    XCUIElement *element = [[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *upButton = [[[element childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"up"] elementBoundByIndex:1];
    [upButton tap];
    
    XCUIElement *downButton = [[[element childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"down"] elementBoundByIndex:1];
    [downButton tap];
    [upButton tap];
    [upButton tap];
    [downButton tap];
    
    XCUIElement * repsLabelElement = app.staticTexts[@"RepsLabel"];
    XCTAssertTrue([repsLabelElement.label isEqualToString:@"1 Reps"], @"Reps label is not changed correctly");
    

}

- (void)testCardioSegment{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Create Workout"] tap];
    [app.navigationBars[@"Create Workout"].buttons[@"Add"] tap];
    [app/*@START_MENU_TOKEN@*/.buttons[@"Cardio"]/*[[".segmentedControls.buttons[@\"Cardio\"]",".buttons[@\"Cardio\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    
    XCUIElement *upButton = app.buttons[@"up"];
    [upButton tap];
    [upButton tap];
    [upButton tap];
    [app.buttons[@"down"] tap];

    XCUIElement * repsLabelElement = app.staticTexts[@"CardioLabel"];
    XCTAssertTrue([repsLabelElement.label isEqualToString:@"3 Minutes"], @"Cardio Time label is not changed correctly");

}

@end
