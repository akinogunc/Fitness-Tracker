//
//  WorkoutItemViewController.h
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 4.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseCreator : UIViewController <UITextFieldDelegate>

@property(strong, nonatomic) UILabel *setsLabel;
@property UIButton * setsDownButton;
@property UIButton * setsUpButton;
@property int setCount;
@property UILabel *repsLabel;
@property UIButton * repsDownButton;
@property UIButton * repsUpButton;
@property int repsCount;
@property UILabel *restLabel;
@property UIButton * restDownButton;
@property UIButton * restUpButton;
@property int restSeconds;
@property UILabel *cardioTimeLabel;
@property UIButton * cardioDownButton;
@property UIButton * cardioUpButton;
@property int cardioMinutes;

-(void)decreaseSets;
-(void)increaseSets;

@end
