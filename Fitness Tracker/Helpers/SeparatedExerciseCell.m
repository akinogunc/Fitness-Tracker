//
//  SeparatedExerciseCell.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 12.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "SeparatedExerciseCell.h"

@implementation SeparatedExerciseCell
@synthesize countdownLabel,exerciseNameLabel,statusImageView;

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
        
        //status imageview
        statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4*screenRect.size.width/5, 0, screenRect.size.width/4 - 10, 70)];
        statusImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:statusImageView];
        
    }
    return self;
}

@end
