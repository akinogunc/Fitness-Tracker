//
//  StartWorkout.h
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 8.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartWorkout : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray * exercisesArray;
}

@property int workoutNo;
@property UITableView * exercisesTableView;

@end
