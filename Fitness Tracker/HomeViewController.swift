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

    let screenRect = UIScreen.main.bounds
    let yellow = UIColor(red: 248.0/255.0, green: 229.0/255.0, blue: 28.0/255.0, alpha: 1)
    let blue = UIColor.init(red: 97.0/255.0, green: 131.0/255.0, blue: 218.0/255.0, alpha: 1)
    let red = UIColor(red: 200.0/255.0, green: 61.0/255.0, blue: 76.0/255.0, alpha: 1)
    let green = UIColor.init(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
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

        
        colors = [yellow, blue, green, orange, darkBlue, darkGreen, UIColor.magenta]

        self.initializeBodyFrame()
        self.getThisWeeksCompletedWorkouts()

    }

    
    //This function gets all completed workouts and returns current weeks workouts
    func getThisWeeksCompletedWorkouts() -> Void {
        
        var completedWorkoutsArray = NSMutableArray()
        let thisWeekCompletedWorkoutsArray = NSMutableArray()

        //getting completed workouts array from user defaults
        if let savedWorkoutsObject = UserDefaults.standard.object(forKey: "completedWorkouts") as? NSArray{
            completedWorkoutsArray = savedWorkoutsObject.mutableCopy() as! NSMutableArray
        }
        
        //reversing workout to make newest at first
        completedWorkoutsArray = NSMutableArray(array: completedWorkoutsArray.reversed())
        
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day]
        formatter.unitsStyle = .full
        
        //sunday of the current week
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))

        
        for i in 0..<completedWorkoutsArray.count{
            
            let completedWorkoutDict = completedWorkoutsArray.object(at: i) as! NSDictionary
            let date = completedWorkoutDict["date"] as! Date
            let string = formatter.string(from: sunday!, to: date)!//2 days, -1 days
            let arr = string.components(separatedBy:" ")//["2", "days"]

            //if the workout completed at current week, add it
            if(Int(arr[0])! > 0){
                thisWeekCompletedWorkoutsArray.add(completedWorkoutDict)
            }
            
        }

        mergeCompletedWorkoutsAtSameDay(completedWorkouts: thisWeekCompletedWorkoutsArray)
    }
    
    //This function merges workouts which completed at same day
    func mergeCompletedWorkoutsAtSameDay(completedWorkouts: NSMutableArray) -> Void {
        
        let mergedCompletedWorkoutsArray = NSMutableArray()

        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day]
        formatter.unitsStyle = .full

        for i in 0..<completedWorkouts.count{
            
            if(mergedCompletedWorkoutsArray.count == 0){
                mergedCompletedWorkoutsArray.add(completedWorkouts.object(at: i))
            }else{
                
                let dict1 = completedWorkouts.object(at: i) as! NSDictionary
                let date1 = dict1["date"] as! Date
                let dict2 = mergedCompletedWorkoutsArray.lastObject as! NSDictionary
                let date2 = dict2["date"] as! Date
                
                let string = formatter.string(from: date1, to: date2)!//2 days, -1 days
                let arr = string.components(separatedBy:" ")//["2", "days"]
                
                //if the workouts are at the same day
                if(Int(arr[0])! == 0){
                    
                    let date = dict1["date"] as! Date
                    let arr1 = dict1["muscle_groups"] as! NSArray
                    let arr2 = dict2["muscle_groups"] as! NSArray
                    let muscleGroups = arr1.addingObjects(from: arr2 as! [Any])
                    let mergedDict = ["name" : "merged", "date" : date, "muscle_groups" : muscleGroups] as [String : Any]
                    
                    mergedCompletedWorkoutsArray.removeLastObject()
                    mergedCompletedWorkoutsArray.add(mergedDict)
                    
                }else{
                    mergedCompletedWorkoutsArray.add(completedWorkouts.object(at: i))
                }

            }
            
        }
        
        initializeWeeklyCalendar(mergedWorkouts: mergedCompletedWorkoutsArray)
        showTrainedBodyPartsLabel(mergedWorkouts: mergedCompletedWorkoutsArray)
    }
    
    func initializeWeeklyCalendar(mergedWorkouts: NSMutableArray) -> () {
        
        let navigationHeight = self.navigationController?.navigationBar.frame.maxY
        let dateButtonWidth = screenRect.size.width/7
        
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        
        let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        var dotColorCounter = 0
        let workedMuscleGroups = NSMutableArray()
        
        for i in 0...6 {
            
            let date = calendar.date(byAdding: .day, value: 1 + i, to: sunday!)
            
            let createWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
            createWorkoutButton.backgroundColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1)
            createWorkoutButton.frame = CGRect(x: CGFloat(i)*dateButtonWidth, y: navigationHeight!, width: dateButtonWidth, height: dateButtonWidth*2)
            //createWorkoutButton.addTarget(self, action: #selector(HomeViewController.createWorkout), for: UIControlEvents.touchUpInside)
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
            
            
            for j in 0..<mergedWorkouts.count{
                
                let dict = mergedWorkouts.object(at: j) as! NSDictionary
                let workoutDate = dict["date"] as! Date
                let muscleGroups = dict["muscle_groups"] as! NSArray
                
                if(Calendar.current.isDate(workoutDate, inSameDayAs:date!)){

                    let workoutCircle = UIView(frame: CGRect(x: dateButtonWidth/4, y: dateButtonWidth*1.3, width: dateButtonWidth/2, height: dateButtonWidth/2))
                    workoutCircle.backgroundColor = colors[dotColorCounter] as? UIColor
                    workoutCircle.layer.cornerRadius = workoutCircle.frame.size.width/2
                    workoutCircle.clipsToBounds = true
                    createWorkoutButton.addSubview(workoutCircle)
                    
                    for muscle in muscleGroups {
                        if !workedMuscleGroups.contains(muscle){
                            addWorkedBodyPartWithColor(partName: muscle as! String , color: colors[dotColorCounter] as! UIColor)
                        }

                    }

                    dotColorCounter += 1
                    workedMuscleGroups.addObjects(from: muscleGroups as! [Any])
                }

            }
            
        }
        
    }
    
    func showTrainedBodyPartsLabel(mergedWorkouts: NSMutableArray) -> (){
        
        //creating dictionary for worked muscle groups
        var dictionary = [String: Int]()
        
        //counting each muscle group worked how many times
        for i in 0..<mergedWorkouts.count{
            
            let completedWorkoutDict = mergedWorkouts.object(at: i) as! NSDictionary
            let muscleGroupsArray = completedWorkoutDict["muscle_groups"] as! NSArray
            
            for item in muscleGroupsArray {
                if(dictionary[item as! String] == nil){
                    dictionary[item as! String] = 1
                }else{
                    dictionary[item as! String] = dictionary[item as! String]! + 1
                }
            }
            
        }
        
        let allStrings = NSMutableAttributedString()
        
        let boldText  = "Worked Muscles: "
        let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = "Back(x\(dictionary["back"] ?? 0)), Chest(x\(dictionary["chest"] ?? 0)), Biceps(x\(dictionary["biceps"] ?? 0)), Triceps(x\(dictionary["triceps"] ?? 0)), Legs(x\(dictionary["legs"] ?? 0)), Shoulders(x\(dictionary["shoulders"] ?? 0)), Abs(x\(dictionary["back"] ?? 0))"
        let attrs2 = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)]
        let normalString = NSMutableAttributedString(string:normalText, attributes:attrs2)
        
        allStrings.append(attributedString)
        allStrings.append(normalString)

        let workedParts = UILabel(frame: CGRect(x: 10, y: screenRect.size.height*0.7, width: screenRect.size.width - 20, height: screenRect.size.height*0.1))
        workedParts.textColor = UIColor.black
        workedParts.backgroundColor = UIColor.clear
        workedParts.font = UIFont(name: "Metropolis-Medium", size: 14.0)
        workedParts.numberOfLines = 3
        workedParts.textAlignment = NSTextAlignment.left
        workedParts.attributedText = allStrings
        self.view.addSubview(workedParts)


    }

    func initializeBodyFrame() -> () {
        
        let bodyImagesY = (self.navigationController?.navigationBar.frame.maxY)! + 2*screenRect.size.width/7 + 10
        let bottomBarHeight = screenRect.size.height*0.3
        
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
        
        let bodyImagesY = (self.navigationController?.navigationBar.frame.maxY)! + 2*screenRect.size.width/7 + 10
        let bottomBarHeight = screenRect.size.height*0.3

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
