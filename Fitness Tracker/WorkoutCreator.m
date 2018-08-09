//
//  WorkoutViewController.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 3.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "WorkoutCreator.h"
#import "HalfSizePresentationController.h"
#import "ExerciseCreator.h"
#import "ExerciseCell.h"

@implementation WorkoutCreator
@synthesize exercisesTableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    //Getting size of the device
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    //Customizing the navigation bar
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Metropolis-Bold" size:20]}];
    self.navigationItem.title = @"Create Workout";
    
    //Creating plus button which will open workout item view controller
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(plusButtonHit)];
    self.navigationItem.rightBarButtonItem = plusButton;

    //This button will save the workout
    UIButton * createWorkoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [createWorkoutButton setTitle:@"Save Workout" forState:UIControlStateNormal];
    [createWorkoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createWorkoutButton.titleLabel setFont:[UIFont fontWithName:@"Metropolis-Medium" size:18.0]];
    createWorkoutButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [createWorkoutButton setBackgroundColor:[UIColor colorWithRed:0 green:179.0/255.0 blue:85.0/255.0 alpha:1]];
    createWorkoutButton.frame = CGRectMake(0, screenRect.size.height - 80, screenRect.size.width, 80);
    [createWorkoutButton addTarget:self action:@selector(saveWorkout) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createWorkoutButton];

    //Creating table view which will show workout items
    exercisesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height - 80)];
    [exercisesTableView setBackgroundColor:[UIColor whiteColor]];
    exercisesTableView.delegate = self;
    exercisesTableView.dataSource = self;
    [self.view addSubview:exercisesTableView];
    
    //initialize exercises array
    exercisesArray = [[NSMutableArray alloc] init];

    //delete previous temporary json file before creating a new workout
    [self deleteTempJSON];

}

-(void)saveWorkout{

    if(exercisesArray.count <= 0){
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Please create an exercise" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Name your workout" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"Chest Workout";
        }];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString * textFieldString = [NSString stringWithFormat:@"%@.json",[[alertController textFields][0] text]];
            
            if (![textFieldString isEqualToString:@""]) {
                [self saveWorkoutWithName:textFieldString];
            }

        }];
        [alertController addAction:confirmAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Canelled");
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }
}

-(void)saveWorkoutWithName:(NSString*)workoutName{
    
    //Getting workouts array
    NSMutableArray * savedWorkouts = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"savedWorkouts"] mutableCopy];
    
    if (!savedWorkouts) {
        savedWorkouts = [[NSMutableArray alloc] init];
    }
    
    //Adding name of the workout to array
    [savedWorkouts addObject:workoutName];
    
    //Changing name of JSON file as workout name
    [self changeJSONName:workoutName];
    
    [[NSUserDefaults standardUserDefaults] setObject:savedWorkouts forKey:@"savedWorkouts"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];

}

//Giving a name to the workout JSON file
-(void)changeJSONName:(NSString*)newName{
    NSString* initFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* initFileName = @"temp.json";
    NSString* initFileAtPath = [initFilePath stringByAppendingPathComponent:initFileName];

    NSString* newFilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* newFileName = newName;
    NSString* newFileAtPath = [newFilePath stringByAppendingPathComponent:newFileName];

    [[NSFileManager defaultManager] moveItemAtPath:initFileAtPath toPath:newFileAtPath error:nil];
}

-(void)deleteTempJSON{
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"temp.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    NSURL *url = [NSURL fileURLWithPath:fileAtPath];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exist = [fm fileExistsAtPath:url.path];
    if (exist) {
        [fm removeItemAtURL:url error:nil];
        NSLog(@"file deleted");
    } else {
        NSLog(@"no file by that name");
    }
}

- (void)plusButtonHit {//this method opens exercise creator
    ExerciseCreator * exerciseCreator = [[ExerciseCreator alloc] init];
    exerciseCreator.transitioningDelegate = self;
    exerciseCreator.modalPresentationStyle = UIModalPresentationCustom;
    exerciseCreator.onDoneBlock = ^(void){[self dismissViewControllerAnimated:YES completion:^(){
        [self readExercisesJSON];
    }];};
    [self presentViewController:exerciseCreator animated:YES completion:nil];
}

//Calling this class means, an exercise added to JSON file
-(void)readExercisesJSON{
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"temp.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        
        //Fill the array with the exercises
        exercisesArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:fileAtPath] options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",exercisesArray);
        //reload the tableview to show the exercises
        [exercisesTableView reloadData];
    }
}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return exercisesArray.count;
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
    static NSString *cellIdentifier = @"exerciseCell";
    
    //Check the workout type and set the cell according to its value
    BOOL isCardio = [[[exercisesArray objectAtIndex:indexPath.row] objectForKey:@"isCardio"] boolValue];

    ExerciseCell *cell = (ExerciseCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ExerciseCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier isCardio:isCardio];
    }
    
    if (isCardio) {
        
        //Setting exercise values from json array
        cell.exerciseLabel.text = [[exercisesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.restLabel.text = [[exercisesArray objectAtIndex:indexPath.row] objectForKey:@"cardio_minutes"];

    }else{
        
        //Setting exercise values from json array
        cell.exerciseLabel.text = [[exercisesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.setsLabel.text = [[exercisesArray objectAtIndex:indexPath.row] objectForKey:@"sets"];
        cell.repsLabel.text = [[exercisesArray objectAtIndex:indexPath.row] objectForKey:@"reps"];
        
        //Adding "s" letter to end of the rest seconds
        NSString * restSeconds = [NSString stringWithFormat:@"%@s",[[exercisesArray objectAtIndex:indexPath.row] objectForKey:@"rest"]];
        cell.restLabel.text = restSeconds;

    }
    
    
    
    return cell;
}

//This delegate method is needed for half-sized modal view controller
- (nullable UIPresentationController *) presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[HalfSizePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
