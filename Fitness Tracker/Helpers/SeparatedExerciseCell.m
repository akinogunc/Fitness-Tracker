//
//  SeparatedExerciseCell.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 12.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "SeparatedExerciseCell.h"

@implementation SeparatedExerciseCell
@synthesize countdownLabel,exerciseNameLabel,repsLabel,repsStaticLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //Getting size of the device
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        //Label of the exercise duration
        countdownLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenRect.size.width/5 - 10, 70)];
        countdownLabel.textColor = [UIColor blackColor];
        countdownLabel.backgroundColor = [UIColor clearColor];
        countdownLabel.font = [UIFont fontWithName: @"Metropolis-Bold" size: 16.0f];
        countdownLabel.numberOfLines = 1;
        [self addSubview:countdownLabel];
        
        //Label of the exercise name
        exerciseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/5, 0, 3*screenRect.size.width/5, 70)];
        exerciseNameLabel.textColor = [UIColor blackColor];
        exerciseNameLabel.backgroundColor = [UIColor clearColor];
        exerciseNameLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 20.0f];
        exerciseNameLabel.textAlignment = NSTextAlignmentLeft;
        exerciseNameLabel.numberOfLines = 2;
        [self addSubview:exerciseNameLabel];
        
        //Label of reps
        repsLabel = [[UILabel alloc] initWithFrame:CGRectMake(4*screenRect.size.width/5, 10, screenRect.size.width/5, 25)];
        repsLabel.textColor = [UIColor blackColor];
        repsLabel.backgroundColor = [UIColor clearColor];
        repsLabel.font = [UIFont fontWithName: @"Metropolis-Bold" size: 20.0f];
        repsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:repsLabel];
        
        repsStaticLabel = [[UILabel alloc] initWithFrame:CGRectMake(4*screenRect.size.width/5, 35, screenRect.size.width/5, 25)];
        repsStaticLabel.textColor = [UIColor blackColor];
        repsStaticLabel.backgroundColor = [UIColor clearColor];
        repsStaticLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 12.0f];
        repsStaticLabel.text = @"reps";
        repsStaticLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:repsStaticLabel];

    }
    return self;
}

@end
