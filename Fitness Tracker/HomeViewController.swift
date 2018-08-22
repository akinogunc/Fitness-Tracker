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
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "Metropolis-Bold", size: 20)!]
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

        
        let navigationHeight = (self.navigationController?.navigationBar.frame.size.height)!
        let dateButtonHeight = (screenRect.size.height*0.8 - navigationHeight) / 7
        
        for i in 0...6 {
            let createWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
            createWorkoutButton.backgroundColor = UIColor(red: CGFloat(i)*30.0/255.0, green: CGFloat(i)*30.0/255.0, blue: CGFloat(i)*30.0/255.0, alpha: 1)
            createWorkoutButton.frame = CGRect(x: 0, y: navigationHeight + CGFloat(i)*dateButtonHeight, width: screenRect.size.width/3, height: dateButtonHeight)
            createWorkoutButton.addTarget(self, action: #selector(HomeViewController.createWorkout), for: UIControlEvents.touchUpInside)
            self.view.addSubview(createWorkoutButton)
            
            
            
            let splitLine = UIView(frame: CGRect(x: CGFloat(i)*screenRect.size.width/7, y: (self.navigationController?.navigationBar.frame.size.height)!, width: 1, height: screenRect.size.width/7))
            splitLine.backgroundColor = UIColor.black
            splitLine.alpha = 0.4
            //self.view.addSubview(splitLine)

        }
        
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"

        
        for i in 0...6{
            let gregorian = Calendar(identifier: .gregorian)
            let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
            let date = gregorian.date(byAdding: .day, value: 1 + i, to: sunday!)
            print(String(calendar.component(.day, from: date!)) + formatter.string(from: date!))
        }
        

        
    }

    @objc func startWorkout() -> Void {
        let workoutList = WorkoutsList();
        self.navigationController?.pushViewController(workoutList, animated: true)
    }
    
    @objc func createWorkout() -> Void {
        let workoutCreator = WorkoutCreator();
        self.navigationController?.pushViewController(workoutCreator, animated: true)
    }

    @objc func showHistory() -> Void {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: gregorian.firstWeekday, to: sunday)
    }
    
}

