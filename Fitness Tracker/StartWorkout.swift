//
//  StartWorkout.swift
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 17.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class StartWorkout: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var separatedExercisesArray: NSMutableArray = []
    var countdownTimer: Timer!
    var startPauseWorkoutButton: UIButton!
    var isWorkoutActive = false
    var workoutNo = 0
    var exercisesTableView: UITableView!
    var workoutNameWithoutExtension: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        //Getting size of the device
        let screenRect = UIScreen.main.bounds

        //getting workouts array from user defaults
        let workoutsArray = UserDefaults.standard.object(forKey: "savedWorkouts") as! NSArray
        
        //removing .json extension
        workoutNameWithoutExtension = (workoutsArray.object(at: self.workoutNo) as! NSString).deletingPathExtension

        //Customizing navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "Metropolis-Bold", size: 20)!]
        self.navigationItem.title = workoutNameWithoutExtension
        
        //Creating cancel button which will close the modal
        let cancelButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(StartWorkout.cancelButtonHit))
        self.navigationItem.rightBarButtonItem = cancelButton

        //Creating table view which will show exercises
        exercisesTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height - 80))
        exercisesTableView.backgroundColor = UIColor.white
        exercisesTableView.delegate = self
        exercisesTableView.dataSource = self
        self.view.addSubview(exercisesTableView)

        //This button will start and pause the workout
        startPauseWorkoutButton = UIButton(type: UIButtonType.custom)
        startPauseWorkoutButton.setTitle("START", for: UIControlState.normal)
        startPauseWorkoutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        startPauseWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        startPauseWorkoutButton.titleLabel?.textAlignment = NSTextAlignment.center
        startPauseWorkoutButton.backgroundColor = UIColor.init(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
        startPauseWorkoutButton.frame = CGRect(x: 0, y: screenRect.size.height - 80, width: screenRect.size.width, height: 80)
        startPauseWorkoutButton.addTarget(self, action: #selector(StartWorkout.startPauseWorkout), for: UIControlEvents.touchUpInside)
        self.view.addSubview(startPauseWorkoutButton)

        //Get the json data with name of the file
        self.readWorkoutJSONbyName(name: (workoutsArray.object(at: self.workoutNo) as! String))

    }

    @objc func startPauseWorkout() -> () {
        
        if (isWorkoutActive) {
            isWorkoutActive = false;
            startPauseWorkoutButton.backgroundColor = UIColor(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
            startPauseWorkoutButton.setTitle("START", for: UIControlState.normal)
            countdownTimer.invalidate()
            
            //changing color of the cell
            let indexOfObject = self.getIndexOfFirstUncompletedExercise()
            let separatedExerciseDict = separatedExercisesArray.object(at: indexOfObject) as! NSDictionary
            let mutableDict: NSMutableDictionary = NSMutableDictionary(dictionary: separatedExerciseDict)
            mutableDict["status"] = "2"
            separatedExercisesArray.replaceObject(at: indexOfObject, with: mutableDict)
            exercisesTableView.reloadData()
            
        }else{
            isWorkoutActive = true;
            startPauseWorkoutButton.backgroundColor = UIColor(red: 229.0/255.0, green: 93.0/255.0, blue: 41.0/255.0, alpha: 1)
            startPauseWorkoutButton.setTitle("PAUSE", for: UIControlState.normal)
            countdownTimer = Timer.scheduledTimer(timeInterval: 1/30, target: self, selector: #selector(StartWorkout.updateTimer), userInfo: nil, repeats: true)
        }

    }
    
    func getIndexOfFirstUncompletedExercise() -> Int {
        
        for i in 0..<separatedExercisesArray.count{
            let separatedExerciseDict = separatedExercisesArray.object(at: i) as! NSDictionary
            let duration = Int(separatedExerciseDict["duration"] as! String)!
            
            if(duration>0){
                return i;
            }
        }
        
        return -1
    }
    
    @objc func updateTimer() -> () {
        
        let indexOfObject = self.getIndexOfFirstUncompletedExercise()
        
        if (indexOfObject == -1) {
            countdownTimer.invalidate()

            let alertController = UIAlertController(title: ("You have completed the " + workoutNameWithoutExtension), message: "You can check your completed workouts on History page", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        //Reducing duration of the exercise
        let separatedExerciseDict = separatedExercisesArray.object(at: indexOfObject) as! NSDictionary
        var duration = Int(separatedExerciseDict["duration"] as! String)!
        duration -= 1
        
        if(duration>0){
            
            let separatedExerciseDict = separatedExercisesArray.object(at: indexOfObject) as! NSDictionary
            let mutableDict: NSMutableDictionary = NSMutableDictionary(dictionary: separatedExerciseDict)
            mutableDict["duration"] = String(format: "%d", duration)
            mutableDict["status"] = "1"
            separatedExercisesArray.replaceObject(at: indexOfObject, with: mutableDict)
            exercisesTableView.reloadData()

        }else{
            
            separatedExercisesArray.removeObject(at: indexOfObject)
            exercisesTableView.reloadData()

        }
    }
    
    func readWorkoutJSONbyName(name: String) -> Void {
        
        let filePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var fileAtPath = filePath.strings(byAppendingPaths: [name])
        
        if (FileManager.default.fileExists(atPath: fileAtPath[0])) {
            
            let fileData = try! Data.init(contentsOf: URL.init(fileURLWithPath: fileAtPath[0]))
            let jsonObject = try! JSONSerialization.jsonObject(with: fileData, options: JSONSerialization.ReadingOptions.mutableContainers)
            let rawExercisesArray = jsonObject as! NSMutableArray
            self.seperateExercisesBySetsAndRests(rawExercisesArray: rawExercisesArray)
        }else{
            print("File don't exist")
        }
        
    }

    func seperateExercisesBySetsAndRests(rawExercisesArray: NSMutableArray) -> () {
        
        for i in 0..<rawExercisesArray.count {
            let exerciseDict = rawExercisesArray.object(at: i) as! NSDictionary
            
            if(exerciseDict["isCardio"] as! Bool){
                let cardioSeconds = Int(exerciseDict["cardio_minutes"] as! String)! * 60
                let separatedExercise = ["name" : exerciseDict["name"], "duration" : String(format: "%d", cardioSeconds), "status" : "0"]
                separatedExercisesArray.add(separatedExercise)
            }else{
                let sets = Int(exerciseDict["sets"] as! String)!
                
                for j in 0..<sets {
                    let separatedExercise = ["name" : exerciseDict["name"], "duration" : exerciseDict["rest"], "reps" : exerciseDict["reps"], "status" : "0"]
                    separatedExercisesArray.add(separatedExercise)
                    
                    if (j != sets-1){
                        let separatedExercise = ["name" : "Rest", "duration" : exerciseDict["rest"], "status" : "0"]
                        separatedExercisesArray.add(separatedExercise)
                    }
                }
            }
            
            //adding 90 seconds for rest and preparation
            if (i != rawExercisesArray.count - 1) {//don't add rest time for last exercise
                
                let separatedExercise: NSDictionary = ["name" : "Rest and Preparation", "duration" : "90", "status" : "0"]
                separatedExercisesArray.add(separatedExercise)

            }

        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return separatedExercisesArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "separatedCell"
        
        var cell: SeparatedExerciseCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SeparatedExerciseCell
        if(cell == nil){
            cell = SeparatedExerciseCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        let separatedExerciseDict = separatedExercisesArray.object(at: indexPath.row) as! NSDictionary
        let duration = Int(separatedExerciseDict["duration"] as! String)!
        let minutes = duration/60
        let seconds = duration%60
        cell?.countdownLabel.text = String(format: "%d:%02d", minutes, seconds)
        cell?.exerciseNameLabel.text = separatedExerciseDict["name"] as? String
        
        if let reps = separatedExerciseDict["reps"]{
            cell?.repsLabel.isHidden = false
            cell?.repsStaticLabel.isHidden = false
            cell?.repsLabel.text = reps as? String
        }else{
            cell?.repsLabel.isHidden = true
            cell?.repsStaticLabel.isHidden = true
        }

        if (Int(separatedExerciseDict["status"] as! String)! == 0) {//default status
            cell?.backgroundColor = UIColor.white
            cell?.countdownLabel.textColor = UIColor.black
            cell?.exerciseNameLabel.textColor = UIColor.black
            cell?.exerciseNameLabel.font = UIFont(name: "Metropolis-Medium", size: 20.0)
        }else if (Int(separatedExerciseDict["status"] as! String)! == 1){//active
            cell?.backgroundColor = UIColor(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
            cell?.countdownLabel.textColor = UIColor.white
            cell?.exerciseNameLabel.textColor = UIColor.white
            cell?.exerciseNameLabel.font = UIFont(name: "Metropolis-Bold", size: 20.0)
        }else if (Int(separatedExerciseDict["status"] as! String)! == 2){//paused
            cell?.backgroundColor = UIColor(red: 229.0/255.0, green: 93.0/255.0, blue: 41.0/255.0, alpha: 1)
            cell?.countdownLabel.textColor = UIColor.white
            cell?.exerciseNameLabel.textColor = UIColor.white
            cell?.exerciseNameLabel.font = UIFont(name: "Metropolis-Bold", size: 20.0)
        }

        return cell!

    }

    @objc func cancelButtonHit() -> () {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
