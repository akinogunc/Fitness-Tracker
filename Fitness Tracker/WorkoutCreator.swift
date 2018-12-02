//
//  WorkoutCreator.swift
//  Fitness Tracker
//
//  Created by AKIN on 16.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit
import xModalController

class WorkoutCreator: UIViewController, UITableViewDelegate, UITableViewDataSource, WorkoutSaverDelegate {

    var exercisesArray: NSMutableArray  = []
    var exercisesTableView: UITableView!
    let screenRect = UIScreen.main.bounds

    override func viewDidLoad() {
        super.viewDidLoad()

        //Getting size of the device

        //Customizing navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "Metropolis-Bold", size: 20)!]
        self.navigationItem.title = "Create Workout"
        
        //Creating plus button which will open workout item view controller
        let plusButton:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(WorkoutCreator.plusButtonHit))
        self.navigationItem.rightBarButtonItem = plusButton;

        //This button will save the workout
        let saveWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
        saveWorkoutButton.setTitle("Save Workout", for: UIControlState.normal)
        saveWorkoutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        saveWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        saveWorkoutButton.titleLabel?.textAlignment = NSTextAlignment.center
        saveWorkoutButton.backgroundColor = UIColor.init(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
        saveWorkoutButton.frame = CGRect(x: 0, y: screenRect.size.height - 80, width: screenRect.size.width, height: 80)
        saveWorkoutButton.addTarget(self, action: #selector(WorkoutCreator.saveWorkout), for: UIControlEvents.touchUpInside)
        self.view.addSubview(saveWorkoutButton)

        //Creating table view which will show workouts
        exercisesTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height - 80))
        exercisesTableView.backgroundColor = UIColor.white
        exercisesTableView.delegate = self
        exercisesTableView.dataSource = self
        self.view.addSubview(exercisesTableView)

        //delete previous temporary json file before creating a new workout
        self.deleteTempJSON()
        
    }

    @objc func saveWorkout() -> () {
        
        if(exercisesArray.count <= 0){
            
            let alertController = UIAlertController(title: "Please create at least one exercise", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            
            let modalVc = WorkoutSaver()
            modalVc.delegate = self
            let modalFrame = CGRect(x: 20, y: (screenRect.size.height-450)/2, width: screenRect.size.width - 40, height: 450)
            let modalController = xModalController(parentViewController: self, modalViewController: modalVc, modalFrame: modalFrame)
            modalController.showModal()

        }

    }

    func saveCompleted(workoutName : String) {
        self.changeJSONName(newName: workoutName + ".json")
        self.navigationController?.popViewController(animated: true)
    }
    
    //Giving a name to the workout JSON file and saving it
    func changeJSONName(newName : String) -> Void {

        let filePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var fileAtPath = filePath.strings(byAppendingPaths: ["temp.json"])

        let newFilePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var newFileAtPath = newFilePath.strings(byAppendingPaths: [newName])

        try! FileManager.default.moveItem(atPath: fileAtPath[0], toPath: newFileAtPath[0])
        
    }

    func deleteTempJSON() -> () {
        
        let filePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var fileAtPath = filePath.strings(byAppendingPaths: ["temp.json"])

        if (FileManager.default.fileExists(atPath: fileAtPath[0])) {
            try! FileManager.default.removeItem(at: URL.init(fileURLWithPath: fileAtPath[0]))
            print("Temporary json deleted")
        }
        
    }
    
    //Calling this class means, an exercise added to JSON file
    func readExercisesJSON() -> Void {
        
        let filePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var fileAtPath = filePath.strings(byAppendingPaths: ["temp.json"])
        
        if (FileManager.default.fileExists(atPath: fileAtPath[0])) {
            
            let fileData = try! Data.init(contentsOf: URL.init(fileURLWithPath: fileAtPath[0]))
            let jsonObject = try! JSONSerialization.jsonObject(with: fileData, options: JSONSerialization.ReadingOptions.mutableContainers)
            exercisesArray = jsonObject as! NSMutableArray
            exercisesTableView.reloadData()
        }

    }
    
    @objc func plusButtonHit() -> Void {

        let exerciseCreator = ExerciseCreator()
        exerciseCreator.onDoneBlock = {() -> Void in
            self.dismiss(animated: true, completion: {
                self.readExercisesJSON()
                self.exercisesTableView.reloadData()
            })
        }

        let modalFrame = CGRect(x: 0, y: self.view.bounds.height / 2, width: self.view.bounds.width, height: self.view.bounds.height / 2)
        let modalController = xModalController(parentViewController: self, modalViewController: exerciseCreator, modalFrame: modalFrame)
        modalController.showModal()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesArray.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "exerciseCell"
        
        //Check the workout type and set the cell according to its value
        let isCardio = (exercisesArray.object(at: indexPath.row) as! NSDictionary)["isCardio"] as! Bool
        
        var cell: ExerciseCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ExerciseCell
        if(cell == nil){
            cell = ExerciseCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier, isCardio: isCardio)
        }
        
        if isCardio {
            
            //Setting exercise values from json array
            cell?.exerciseLabel.text = (exercisesArray.object(at: indexPath.row) as! NSDictionary)["name"] as? String
            cell?.restLabel.text = (exercisesArray.object(at: indexPath.row) as! NSDictionary)["cardio_minutes"] as? String
            
        } else {
         
            //Setting exercise values from json array
            cell?.exerciseLabel.text = (exercisesArray.object(at: indexPath.row) as! NSDictionary)["name"] as? String
            cell?.setsLabel.text = (exercisesArray.object(at: indexPath.row) as! NSDictionary)["sets"] as? String
            cell?.repsLabel.text = (exercisesArray.object(at: indexPath.row) as! NSDictionary)["reps"] as? String
            
            //Adding "s" letter to end of the rest seconds
            let restSeconds = (exercisesArray.object(at: indexPath.row) as! NSDictionary)["duration"] as! String + "s"
            cell?.restLabel.text = restSeconds;

        }
        
        return cell!

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
