//
//  WorkoutCell.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 8.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "WorkoutCell.h"

@implementation WorkoutCell
@synthesize workoutLabel, startWorkoutButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //Getting size of the device
        CGRect screenRect = [[UIScreen mainScreen] bounds];

        //Label of the exercise name
        workoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenRect.size.width/2 - 10, 70)];
        workoutLabel.textColor = [UIColor blackColor];
        workoutLabel.backgroundColor = [UIColor clearColor];
        workoutLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 16.0f];
        workoutLabel.numberOfLines = 2;
        [self addSubview:workoutLabel];
        

        //This button will save the workout
        startWorkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [startWorkoutButton setTitle:@"Start" forState:UIControlStateNormal];
        [startWorkoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [startWorkoutButton.titleLabel setFont:[UIFont fontWithName:@"Metropolis-Medium" size:18.0]];
        startWorkoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [startWorkoutButton setBackgroundColor:[UIColor colorWithRed:0 green:179.0/255.0 blue:85.0/255.0 alpha:1]];
        startWorkoutButton.frame = CGRectMake(screenRect.size.width - 100, 10, 90, 50);
        [self addSubview:startWorkoutButton];

    }
    return self;
}

@end
