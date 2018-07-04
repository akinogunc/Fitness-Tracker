//
//  ViewController.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 3.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "ViewController.h"
#import "WorkoutViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Metropolis-Medium" size:20]}];
    self.navigationController.navigationBar.topItem.title = @"Fitness Tracker";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //Getting size of the device
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    //This button will open the start workout view controller
    UIButton * startWorkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startWorkoutButton setImage:[UIImage imageNamed:@"start_button"] forState:UIControlStateNormal];
    startWorkoutButton.frame = CGRectMake((screenRect.size.width - 170)/2, screenRect.size.height*0.3, 170, 170);
    [startWorkoutButton addTarget:self action:@selector(startWorkout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startWorkoutButton];

    
    //This button will open the create workout view controller
    UIButton * createWorkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [createWorkoutButton setTitle:@"Create Workout" forState:UIControlStateNormal];
    [createWorkoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createWorkoutButton.titleLabel setFont:[UIFont fontWithName:@"Metropolis-Medium" size:18.0]];
    createWorkoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createWorkoutButton setBackgroundColor:[UIColor colorWithRed:0 green:179.0/255.0 blue:85.0/255.0 alpha:1]];
    createWorkoutButton.frame = CGRectMake(0, screenRect.size.height*0.8, screenRect.size.width/2, screenRect.size.height*0.2);
    [createWorkoutButton addTarget:self action:@selector(createWorkout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createWorkoutButton];

    
    //This button will open the history view controller
    UIButton * historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [historyButton setTitle:@"History" forState:UIControlStateNormal];
    [historyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [historyButton.titleLabel setFont:[UIFont fontWithName:@"Metropolis-Medium" size:18.0]];
    historyButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [historyButton setBackgroundColor:[UIColor colorWithRed:229.0/255.0 green:93.0/255.0 blue:41.0/255.0 alpha:1]];
    historyButton.frame = CGRectMake(screenRect.size.width/2, screenRect.size.height*0.8, screenRect.size.width/2, screenRect.size.height*0.2);
    [historyButton addTarget:self action:@selector(showHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:historyButton];

}

-(void)createWorkout{
    WorkoutViewController *workoutViewController = [[WorkoutViewController alloc] init];
    [self.navigationController pushViewController:workoutViewController animated:YES];

}

-(void)startWorkout{
    
}

-(void)showHistory{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES];
}

@end
