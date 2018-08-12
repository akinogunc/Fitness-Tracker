//
//  StartWorkout.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 8.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "StartWorkout.h"
#import "SeparatedExerciseCell.h"

@implementation StartWorkout
@synthesize workoutNo,exercisesTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //Getting size of the device
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    //getting workouts array from user defaults
    NSMutableArray * workoutsArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"savedWorkouts"] mutableCopy];

    //removing .json extension
    NSString * workoutNameWithoutExtension = [[workoutsArray objectAtIndex:self.workoutNo] stringByDeletingPathExtension];

    //Setting navigation bar title
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Metropolis-Bold" size:20]}];
    self.navigationItem.title = workoutNameWithoutExtension;

    //Creating cancel button which will close the modal
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonHit)];
    self.navigationItem.rightBarButtonItem = cancelButton;

    //Creating table view which will show exercises
    exercisesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height - 80)];
    [exercisesTableView setBackgroundColor:[UIColor whiteColor]];
    exercisesTableView.delegate = self;
    exercisesTableView.dataSource = self;
    [self.view addSubview:exercisesTableView];

    //This button will save the workout
    UIButton * createWorkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [createWorkoutButton setTitle:@"START" forState:UIControlStateNormal];
    [createWorkoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createWorkoutButton.titleLabel setFont:[UIFont fontWithName:@"Metropolis-Medium" size:18.0]];
    createWorkoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createWorkoutButton setBackgroundColor:[UIColor colorWithRed:0 green:179.0/255.0 blue:85.0/255.0 alpha:1]];
    createWorkoutButton.frame = CGRectMake(0, screenRect.size.height - 80, screenRect.size.width, 80);
    [createWorkoutButton addTarget:self action:@selector(startWorkout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createWorkoutButton];

    //initialize exercises array
    separatedExercisesArray = [[NSMutableArray alloc] init];

    [self readWorkoutJSONbyName:[workoutsArray objectAtIndex:self.workoutNo]];

}

-(void)startWorkout{
    
}

-(void)readWorkoutJSONbyName:(NSString*)name{
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = name;
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        
        //Fill the array with the exercises
        NSMutableArray* rawExercisesArray = [[NSMutableArray alloc] init];
        rawExercisesArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:fileAtPath] options:NSJSONReadingMutableContainers error:nil];
        [self seperateExercisesBySetsAndRests:rawExercisesArray];
    }else{
        NSLog(@"File don't exist");
    }
}

-(void)seperateExercisesBySetsAndRests:(NSMutableArray*)rawExercisesArray{
    //NSLog(@"RAW%@",rawExercisesArray);
    
    for (int i = 0; i < rawExercisesArray.count; i++) {
        NSDictionary * exerciseDict = [rawExercisesArray objectAtIndex:i];
        
        if([[exerciseDict objectForKey:@"isCardio"] boolValue]){
            
            NSDictionary * separatedExercise = [[NSDictionary alloc] init];
            int cardioSeconds = [[exerciseDict objectForKey:@"cardio_minutes"] intValue] * 60;
            separatedExercise = @{ @"name" : [exerciseDict objectForKey:@"name"], @"duration" : [NSString stringWithFormat:@"%d",cardioSeconds]};
            [separatedExercisesArray addObject:separatedExercise];
            
        }else{
            int sets = [[exerciseDict objectForKey:@"sets"] intValue];
            
            for (int i = 0; i < sets; i++) {
                
                NSDictionary * separatedExercise = [[NSDictionary alloc] init];
                separatedExercise = @{ @"name" : [exerciseDict objectForKey:@"name"], @"duration" : [exerciseDict objectForKey:@"rest"]};
                [separatedExercisesArray addObject:separatedExercise];

                if (i != sets - 1) {//don't add rest time for last move
                
                    NSDictionary * separatedExercise = [[NSDictionary alloc] init];
                    separatedExercise = @{ @"name" : @"Rest", @"duration" : [exerciseDict objectForKey:@"rest"]};
                    [separatedExercisesArray addObject:separatedExercise];

                }
            }
            
        }
        
        //adding 90 seconds for rest and preparation
        if (i != rawExercisesArray.count - 1) {//don't add rest time for last exercise
            
            NSDictionary * separatedExercise = [[NSDictionary alloc] init];
            separatedExercise = @{ @"name" : @"Rest and Preparation", @"duration" : @"90"};
            [separatedExercisesArray addObject:separatedExercise];
        }
    }
    
    //NSLog(@"SEP%@",separatedExercisesArray);

}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return separatedExercisesArray.count;
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
    static NSString *cellIdentifier = @"separatedCell";
    
    SeparatedExerciseCell *cell = (SeparatedExerciseCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[SeparatedExerciseCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary * separatedExerciseDict = [separatedExercisesArray objectAtIndex:indexPath.row];
    int duration = [[separatedExerciseDict objectForKey:@"duration"] intValue];
    int minutes = duration / 60;
    int seconds = duration % 60;
    cell.countdownLabel.text = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
    cell.exerciseNameLabel.text = [separatedExerciseDict objectForKey:@"name"];
    
    return cell;
}

-(void)cancelButtonHit{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
