//
//  WorkoutViewController.h
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 3.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutCreator : UIViewController <UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate>

@property UITableView * exercisesTableView;

@end
