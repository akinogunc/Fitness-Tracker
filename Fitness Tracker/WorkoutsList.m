//
//  WorkoutsList.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 8.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "WorkoutsList.h"
#import "WorkoutCell.h"
#import "StartWorkout.h"

@implementation WorkoutsList
@synthesize workoutsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    //Getting size of the device
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    //Customizing the navigation bar
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Metropolis-Bold" size:20]}];
    self.navigationItem.title = @"Workouts";

    //initialize workouts array
    workoutsArray = [[NSMutableArray alloc] init];

    //Creating table view which will show workouts
    workoutsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [workoutsTableView setBackgroundColor:[UIColor whiteColor]];
    workoutsTableView.delegate = self;
    workoutsTableView.dataSource = self;
    [self.view addSubview:workoutsTableView];

    
    ///////DELETE EVERYTHING////////
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"savedWorkouts"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    //getting workouts array from user defaults
    workoutsArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"savedWorkouts"] mutableCopy];
    
    //refreshing table view
    [workoutsTableView reloadData];
    
    /*if (workoutsArray) {
        NSLog(@"%@",workoutsArray);
    }*/

}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return workoutsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"workoutCell";
    
    WorkoutCell *cell = (WorkoutCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[WorkoutCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //Setting exercise values from json array
    NSString * workoutNameWithoutExtension = [[workoutsArray objectAtIndex:indexPath.row] stringByDeletingPathExtension];
    cell.workoutLabel.text = workoutNameWithoutExtension;
    cell.startWorkoutButton.tag = indexPath.row;
    [cell.startWorkoutButton addTarget:self action:@selector(startSelectedWorkout:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(void)startSelectedWorkout:(UIButton*)sender{
    
    StartWorkout *startWorkout = [[StartWorkout alloc] init];
    startWorkout.workoutNo = (int)sender.tag;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:startWorkout];
    [self presentViewController:navController animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
