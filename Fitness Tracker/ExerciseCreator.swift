//
//  ExerciseCreator.swift
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 17.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class ExerciseCreator: UIViewController, UITextFieldDelegate {

    var setsLabel: UILabel!
    var setsDownButton: UIButton!
    var setsUpButton: UIButton!
    var setCount = 0;
    var repsLabel: UILabel!
    var repsDownButton: UIButton!
    var repsUpButton: UIButton!
    var repsCount = 0;
    var restLabel: UILabel!
    var restDownButton: UIButton!
    var restUpButton: UIButton!
    var restSeconds = 15;
    var cardioTimeLabel: UILabel!
    var cardioDownButton: UIButton!
    var cardioUpButton: UIButton!
    var cardioMinutes = 1;
    var exerciseNameTextField: UITextField!
    var segmentedControl: UISegmentedControl!
    var onDoneBlock : (() -> Void)?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        //Getting size of the device
        let screenRect = UIScreen.main.bounds

        //Adding navigation bar with items
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenRect.size.width, height: 50))
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont(name: "Metropolis-Medium", size: 18)!]

        let cancelItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ExerciseCreator.closeModal))
        let doneItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ExerciseCreator.saveExercise))

        let navigationItems = UINavigationItem(title: "Create Exercise")
        navigationItems.rightBarButtonItem = doneItem
        navigationItems.leftBarButtonItem = cancelItem
        navigationBar.items = [navigationItems]
        self.view.addSubview(navigationBar)
        
        
        //Adding exercise name label
        let exerciseName = UILabel(frame: CGRect(x: 20, y: 70, width: screenRect.size.width/2 - 20, height: 30))
        exerciseName.textColor = UIColor.black
        exerciseName.backgroundColor = UIColor.clear
        exerciseName.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        exerciseName.text = "Exercise Name";
        exerciseName.numberOfLines = 0;
        exerciseName.textAlignment = NSTextAlignment.left;
        self.view.addSubview(exerciseName)

        
        //Adding exercise name text field
        exerciseNameTextField = UITextField(frame: CGRect(x: screenRect.size.width/2 - 30, y: 70, width: screenRect.size.width/2 + 10, height: 30))
        exerciseNameTextField.borderStyle = UITextBorderStyle.roundedRect
        exerciseNameTextField.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        exerciseNameTextField.placeholder = "Exercise Name"
        exerciseNameTextField.autocorrectionType = UITextAutocorrectionType.no
        exerciseNameTextField.keyboardType = UIKeyboardType.default
        exerciseNameTextField.returnKeyType = UIReturnKeyType.done
        exerciseNameTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        exerciseNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        exerciseNameTextField.delegate = self
        self.view.addSubview(exerciseNameTextField)

        //This segmented control switches between Weights UI and Cardio UI
        segmentedControl = UISegmentedControl(items: ["Weights", "Cardio"])
        segmentedControl.frame = CGRect(x: 20, y: 120, width: screenRect.size.width - 40, height: 30)
        segmentedControl.addTarget(self, action: #selector(ExerciseCreator.segmentControlAction(segment:)), for: UIControlEvents.valueChanged)
        segmentedControl.selectedSegmentIndex = 0;
        self.view.addSubview(segmentedControl)

        //Weights UI
        setsLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 - 50, y: 170, width: 100, height: 30))
        setsLabel.textColor = UIColor.black
        setsLabel.backgroundColor = UIColor.clear
        setsLabel.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        setsLabel.text = "0 Sets";
        setsLabel.numberOfLines = 0;
        setsLabel.textAlignment = NSTextAlignment.center;
        setsLabel.accessibilityIdentifier = "SetsLabel"
        self.view.addSubview(setsLabel)

        setsDownButton = UIButton(type: UIButtonType.custom)
        setsDownButton.setImage(UIImage(named: "down"), for: UIControlState.normal)
        setsDownButton.frame = CGRect(x: 20, y: 170, width: 30, height: 30)
        setsDownButton.addTarget(self, action: #selector(ExerciseCreator.decreaseSets), for: UIControlEvents.touchUpInside)
        self.view.addSubview(setsDownButton)

        setsUpButton = UIButton(type: UIButtonType.custom)
        setsUpButton.setImage(UIImage(named: "up"), for: UIControlState.normal)
        setsUpButton.frame = CGRect(x: screenRect.size.width - 50, y: 170, width: 30, height: 30)
        setsUpButton.addTarget(self, action: #selector(ExerciseCreator.increaseSets), for: UIControlEvents.touchUpInside)
        self.view.addSubview(setsUpButton)

        //Reps UI setup
        repsLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 - 50, y: 220, width: 100, height: 30))
        repsLabel.textColor = UIColor.black
        repsLabel.backgroundColor = UIColor.clear
        repsLabel.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        repsLabel.text = "0 Reps";
        repsLabel.numberOfLines = 0;
        repsLabel.textAlignment = NSTextAlignment.center;
        repsLabel.accessibilityIdentifier = "RepsLabel"
        self.view.addSubview(repsLabel)
        
        repsDownButton = UIButton(type: UIButtonType.custom)
        repsDownButton.setImage(UIImage(named: "down"), for: UIControlState.normal)
        repsDownButton.frame = CGRect(x: 20, y: 220, width: 30, height: 30)
        repsDownButton.addTarget(self, action: #selector(ExerciseCreator.decreaseReps), for: UIControlEvents.touchUpInside)
        self.view.addSubview(repsDownButton)
        
        repsUpButton = UIButton(type: UIButtonType.custom)
        repsUpButton.setImage(UIImage(named: "up"), for: UIControlState.normal)
        repsUpButton.frame = CGRect(x: screenRect.size.width - 50, y: 220, width: 30, height: 30)
        repsUpButton.addTarget(self, action: #selector(ExerciseCreator.increaseReps), for: UIControlEvents.touchUpInside)
        self.view.addSubview(repsUpButton)

        //Rest UI setup
        restLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 - 90, y: 270, width: 180, height: 30))
        restLabel.textColor = UIColor.black
        restLabel.backgroundColor = UIColor.clear
        restLabel.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        restLabel.text = "15 Seconds Rest";
        restLabel.numberOfLines = 0;
        restLabel.textAlignment = NSTextAlignment.center;
        self.view.addSubview(restLabel)
        
        restDownButton = UIButton(type: UIButtonType.custom)
        restDownButton.setImage(UIImage(named: "down"), for: UIControlState.normal)
        restDownButton.frame = CGRect(x: 20, y: 270, width: 30, height: 30)
        restDownButton.addTarget(self, action: #selector(ExerciseCreator.decreaseRest), for: UIControlEvents.touchUpInside)
        self.view.addSubview(restDownButton)
        
        restUpButton = UIButton(type: UIButtonType.custom)
        restUpButton.setImage(UIImage(named: "up"), for: UIControlState.normal)
        restUpButton.frame = CGRect(x: screenRect.size.width - 50, y: 270, width: 30, height: 30)
        restUpButton.addTarget(self, action: #selector(ExerciseCreator.increaseRest), for: UIControlEvents.touchUpInside)
        self.view.addSubview(restUpButton)

        //Cardio UI
        cardioTimeLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 - 50, y: 180, width: 100, height: 30))
        cardioTimeLabel.textColor = UIColor.black
        cardioTimeLabel.backgroundColor = UIColor.clear
        cardioTimeLabel.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        cardioTimeLabel.text = "1 Minutes";
        cardioTimeLabel.numberOfLines = 0;
        cardioTimeLabel.textAlignment = NSTextAlignment.center;
        cardioTimeLabel.accessibilityIdentifier = "CardioLabel"
        self.view.addSubview(cardioTimeLabel)
        
        cardioDownButton = UIButton(type: UIButtonType.custom)
        cardioDownButton.setImage(UIImage(named: "down"), for: UIControlState.normal)
        cardioDownButton.frame = CGRect(x: 20, y: 180, width: 30, height: 30)
        cardioDownButton.addTarget(self, action: #selector(ExerciseCreator.decreaseCardioMinutes), for: UIControlEvents.touchUpInside)
        self.view.addSubview(cardioDownButton)
        
        cardioUpButton = UIButton(type: UIButtonType.custom)
        cardioUpButton.setImage(UIImage(named: "up"), for: UIControlState.normal)
        cardioUpButton.frame = CGRect(x: screenRect.size.width - 50, y: 180, width: 30, height: 30)
        cardioUpButton.addTarget(self, action: #selector(ExerciseCreator.increaseCardioMinutes), for: UIControlEvents.touchUpInside)
        self.view.addSubview(cardioUpButton)

        self.hideCardioUI()
        
    }

    func hideCardioUI () -> (){
        cardioTimeLabel.isHidden = true
        cardioDownButton.isHidden = true
        cardioUpButton.isHidden = true
    }
    
    func showCardioUI () -> (){
        cardioTimeLabel.isHidden = false
        cardioDownButton.isHidden = false
        cardioUpButton.isHidden = false
    }
    
    func hideWeightsUI () -> (){
        setsLabel.isHidden = true
        setsDownButton.isHidden = true
        setsUpButton.isHidden = true
        repsLabel.isHidden = true
        repsDownButton.isHidden = true
        repsUpButton.isHidden = true
        restLabel.isHidden = true
        restDownButton.isHidden = true
        restUpButton.isHidden = true
    }
    
    func showWeightsUI () -> (){
        setsLabel.isHidden = false
        setsDownButton.isHidden = false
        setsUpButton.isHidden = false
        repsLabel.isHidden = false
        repsDownButton.isHidden = false
        repsUpButton.isHidden = false
        restLabel.isHidden = false
        restDownButton.isHidden = false
        restUpButton.isHidden = false
    }

    @objc func segmentControlAction(segment: UISegmentedControl) -> () {
        if(segment.selectedSegmentIndex == 0){
            self.hideCardioUI()
            self.showWeightsUI()
        }else{
            self.showCardioUI()
            self.hideWeightsUI()
        }
    }

    @objc func decreaseSets () -> (){
        if(setCount>0){
            setCount -= 1
            setsLabel.text = String(format: "%d Sets", setCount)
        }
    }
    
    @objc func increaseSets () -> (){
        setCount += 1
        setsLabel.text = String(format: "%d Sets", setCount)
    }

    @objc func decreaseReps () -> (){
        if(repsCount>0){
            repsCount -= 1
            repsLabel.text = String(format: "%d Reps", repsCount)
        }
    }
    
    @objc func increaseReps () -> (){
        repsCount += 1
        repsLabel.text = String(format: "%d Reps", repsCount)
    }

    @objc func decreaseRest () -> (){
        if(restSeconds>0){
            restSeconds -= 15
            restLabel.text = String(format: "%d Seconds Rest", restSeconds)
        }
    }
    
    @objc func increaseRest () -> (){
        restSeconds += 15
        restLabel.text = String(format: "%d Seconds Rest", restSeconds)
    }

    @objc func decreaseCardioMinutes () -> (){
        if(cardioMinutes>1){
            cardioMinutes -= 1
            cardioTimeLabel.text = String(format: "%d Minutes", cardioMinutes)
        }
    }
    
    @objc func increaseCardioMinutes () -> (){
        cardioMinutes += 1
        cardioTimeLabel.text = String(format: "%d Minutes", cardioMinutes)
    }
    
    @objc func closeModal() -> () {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveExercise() -> () {
        print("ananan")
        if(exerciseNameTextField.text == ""){
            let alertController = UIAlertController(title: "Please enter an exercise name", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        //Creating a dictionary from the exercise values
        var exerciseDictionary: NSDictionary!
        
        if (segmentedControl.selectedSegmentIndex == 0) {
            exerciseDictionary =  ["name" : exerciseNameTextField.text!, "sets" : String(format: "%d", setCount), "reps" : String(format: "%d", repsCount), "rest" : String(format: "%d", restSeconds), "isCardio" : false]
        }else{
            exerciseDictionary =  ["name" : exerciseNameTextField.text!, "cardio_minutes" : String(format: "%d", cardioMinutes), "isCardio" : true]
        }
        
        //Reading exercises JSON file
        let exercisesString = self.readExercisesJSON()

        //If JSON file is empty, create it from the dictionary
        if(exercisesString == "empty"){
            
            let exercisesArray: NSMutableArray = NSMutableArray.init()
            exercisesArray.add(exerciseDictionary)

            let jsonData: Data = try! JSONSerialization.data(withJSONObject: exercisesArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonString: String = String.init(data: jsonData, encoding: String.Encoding.utf8)!
            self.addExerciseToJSON(exerciseString: jsonString)
            
        }else{//if JSON file is not empty, get it and add dictionary to it then write it to file
            
            let exercisesArray = try! JSONSerialization.jsonObject(with: exercisesString.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableArray
            exercisesArray.add(exerciseDictionary)
            
            let jsonData: Data = try! JSONSerialization.data(withJSONObject: exercisesArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonString: String = String.init(data: jsonData, encoding: String.Encoding.utf8)!
            self.addExerciseToJSON(exerciseString: jsonString)

        }

        //Closing modal and refreshing tableview on parent view controller
        if let callback = self.onDoneBlock {
            callback ()
        }

    }


    func addExerciseToJSON (exerciseString: String) -> () {
        
        let filePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var fileAtPath = filePath.strings(byAppendingPaths: ["temp.json"])
        
        if (!FileManager.default.fileExists(atPath: fileAtPath[0])) {
            FileManager.default.createFile(atPath: fileAtPath[0], contents: nil, attributes: nil)
        }
        
        //write to file
        try! exerciseString.data(using: String.Encoding.utf8)?.write(to: URL(fileURLWithPath: fileAtPath[0]), options: Data.WritingOptions.atomic)
    }

    
    func readExercisesJSON() -> String {
        
        let filePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var fileAtPath = filePath.strings(byAppendingPaths: ["temp.json"])
        
        if (FileManager.default.fileExists(atPath: fileAtPath[0])) {
            
            let fileData = try! Data.init(contentsOf: URL.init(fileURLWithPath: fileAtPath[0]))
            return String.init(data: fileData, encoding: String.Encoding.utf8)!

        }else{
            return "empty"
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
