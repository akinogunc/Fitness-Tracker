//
//  SWHomeViewController.swift
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 14.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let yellow = UIColor(red: 248.0/255.0, green: 229.0/255.0, blue: 28.0/255.0, alpha: 1)
    let blue = UIColor(red: 113.0/255.0, green: 201.0/255.0, blue: 246.0/255.0, alpha: 1)
    let red = UIColor(red: 200.0/255.0, green: 61.0/255.0, blue: 76.0/255.0, alpha: 1)
    let green = UIColor(red: 77.0/255.0, green: 210.0/255.0, blue: 164.0/255.0, alpha: 1)

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
        let createWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
        createWorkoutButton.setTitle("Start Workout", for: UIControlState.normal)
        createWorkoutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        createWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        createWorkoutButton.titleLabel?.textAlignment = NSTextAlignment.center
        createWorkoutButton.backgroundColor = UIColor.init(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
        createWorkoutButton.frame = CGRect(x: 0, y: screenRect.size.height*0.8, width: screenRect.size.width/2, height: screenRect.size.height*0.2)
        createWorkoutButton.addTarget(self, action: #selector(HomeViewController.startWorkout), for: UIControlEvents.touchUpInside)
        createWorkoutButton.accessibilityIdentifier = "Create Workout"
        self.view.addSubview(createWorkoutButton)

        //This button will open create workout view controller
        let historyButton:UIButton = UIButton(type: UIButtonType.custom)
        historyButton.setTitle("Create Workout", for: UIControlState.normal)
        historyButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        historyButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        historyButton.titleLabel?.textAlignment = NSTextAlignment.center
        historyButton.backgroundColor = UIColor.init(red: 229.0/255.0, green: 93.0/255.0, blue: 41.0/255.0, alpha: 1)
        historyButton.frame = CGRect(x: screenRect.size.width/2, y: screenRect.size.height*0.8, width: screenRect.size.width/2, height: screenRect.size.height*0.2)
        historyButton.addTarget(self, action: #selector(HomeViewController.createWorkout), for: UIControlEvents.touchUpInside)
        self.view.addSubview(historyButton)

        
        self.initializeWeeklyCalendar()
        self.initializeBodyFrame()
        self.addWorkedBodyPartWithColor(partName: "chest", color: yellow)
        self.addWorkedBodyPartWithColor(partName: "abs", color: blue)
        self.addWorkedBodyPartWithColor(partName: "back", color: red)
        self.addWorkedBodyPartWithColor(partName: "shoulders", color: green)

    }

    func initializeWeeklyCalendar() -> () {
        
        let screenRect = UIScreen.main.bounds

        let navigationHeight = self.navigationController?.navigationBar.frame.maxY
        let dateButtonWidth = screenRect.size.width/7
        
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        
        for i in 0...6 {
            
            let date = calendar.date(byAdding: .day, value: 1 + i, to: sunday!)
            
            let createWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
            createWorkoutButton.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1)
            createWorkoutButton.frame = CGRect(x: CGFloat(i)*dateButtonWidth, y: navigationHeight!, width: dateButtonWidth, height: dateButtonWidth*2)
            createWorkoutButton.addTarget(self, action: #selector(HomeViewController.createWorkout), for: UIControlEvents.touchUpInside)
            createWorkoutButton.setTitle(String(calendar.component(.day, from: date!)), for: UIControlState.normal)
            createWorkoutButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            createWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 16.0)
            self.view.addSubview(createWorkoutButton)
            
            //Highlight today
            if(Calendar.current.isDate(date!, inSameDayAs:Date())){
                createWorkoutButton.backgroundColor = UIColor(red: 194.0/255.0, green: 194.0/255.0, blue: 194.0/255.0, alpha: 1)
            }
            
            let dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: createWorkoutButton.frame.size.width, height: createWorkoutButton.frame.size.height*0.4))
            dateLabel.textColor = UIColor(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 1)
            dateLabel.backgroundColor = UIColor.clear
            dateLabel.font = UIFont(name: "Metropolis-Medium", size: 14.0)
            dateLabel.numberOfLines = 1
            dateLabel.textAlignment = NSTextAlignment.center
            dateLabel.text = formatter.string(from: date!)
            createWorkoutButton.addSubview(dateLabel)
            
        }

    }
    
    func initializeBodyFrame() -> () {
        
        let screenRect = UIScreen.main.bounds
        let bodyImagesY = (self.navigationController?.navigationBar.frame.maxY)! + 2*screenRect.size.width/7
        let bottomBarHeight = screenRect.size.height*0.2
        
        let bodyFront = UIImageView(frame: CGRect(x: 10, y: bodyImagesY, width: screenRect.size.width/2 - 20, height: screenRect.size.height - bodyImagesY - bottomBarHeight))
        bodyFront.image = UIImage(named: "body_front")
        bodyFront.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(bodyFront)
        
        let bodyBack = UIImageView(frame: CGRect(x: screenRect.size.width/2 + 10, y: bodyImagesY, width: screenRect.size.width/2 - 20, height: screenRect.size.height - bodyImagesY - bottomBarHeight))
        bodyBack.image = UIImage(named: "body_back")
        bodyBack.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(bodyBack)

    }
    
    func addWorkedBodyPartWithColor(partName: String, color: UIColor) -> () {
        
        let screenRect = UIScreen.main.bounds
        let bodyImagesY = (self.navigationController?.navigationBar.frame.maxY)! + 2*screenRect.size.width/7
        let bottomBarHeight = screenRect.size.height*0.2

        if partName == "chest" || partName == "abs" {
            let bodyFront = UIImageView(frame: CGRect(x: 10, y: bodyImagesY, width: screenRect.size.width/2 - 20, height: screenRect.size.height - bodyImagesY - bottomBarHeight))
            bodyFront.image = UIImage(named: partName)
            bodyFront.image = bodyFront.image?.withRenderingMode(.alwaysTemplate)
            bodyFront.tintColor = color
            bodyFront.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(bodyFront)
        }
        
        if partName == "back" {
            let bodyBack = UIImageView(frame: CGRect(x: screenRect.size.width/2 + 10, y: bodyImagesY, width: screenRect.size.width/2 - 20, height: screenRect.size.height - bodyImagesY - bottomBarHeight))
            bodyBack.image = UIImage(named: partName)
            bodyBack.image = bodyBack.image?.withRenderingMode(.alwaysTemplate)
            bodyBack.tintColor = color
            bodyBack.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(bodyBack)
        }

        if partName == "shoulders" {
            let bodyFront = UIImageView(frame: CGRect(x: 10, y: bodyImagesY, width: screenRect.size.width/2 - 20, height: screenRect.size.height - bodyImagesY - bottomBarHeight))
            bodyFront.image = UIImage(named: "shoulder_front")
            bodyFront.image = bodyFront.image?.withRenderingMode(.alwaysTemplate)
            bodyFront.tintColor = color
            bodyFront.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(bodyFront)

            let bodyBack = UIImageView(frame: CGRect(x: screenRect.size.width/2 + 10, y: bodyImagesY, width: screenRect.size.width/2 - 20, height: screenRect.size.height - bodyImagesY - bottomBarHeight))
            bodyBack.image = UIImage(named: "shoulder_back")
            bodyBack.image = bodyBack.image?.withRenderingMode(.alwaysTemplate)
            bodyBack.tintColor = color
            bodyBack.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(bodyBack)

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
