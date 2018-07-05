//
//  ExerciseCell.h
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 5.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseCell : UITableViewCell

@property(strong, nonatomic) UILabel *exerciseLabel;
@property(strong, nonatomic) UILabel *setsLabel;
@property(strong, nonatomic) UILabel *repsLabel;
@property(strong, nonatomic) UILabel *restLabel;

@end
