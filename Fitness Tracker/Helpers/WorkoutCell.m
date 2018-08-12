//
//  WorkoutCell.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 8.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "WorkoutCell.h"

@implementation WorkoutCell
@synthesize workoutLabel, startWorkoutButton, workoutDuration;

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
        
        //Label of the minutes of workout duration
        workoutDuration = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2, 10, screenRect.size.width/4, 25)];
        workoutDuration.textColor = [UIColor blackColor];
        workoutDuration.backgroundColor = [UIColor clearColor];
        workoutDuration.font = [UIFont fontWithName: @"Metropolis-Bold" size: 20.0f];
        workoutDuration.textAlignment = NSTextAlignmentCenter;
        [self addSubview:workoutDuration];
        
        UILabel * restStaticLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2, 35, screenRect.size.width/4, 25)];
        restStaticLabel.textColor = [UIColor blackColor];
        restStaticLabel.backgroundColor = [UIColor clearColor];
        restStaticLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 12.0f];
        restStaticLabel.text = @"minutes";
        restStaticLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:restStaticLabel];

        //This button will save the workout
        startWorkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [startWorkoutButton setTitle:@"Start" forState:UIControlStateNormal];
        [startWorkoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [startWorkoutButton.titleLabel setFont:[UIFont fontWithName:@"Metropolis-Medium" size:18.0]];
        startWorkoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [startWorkoutButton setBackgroundColor:[UIColor colorWithRed:0 green:179.0/255.0 blue:85.0/255.0 alpha:1]];
        startWorkoutButton.frame = CGRectMake(3*screenRect.size.width/4, 10, screenRect.size.width/4 - 10, 50);
        [self addSubview:startWorkoutButton];

    }
    return self;
}

@end
