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

@implementation WorkoutCreator{
    NSMutableArray * exercisesArray;
}

@synthesize exercisesTableView;

- (void)viewDidLoad {
    [super viewDidLoad];

    //Customizing the navigation bar
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Metropolis-Bold" size:20]}];
    self.navigationItem.title = @"Create Workout";
    
    //Creating plus button which will open workout item view controller
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(plusButtonHit)];
    self.navigationItem.rightBarButtonItem = plusButton;

    //Creating table view which will show workout items
    exercisesTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [exercisesTableView setBackgroundColor:[UIColor whiteColor]];
    exercisesTableView.delegate = self;
    exercisesTableView.dataSource = self;
    [self.view addSubview:exercisesTableView];
    
    //initialize exercises array
    exercisesArray = [[NSMutableArray alloc] init];

    //delete previous temporary json file before creating a new workout
    [self deleteTempJSON];

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
        
        //Getting exercise values from json array
        cell.exerciseLabel.text = [[exercisesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.restLabel.text = [[exercisesArray objectAtIndex:indexPath.row] objectForKey:@"cardio_minutes"];

    }else{
        
        //Getting exercise values from json array
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
