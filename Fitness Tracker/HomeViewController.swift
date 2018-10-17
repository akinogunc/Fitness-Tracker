//
//  SWHomeViewController.swift
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 14.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit
import xModalController

class HomeViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    let yellow = UIColor(red: 248.0/255.0, green: 229.0/255.0, blue: 28.0/255.0, alpha: 1)
    let blue = UIColor(red: 113.0/255.0, green: 201.0/255.0, blue: 246.0/255.0, alpha: 1)
    let red = UIColor(red: 200.0/255.0, green: 61.0/255.0, blue: 76.0/255.0, alpha: 1)
    let green = UIColor(red: 77.0/255.0, green: 210.0/255.0, blue: 164.0/255.0, alpha: 1)
    let orange = UIColor.init(red: 229.0/255.0, green: 93.0/255.0, blue: 41.0/255.0, alpha: 1)
    let darkBlue = UIColor.init(red: 32.0/255.0, green: 72.0/255.0, blue: 190.0/255.0, alpha: 1)
    let darkGreen = UIColor.init(red: 18.0/255.0, green: 121.0/255.0, blue: 21.0/255.0, alpha: 1)
    var colors: NSMutableArray = []
    
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
        startWorkoutButton.setTitle("Start Workout", for: UIControlState.normal)
        startWorkoutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        startWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        startWorkoutButton.titleLabel?.textAlignment = NSTextAlignment.center
        startWorkoutButton.backgroundColor = UIColor.init(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
        startWorkoutButton.frame = CGRect(x: 0, y: screenRect.size.height*0.8, width: screenRect.size.width, height: screenRect.size.height*0.1)
        startWorkoutButton.addTarget(self, action: #selector(HomeViewController.startWorkout), for: UIControlEvents.touchUpInside)
        startWorkoutButton.accessibilityIdentifier = "Create Workout"
        self.view.addSubview(startWorkoutButton)

        //This button will open create workout view controller
        let createWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
        createWorkoutButton.setTitle("Create Workout", for: UIControlState.normal)
        createWorkoutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        createWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        createWorkoutButton.titleLabel?.textAlignment = NSTextAlignment.center
        createWorkoutButton.backgroundColor = UIColor.init(red: 229.0/255.0, green: 93.0/255.0, blue: 41.0/255.0, alpha: 1)
        createWorkoutButton.frame = CGRect(x: 0, y: screenRect.size.height*0.9, width: screenRect.size.width/2, height: screenRect.size.height*0.1)
        createWorkoutButton.addTarget(self, action: #selector(HomeViewController.createWorkout), for: UIControlEvents.touchUpInside)
        self.view.addSubview(createWorkoutButton)

        
        //This button will open create workout view controller
        let showHistoryButton:UIButton = UIButton(type: UIButtonType.custom)
        showHistoryButton.setTitle("Workout History", for: UIControlState.normal)
        showHistoryButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        showHistoryButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        showHistoryButton.titleLabel?.textAlignment = NSTextAlignment.center
        showHistoryButton.backgroundColor = UIColor.init(red: 97.0/255.0, green: 131.0/255.0, blue: 218.0/255.0, alpha: 1)
        showHistoryButton.frame = CGRect(x: screenRect.size.width/2, y: screenRect.size.height*0.9, width: screenRect.size.width/2, height: screenRect.size.height*0.1)
        showHistoryButton.addTarget(self, action: #selector(HomeViewController.showHistory), for: UIControlEvents.touchUpInside)
        self.view.addSubview(showHistoryButton)

        
        colors = [yellow, blue, red, green, orange, darkBlue, darkGreen]

        self.initializeWeeklyCalendar()
        self.initializeBodyFrame()
        
        self.addWorkedBodyPartWithColor(partName: "shoulders", color: yellow)
        self.addWorkedBodyPartWithColor(partName: "abs", color: yellow)

        self.addWorkedBodyPartWithColor(partName: "back", color: blue)
        self.addWorkedBodyPartWithColor(partName: "biceps", color: blue)
        
        self.addWorkedBodyPartWithColor(partName: "chest", color: red)
        self.addWorkedBodyPartWithColor(partName: "triceps", color: red)

        self.addWorkedBodyPartWithColor(partName: "legs", color: green)

        
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            
            let modalVc = WorkoutSaver()
            let modalFrame = CGRect(x: 20, y: 300, width: self.view.bounds.width - 40, height: 350)
            let modalController = xModalController(parentViewController: self, modalViewController: modalVc, modalFrame: modalFrame)
            modalController.showModal()
            
        })*/

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
            
            let dayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: createWorkoutButton.frame.size.width, height: createWorkoutButton.frame.size.height*0.4))
            dayLabel.textColor = UIColor(red: 120.0/255.0, green: 120.0/255.0, blue: 120.0/255.0, alpha: 1)
            dayLabel.backgroundColor = UIColor.clear
            dayLabel.font = UIFont(name: "Metropolis-Medium", size: 14.0)
            dayLabel.numberOfLines = 1
            dayLabel.textAlignment = NSTextAlignment.center
            dayLabel.text = formatter.string(from: date!)
            createWorkoutButton.addSubview(dayLabel)
            
            
            
            
            if(i == 0){
                let workoutCircle = UIView(frame: CGRect(x: dateButtonWidth/4, y: dateButtonWidth*1.3, width: dateButtonWidth/2, height: dateButtonWidth/2))
                workoutCircle.backgroundColor = colors[0] as? UIColor
                workoutCircle.layer.cornerRadius = workoutCircle.frame.size.width/2
                workoutCircle.clipsToBounds = true
                createWorkoutButton.addSubview(workoutCircle)
            }
            
            if(i == 2){
                let workoutCircle = UIView(frame: CGRect(x: dateButtonWidth/4, y: dateButtonWidth*1.3, width: dateButtonWidth/2, height: dateButtonWidth/2))
                workoutCircle.backgroundColor = colors[1] as? UIColor
                workoutCircle.layer.cornerRadius = workoutCircle.frame.size.width/2
                workoutCircle.clipsToBounds = true
                createWorkoutButton.addSubview(workoutCircle)
            }

            if(i == 3){
                let workoutCircle = UIView(frame: CGRect(x: dateButtonWidth/4, y: dateButtonWidth*1.3, width: dateButtonWidth/2, height: dateButtonWidth/2))
                workoutCircle.backgroundColor = colors[2] as? UIColor
                workoutCircle.layer.cornerRadius = workoutCircle.frame.size.width/2
                workoutCircle.clipsToBounds = true
                createWorkoutButton.addSubview(workoutCircle)
            }

            if(i == 5){
                let workoutCircle = UIView(frame: CGRect(x: dateButtonWidth/4, y: dateButtonWidth*1.3, width: dateButtonWidth/2, height: dateButtonWidth/2))
                workoutCircle.backgroundColor = colors[3] as? UIColor
                workoutCircle.layer.cornerRadius = workoutCircle.frame.size.width/2
                workoutCircle.clipsToBounds = true
                createWorkoutButton.addSubview(workoutCircle)
            }

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

        if partName == "chest" || partName == "abs" || partName == "biceps"{
            let bodyFront = UIImageView(frame: CGRect(x: 10, y: bodyImagesY, width: screenRect.size.width/2 - 20, height: screenRect.size.height - bodyImagesY - bottomBarHeight))
            bodyFront.image = UIImage(named: partName)
            bodyFront.image = bodyFront.image?.withRenderingMode(.alwaysTemplate)
            bodyFront.tintColor = color
            bodyFront.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(bodyFront)
        }
        
        if partName == "back" || partName == "triceps"{
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
        
        if partName == "legs" {
            let bodyFront = UIImageView(frame: CGRect(x: 10, y: bodyImagesY, width: screenRect.size.width/2 - 20, height: screenRect.size.height - bodyImagesY - bottomBarHeight))
            bodyFront.image = UIImage(named: "legs_front")
            bodyFront.image = bodyFront.image?.withRenderingMode(.alwaysTemplate)
            bodyFront.tintColor = color
            bodyFront.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(bodyFront)
            
            let bodyBack = UIImageView(frame: CGRect(x: screenRect.size.width/2 + 10, y: bodyImagesY, width: screenRect.size.width/2 - 20, height: screenRect.size.height - bodyImagesY - bottomBarHeight))
            bodyBack.image = UIImage(named: "legs_back")
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
        let workoutHistory = WorkoutHistory();
        self.navigationController?.pushViewController(workoutHistory, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
