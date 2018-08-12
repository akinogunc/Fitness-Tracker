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

    //getting workouts array from user defaults
    workoutsArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"savedWorkouts"] mutableCopy];
    
    //refreshing table view
    [workoutsTableView reloadData];

}

-(NSMutableArray*)readWorkoutJSONbyName:(NSString*)name{
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = name;
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        
        //Fill the array with the exercises
        NSMutableArray* exercisesArray = [[NSMutableArray alloc] init];
        exercisesArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:fileAtPath] options:NSJSONReadingMutableContainers error:nil];
        return exercisesArray;
    }else{
        NSLog(@"File don't exist");
        return nil;
    }
}

-(NSString*)calculateWorkoutDuration:(NSInteger)index{
    
    NSMutableArray* exercisesArray = [self readWorkoutJSONbyName:[workoutsArray objectAtIndex:index]];
    NSString * duration = @"0";
    int durationInSeconds = 0;

    for (int i = 0; i < exercisesArray.count; i++) {
        NSDictionary * exerciseDict = [exercisesArray objectAtIndex:i];

        if([[exerciseDict objectForKey:@"isCardio"] boolValue]){
            durationInSeconds += [[exerciseDict objectForKey:@"cardio_minutes"] intValue] * 60;
        }else{
            int sets = [[exerciseDict objectForKey:@"sets"] intValue];
            durationInSeconds += [[exerciseDict objectForKey:@"rest"] intValue] * sets;//the time each set takes
            durationInSeconds += [[exerciseDict objectForKey:@"rest"] intValue] * (sets - 1);//the time between sets
        }
        
        //adding 90 seconds for rest and preparation
        if (i != exercisesArray.count - 1) {//don't add rest time for last exercise
            durationInSeconds += 90;
        }
    }
    
    duration = [NSString stringWithFormat:@"%.1f",(float)durationInSeconds/60.0];
    return duration;
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
    cell.workoutDuration.text = [self calculateWorkoutDuration:indexPath.row];
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
