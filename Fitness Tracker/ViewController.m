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
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    //This button will open the create workout view controller
    UIButton * createWorkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [createWorkoutButton setTitle:@"Create Workout" forState:UIControlStateNormal];
    [createWorkoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    createWorkoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createWorkoutButton setBackgroundColor:[UIColor greenColor]];
    createWorkoutButton.frame = CGRectMake((screenRect.size.width - 200)/2, screenRect.size.height*0.2, 200, 100);
    [createWorkoutButton addTarget:self action:@selector(createWorkout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createWorkoutButton];

    //This button will open the start workout view controller
    UIButton * startWorkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [startWorkoutButton setTitle:@"Start Workout" forState:UIControlStateNormal];
    [startWorkoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    startWorkoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [startWorkoutButton setBackgroundColor:[UIColor yellowColor]];
    startWorkoutButton.frame = CGRectMake((screenRect.size.width - 200)/2, screenRect.size.height*0.2 + 130, 200, 100);
    [startWorkoutButton addTarget:self action:@selector(startWorkout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startWorkoutButton];

}

-(void)createWorkout{
    WorkoutViewController *workoutViewController = [[WorkoutViewController alloc] init];
    [self presentViewController:workoutViewController animated:YES completion:NULL];
}

-(void)startWorkout{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
