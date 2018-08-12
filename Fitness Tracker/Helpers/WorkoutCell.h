//
//  WorkoutCell.h
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 8.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutCell : UITableViewCell

@property(strong, nonatomic) UILabel *workoutLabel;
@property(strong, nonatomic) UIButton * startWorkoutButton;
@property(strong, nonatomic) UILabel *workoutDuration;

@end
