//
//  SeparatedExerciseCell.h
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 12.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeparatedExerciseCell : UITableViewCell

@property(strong, nonatomic) UILabel * countdownLabel;
@property(strong, nonatomic) UILabel * exerciseNameLabel;
@property(strong, nonatomic) UILabel * repsLabel;
@property(strong, nonatomic) UILabel * repsStaticLabel;

@end
