//
//  WorkoutItemViewController.m
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 4.07.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

#import "ExerciseCreator.h"

@implementation ExerciseCreator
@synthesize setsLabel, setsDownButton, setsUpButton, setCount, repsLabel, repsDownButton, repsUpButton, repsCount, restLabel, restDownButton, restUpButton, restSeconds, cardioTimeLabel, cardioDownButton, cardioUpButton, cardioMinutes;

- (void)viewDidLoad {
    [super viewDidLoad];

    //Initializations
    setCount = 0;
    repsCount = 0;
    restSeconds = 15;
    cardioMinutes = 1;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGRect screenRect = [[UIScreen mainScreen] bounds];

    //Adding navigation bar with items
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 50)];
    [navigationBar setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont fontWithName:@"Metropolis-Medium" size:18]}];

    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(closeModal)];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(saveExercise)];
    
    UINavigationItem *navigationItems = [[UINavigationItem alloc] initWithTitle:@"Create Exercise"];
    navigationItems.rightBarButtonItem = doneItem;
    navigationItems.leftBarButtonItem = cancelItem;
    navigationBar.items = [NSArray arrayWithObjects:navigationItems, nil];
    [self.view addSubview:navigationBar];

    //Adding exercise name label
    UILabel *exerciseName = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, screenRect.size.width/2-20, 30)];
    [exerciseName setTextColor:[UIColor blackColor]];
    [exerciseName setBackgroundColor:[UIColor clearColor]];
    [exerciseName setFont:[UIFont fontWithName: @"Metropolis-Medium" size: 16.0f]];
    exerciseName.text = @"Exercise Name";
    exerciseName.numberOfLines = 0;
    exerciseName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:exerciseName];

    //Adding exercise name text field
    UITextField *exerciseNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(screenRect.size.width/2 - 30, 70, screenRect.size.width/2 + 10, 30)];
    exerciseNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    exerciseNameTextField.font = [UIFont fontWithName: @"Metropolis-Medium" size: 16.0f];
    exerciseNameTextField.placeholder = @"Exercise Name";
    exerciseNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    exerciseNameTextField.keyboardType = UIKeyboardTypeDefault;
    exerciseNameTextField.returnKeyType = UIReturnKeyDone;
    exerciseNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    exerciseNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    exerciseNameTextField.delegate = self;
    [self.view addSubview:exerciseNameTextField];

    //This segmented control switches between Weights UI and Cardio UI
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects: @"Weights", @"Cardio", nil]];
    segmentedControl.frame = CGRectMake(20, 120, screenRect.size.width - 40, 30);
    [segmentedControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];

    //Weights UI
    //Sets UI setup
    setsLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 - 50, 170, 100, 30)];
    [setsLabel setTextColor:[UIColor blackColor]];
    [setsLabel setBackgroundColor:[UIColor clearColor]];
    [setsLabel setFont:[UIFont fontWithName: @"Metropolis-Medium" size: 16.0f]];
    setsLabel.text = @"0 Sets";
    setsLabel.numberOfLines = 0;
    setsLabel.textAlignment = NSTextAlignmentCenter;
    setsLabel.accessibilityIdentifier = @"SetsLabel";
    [self.view addSubview:setsLabel];

    setsDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setsDownButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    setsDownButton.frame = CGRectMake(20, 170, 30, 30);
    [setsDownButton addTarget:self action:@selector(decreaseSets) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setsDownButton];

    setsUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setsUpButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    setsUpButton.frame = CGRectMake(screenRect.size.width - 35, 170, 30, 30);
    [setsUpButton addTarget:self action:@selector(increaseSets) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setsUpButton];

    //Reps UI setup
    repsLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 - 50, 220, 100, 30)];
    [repsLabel setTextColor:[UIColor blackColor]];
    [repsLabel setBackgroundColor:[UIColor clearColor]];
    [repsLabel setFont:[UIFont fontWithName: @"Metropolis-Medium" size: 16.0f]];
    repsLabel.text = @"0 Reps";
    repsLabel.numberOfLines = 0;
    repsLabel.textAlignment = NSTextAlignmentCenter;
    repsLabel.accessibilityIdentifier = @"RepsLabel";
    [self.view addSubview:repsLabel];
    
    repsDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [repsDownButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    repsDownButton.frame = CGRectMake(20, 220, 30, 30);
    [repsDownButton addTarget:self action:@selector(decreaseReps) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repsDownButton];
    
    repsUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [repsUpButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    repsUpButton.frame = CGRectMake(screenRect.size.width - 35, 220, 30, 30);
    [repsUpButton addTarget:self action:@selector(increaseReps) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repsUpButton];

    //Rest UI setup
    restLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 - 90, 270, 180, 30)];
    [restLabel setTextColor:[UIColor blackColor]];
    [restLabel setBackgroundColor:[UIColor clearColor]];
    [restLabel setFont:[UIFont fontWithName: @"Metropolis-Medium" size: 16.0f]];
    restLabel.text = @"15 Seconds Rest";
    restLabel.numberOfLines = 0;
    restLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:restLabel];
    
    restDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [restDownButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    restDownButton.frame = CGRectMake(20, 270, 30, 30);
    [restDownButton addTarget:self action:@selector(decreaseRest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restDownButton];
    
    restUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [restUpButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    restUpButton.frame = CGRectMake(screenRect.size.width - 35, 270, 30, 30);
    [restUpButton addTarget:self action:@selector(increaseRest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restUpButton];

    //Cardio UI
    //Sets UI setup
    cardioTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(screenRect.size.width/2 - 50, 180, 100, 30)];
    [cardioTimeLabel setTextColor:[UIColor blackColor]];
    [cardioTimeLabel setBackgroundColor:[UIColor clearColor]];
    [cardioTimeLabel setFont:[UIFont fontWithName: @"Metropolis-Medium" size: 16.0f]];
    cardioTimeLabel.text = @"1 Minutes";
    cardioTimeLabel.numberOfLines = 0;
    cardioTimeLabel.textAlignment = NSTextAlignmentCenter;
    cardioTimeLabel.accessibilityIdentifier = @"CardioLabel";
    [self.view addSubview:cardioTimeLabel];
    
    cardioDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cardioDownButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    cardioDownButton.frame = CGRectMake(20, 180, 30, 30);
    [cardioDownButton addTarget:self action:@selector(decreaseCardioMinutes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cardioDownButton];
    
    cardioUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cardioUpButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    cardioUpButton.frame = CGRectMake(screenRect.size.width - 35, 180, 30, 30);
    [cardioUpButton addTarget:self action:@selector(increaseCardioMinutes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cardioUpButton];
    
    [self hideCardioUI];
}

-(void)hideCardioUI{
    cardioTimeLabel.hidden = YES;
    cardioDownButton.hidden = YES;
    cardioUpButton.hidden = YES;
}

-(void)showCardioUI{
    cardioTimeLabel.hidden = NO;
    cardioDownButton.hidden = NO;
    cardioUpButton.hidden = NO;
}

-(void)hideWeightsUI{
    setsLabel.hidden = YES;
    setsDownButton.hidden = YES;
    setsUpButton.hidden = YES;
    repsLabel.hidden = YES;
    repsDownButton.hidden = YES;
    repsUpButton.hidden = YES;
    restLabel.hidden = YES;
    restDownButton.hidden = YES;
    restUpButton.hidden = YES;
}

-(void)showWeightsUI{
    setsLabel.hidden = NO;
    setsDownButton.hidden = NO;
    setsUpButton.hidden = NO;
    repsLabel.hidden = NO;
    repsDownButton.hidden = NO;
    repsUpButton.hidden = NO;
    restLabel.hidden = NO;
    restDownButton.hidden = NO;
    restUpButton.hidden = NO;
}

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0) {
        [self hideCardioUI];
        [self showWeightsUI];
    }else{
        [self showCardioUI];
        [self hideWeightsUI];
    }
}

-(void)decreaseSets{
    if(setCount>0){
        setCount--;
        setsLabel.text = [NSString stringWithFormat:@"%d Sets",setCount];
    }
}

-(void)increaseSets{
    setCount++;
    setsLabel.text = [NSString stringWithFormat:@"%d Sets",setCount];
}

-(void)decreaseReps{
    if(repsCount>0){
        repsCount--;
        repsLabel.text = [NSString stringWithFormat:@"%d Reps",repsCount];
    }
}

-(void)increaseReps{
    repsCount++;
    repsLabel.text = [NSString stringWithFormat:@"%d Reps",repsCount];
}

-(void)decreaseRest{
    if(restSeconds>0){
        restSeconds-=15;
        restLabel.text = [NSString stringWithFormat:@"%d Seconds Rest",restSeconds];
    }
}

-(void)increaseRest{
    restSeconds+=15;
    restLabel.text = [NSString stringWithFormat:@"%d Seconds Rest",restSeconds];
}

-(void)decreaseCardioMinutes{
    if(cardioMinutes>1){
        cardioMinutes--;
        cardioTimeLabel.text = [NSString stringWithFormat:@"%d Minutes",cardioMinutes];
    }
}

-(void)increaseCardioMinutes{
    cardioMinutes++;
    cardioTimeLabel.text = [NSString stringWithFormat:@"%d Minutes",cardioMinutes];
}

- (void)closeModal{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveExercise{
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
