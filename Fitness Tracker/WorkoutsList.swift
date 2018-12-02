//
//  WorkoutsList.swift
//  Fitness Tracker
//
//  Created by AKIN on 15.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class WorkoutsList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var workoutsTableView: UITableView!
    var workoutsArray: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        //Customizing navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "Metropolis-Bold", size: 20)!]
        self.navigationItem.title = "Workouts"
        
        //Getting size of the device
        let screenRect = UIScreen.main.bounds

        //Creating table view which will show workouts
        workoutsTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height))
        workoutsTableView.backgroundColor = UIColor.white
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
        self.view.addSubview(workoutsTableView)
        
        //getting workouts array from user defaults
        if let savedWorkoutsObject = UserDefaults.standard.object(forKey: "savedWorkouts") as? NSArray{
            workoutsArray = savedWorkoutsObject.mutableCopy() as? NSMutableArray
        }else{
            workoutsArray = NSMutableArray()
        }
        
        //refreshing table view
        workoutsTableView.reloadData()

    }
    
    func readWorkoutJSONbyName(name : NSString) -> NSMutableArray?{
        
        let filePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var fileAtPath = filePath.strings(byAppendingPaths: [name as String])
        
        if (FileManager.default.fileExists(atPath: fileAtPath[0])) {
            
            let fileData = try! Data.init(contentsOf: URL.init(fileURLWithPath: fileAtPath[0]))
            let jsonObject = try! JSONSerialization.jsonObject(with: fileData, options: JSONSerialization.ReadingOptions.mutableContainers)
            return jsonObject as? NSMutableArray
            
        }else{
            return nil;
        }
        
    }

    func calculateWorkoutDuration(index : NSInteger) -> String {
        
        let workoutDict = workoutsArray.object(at: index) as! NSDictionary
        let exercisesArray = self.readWorkoutJSONbyName(name: workoutDict["name"] as! NSString)
        var duration = "0"
        var durationInSeconds = 0

        for i in 0..<exercisesArray!.count {
            let exerciseDict = exercisesArray?.object(at: i) as! NSDictionary
            
            if(exerciseDict["isCardio"] as! Bool){
                durationInSeconds += Int(exerciseDict["cardio_minutes"] as! String)! * 60
            }else{
                let sets = Int(exerciseDict["sets"] as! String)!
                durationInSeconds += Int(exerciseDict["duration"] as! String)! * sets//the time each set takes
                durationInSeconds += (workoutDict["rest"] as! NSNumber).intValue * (sets-1)//the time between sets
            }
            
            //adding 90 seconds for rest and preparation
            if (i != (exercisesArray?.count)! - 1) {//don't add rest time for last exercise
                durationInSeconds += (workoutDict["rest"] as! NSNumber).intValue
            }

        }
        
        let totalDuration:Double = Double(durationInSeconds) / 60.0
        duration = String(format: "%.1f", totalDuration)
        
        return duration

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "workoutCell"
        
        var cell: WorkoutCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WorkoutCell
        if(cell == nil){
            cell = WorkoutCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.none

        //Setting exercise values from json array
        let workoutName = workoutsArray.object(at: indexPath.row) as! NSDictionary
        let workoutNameWithoutExtension = (workoutName["name"] as! NSString).deletingPathExtension
        cell?.workoutLabel.text = workoutNameWithoutExtension
        cell?.workoutDuration.text = self.calculateWorkoutDuration(index: indexPath.row)
        cell?.startWorkoutButton.tag = indexPath.row
        cell?.startWorkoutButton.addTarget(self, action: #selector(startSelectedWorkout(sender:)), for: UIControlEvents.touchUpInside)

        
        return cell!
    }
    
    @objc func startSelectedWorkout(sender: UIButton) -> Void {
        
        let startWorkout = StartWorkout()
        startWorkout.workoutNo = sender.tag
        
        let navController = UINavigationController.init(rootViewController: startWorkout)
        self.present(navController, animated: true, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
