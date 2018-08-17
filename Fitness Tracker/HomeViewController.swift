//
//  SWHomeViewController.swift
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 14.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        //Customizing navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: "Metropolis-Bold", size: 20)!]
        self.navigationController?.navigationBar.topItem?.title = "Fitness Tracker"
        
        //TODO:Creating custom back button which will ask a question before popping the view controller
        let newBackButton:UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = newBackButton;
        
        //Getting size of the device
        let screenRect = UIScreen.main.bounds
        
        //This button will open the start workout view controller
        let startWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
        startWorkoutButton.setImage(UIImage(named: "start_button"), for: UIControlState.normal)
        startWorkoutButton.frame = CGRect(x: (screenRect.size.width - 170)/2, y: screenRect.size.height*0.3, width: 170, height: 170)
        startWorkoutButton.addTarget(self, action: #selector(HomeViewController.startWorkout), for: UIControlEvents.touchUpInside)
        self.view.addSubview(startWorkoutButton)
        
        //This button will open the create workout view controller
        let createWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
        createWorkoutButton.setTitle("Create Workout", for: UIControlState.normal)
        createWorkoutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        createWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        createWorkoutButton.titleLabel?.textAlignment = NSTextAlignment.center
        createWorkoutButton.backgroundColor = UIColor.init(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
        createWorkoutButton.frame = CGRect(x: 0, y: screenRect.size.height*0.8, width: screenRect.size.width/2, height: screenRect.size.height*0.2)
        createWorkoutButton.addTarget(self, action: #selector(HomeViewController.createWorkout), for: UIControlEvents.touchUpInside)
        createWorkoutButton.accessibilityIdentifier = "Create Workout"
        self.view.addSubview(createWorkoutButton)

        //This button will open the history view controller
        let historyButton:UIButton = UIButton(type: UIButtonType.custom)
        historyButton.setTitle("Workout History", for: UIControlState.normal)
        historyButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        historyButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        historyButton.titleLabel?.textAlignment = NSTextAlignment.center
        historyButton.backgroundColor = UIColor.init(red: 229.0/255.0, green: 93.0/255.0, blue: 41.0/255.0, alpha: 1)
        historyButton.frame = CGRect(x: screenRect.size.width/2, y: screenRect.size.height*0.8, width: screenRect.size.width/2, height: screenRect.size.height*0.2)
        historyButton.addTarget(self, action: #selector(HomeViewController.showHistory), for: UIControlEvents.touchUpInside)
        self.view.addSubview(historyButton)

    }

    func startWorkout() -> Void {
        let workoutList = WorkoutsList();
        self.navigationController?.pushViewController(workoutList, animated: true)
    }
    
    func createWorkout() -> Void {
        let workoutCreator = WorkoutCreator();
        self.navigationController?.pushViewController(workoutCreator, animated: true)
    }

    func showHistory() -> Void {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
