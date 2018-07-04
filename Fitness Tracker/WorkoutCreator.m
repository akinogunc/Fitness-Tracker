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


@implementation WorkoutCreator

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Metropolis-Medium" size:20]}];
    self.navigationItem.title = @"Create Workout";
    
    //Creating plus button which will open workout item view controller
    UIBarButtonItem *plusButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(plusButtonHit)];
    self.navigationItem.rightBarButtonItem = plusButton;

    //Creating table view which will show workout items
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [tableView setBackgroundColor:[UIColor whiteColor]];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (void)plusButtonHit {//this method opens exercise creator
    ExerciseCreator * exerciseCreator = [[ExerciseCreator alloc] init];
    exerciseCreator.transitioningDelegate = self;
    exerciseCreator.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:exerciseCreator animated:YES completion:nil];
}

#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
