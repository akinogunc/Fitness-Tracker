//
//  ExerciseCell.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 5.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "ExerciseCell.h"

@implementation ExerciseCell

@synthesize exerciseLabel, setsLabel, repsLabel, restLabel, isCardio;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isCardio:(BOOL)isCardio{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        //Getting size of the device
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        
        if (isCardio) {//UI of cardio exercise
            
            //Label of the exercise name
            exerciseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenRect.size.width/2 - 10, 70)];
            exerciseLabel.textColor = [UIColor blackColor];
            exerciseLabel.backgroundColor = [UIColor clearColor];
            exerciseLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 16.0f];
            exerciseLabel.numberOfLines = 2;
            [self addSubview:exerciseLabel];

            //Label of the seconds of rest duration
            restLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2, 10, screenRect.size.width/2 - 10, 25)];
            restLabel.textColor = [UIColor blackColor];
            restLabel.backgroundColor = [UIColor clearColor];
            restLabel.font = [UIFont fontWithName: @"Metropolis-Bold" size: 20.0f];
            restLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:restLabel];
            
            UILabel * restStaticLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2, 35, screenRect.size.width/2 - 10, 25)];
            restStaticLabel.textColor = [UIColor blackColor];
            restStaticLabel.backgroundColor = [UIColor clearColor];
            restStaticLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 12.0f];
            restStaticLabel.text = @"minutes";
            restStaticLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:restStaticLabel];

        }else{//UI of the weights exercise
            
            //Label of the exercise name
            exerciseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenRect.size.width/2 - 10, 70)];
            exerciseLabel.textColor = [UIColor blackColor];
            exerciseLabel.backgroundColor = [UIColor clearColor];
            exerciseLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 16.0f];
            exerciseLabel.numberOfLines = 2;
            [self addSubview:exerciseLabel];
            
            //Label of the number of the sets
            setsLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 - 10, 10, screenRect.size.width/6, 25)];
            setsLabel.textColor = [UIColor blackColor];
            setsLabel.backgroundColor = [UIColor clearColor];
            setsLabel.font = [UIFont fontWithName: @"Metropolis-Bold" size: 20.0f];
            setsLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:setsLabel];
            
            UILabel * setsStaticLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 - 10, 35, screenRect.size.width/6, 25)];
            setsStaticLabel.textColor = [UIColor blackColor];
            setsStaticLabel.backgroundColor = [UIColor clearColor];
            setsStaticLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 12.0f];
            setsStaticLabel.text = @"sets";
            setsStaticLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:setsStaticLabel];
            
            //Splitting line view
            UIView * splitLine = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2 + screenRect.size.width/6 - 10, 10, 1, 50)];
            splitLine.backgroundColor = [UIColor blackColor];
            splitLine.alpha = 0.4;
            [self addSubview:splitLine];
            
            //Label of the number of the reps
            repsLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 + screenRect.size.width/6 - 10, 10, screenRect.size.width/6, 25)];
            repsLabel.textColor = [UIColor blackColor];
            repsLabel.backgroundColor = [UIColor clearColor];
            repsLabel.font = [UIFont fontWithName: @"Metropolis-Bold" size: 20.0f];
            repsLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:repsLabel];
            
            UILabel * repsStaticLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 + screenRect.size.width/6 - 10, 35, screenRect.size.width/6, 25)];
            repsStaticLabel.textColor = [UIColor blackColor];
            repsStaticLabel.backgroundColor = [UIColor clearColor];
            repsStaticLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 12.0f];
            repsStaticLabel.text = @"reps";
            repsStaticLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:repsStaticLabel];
            
            //Splitting line view
            UIView * splitLine2 = [[UIView alloc] initWithFrame:CGRectMake(screenRect.size.width/2 + 2*screenRect.size.width/6 - 10, 10, 1, 50)];
            splitLine2.backgroundColor = [UIColor blackColor];
            splitLine2.alpha = 0.4;
            [self addSubview:splitLine2];
            
            //Label of the seconds of rest duration
            restLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 + 2*screenRect.size.width/6 - 10, 10, screenRect.size.width/6, 25)];
            restLabel.textColor = [UIColor blackColor];
            restLabel.backgroundColor = [UIColor clearColor];
            restLabel.font = [UIFont fontWithName: @"Metropolis-Bold" size: 20.0f];
            restLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:restLabel];
            
            UILabel * restStaticLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 + 2*screenRect.size.width/6 - 10, 35, screenRect.size.width/6, 25)];
            restStaticLabel.textColor = [UIColor blackColor];
            restStaticLabel.backgroundColor = [UIColor clearColor];
            restStaticLabel.font = [UIFont fontWithName: @"Metropolis-Medium" size: 12.0f];
            restStaticLabel.text = @"rest";
            restStaticLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:restStaticLabel];

        }

    }
    return self;
}

@end
