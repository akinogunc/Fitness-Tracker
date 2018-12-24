//
//  WorkoutSaver.swift
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 28.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit
import xRadioButton

public protocol WorkoutSaverDelegate{
    func saveCompleted()
}

class WorkoutSaver: UIViewController, UITextFieldDelegate {

    public var delegate: WorkoutSaverDelegate?
    let screenRect = UIScreen.main.bounds
    let green = UIColor.init(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
    let orange = UIColor.init(red: 229.0/255.0, green: 93.0/255.0, blue: 41.0/255.0, alpha: 1)
    var workoutNameTextField: UITextField!
    var chestRadioButton: xRadioButton!
    var backRadioButton: xRadioButton!
    var legsRadioButton: xRadioButton!
    var bicepsRadioButton: xRadioButton!
    var tricepsRadioButton: xRadioButton!
    var absRadioButton: xRadioButton!
    var shouldersRadioButton: xRadioButton!
    var restLabel: UILabel!
    var restDownButton: UIButton!
    var restUpButton: UIButton!
    var restSeconds = 45;
    var exercisesArray: NSMutableArray!
    let jsonManager = JSONManager()
    var workoutDict: NSDictionary?
    
    init(exercisesArray: NSMutableArray?, workoutDict: NSDictionary?) {
        self.exercisesArray = exercisesArray
        self.workoutDict = workoutDict
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        //Name your workout label
        let workoutName = UILabel(frame: CGRect(x: 20, y: 10, width: screenRect.size.width - 80, height: 30))
        workoutName.textColor = UIColor.black
        workoutName.backgroundColor = UIColor.clear
        workoutName.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        workoutName.text = "Name your workout";
        workoutName.numberOfLines = 1;
        workoutName.textAlignment = NSTextAlignment.center;
        self.view.addSubview(workoutName)

        //Workout name text field
        workoutNameTextField = UITextField(frame: CGRect(x: 20, y: 50, width: screenRect.size.width - 80, height: 30))
        workoutNameTextField.borderStyle = UITextBorderStyle.roundedRect
        workoutNameTextField.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        workoutNameTextField.placeholder = "Chest&Biceps"
        workoutNameTextField.autocorrectionType = UITextAutocorrectionType.no
        workoutNameTextField.keyboardType = UIKeyboardType.default
        workoutNameTextField.returnKeyType = UIReturnKeyType.done
        workoutNameTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        workoutNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        workoutNameTextField.delegate = self
        self.view.addSubview(workoutNameTextField)

        //Choose worked muscle groups label
        let chooseBodyParts = UILabel(frame: CGRect(x: 20, y: 90, width: screenRect.size.width - 80, height: 30))
        chooseBodyParts.textColor = UIColor.black
        chooseBodyParts.backgroundColor = UIColor.clear
        chooseBodyParts.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        chooseBodyParts.text = "Choose worked muscle groups";
        chooseBodyParts.numberOfLines = 1;
        chooseBodyParts.textAlignment = NSTextAlignment.center;
        self.view.addSubview(chooseBodyParts)

        let radioButtonWidth = (screenRect.size.width - 100)/3
        
        //body part radio buttons
        chestRadioButton = xRadioButton(title: "Chest", frame: CGRect(x: 20, y: 130, width: radioButtonWidth, height: 30), font: UIFont(name: "Metropolis-Medium", size: 14.0)!, color: green)
        self.view.addSubview(chestRadioButton)
        
        backRadioButton = xRadioButton(title: "Back", frame: CGRect(x: 30 + radioButtonWidth, y: 130, width: radioButtonWidth, height: 30), font: UIFont(name: "Metropolis-Medium", size: 14.0)!, color: green)
        self.view.addSubview(backRadioButton)

        legsRadioButton = xRadioButton(title: "Legs", frame: CGRect(x: 40 + radioButtonWidth*2, y: 130, width: radioButtonWidth, height: 30), font: UIFont(name: "Metropolis-Medium", size: 14.0)!, color: green)
        self.view.addSubview(legsRadioButton)

        
        bicepsRadioButton = xRadioButton(title: "Biceps", frame: CGRect(x: 20, y: 180, width: radioButtonWidth, height: 30), font: UIFont(name: "Metropolis-Medium", size: 14.0)!, color: green)
        self.view.addSubview(bicepsRadioButton)
        
        tricepsRadioButton = xRadioButton(title: "Triceps", frame: CGRect(x: 30 + radioButtonWidth, y: 180, width: radioButtonWidth, height: 30), font: UIFont(name: "Metropolis-Medium", size: 14.0)!, color: green)
        self.view.addSubview(tricepsRadioButton)
        
        absRadioButton = xRadioButton(title: "Abs", frame: CGRect(x: 40 + radioButtonWidth*2, y: 180, width: radioButtonWidth, height: 30), font: UIFont(name: "Metropolis-Medium", size: 14.0)!, color: green)
        self.view.addSubview(absRadioButton)

        
        shouldersRadioButton = xRadioButton(title: "Shoulders", frame: CGRect(x: 30 + radioButtonWidth, y: 230, width: radioButtonWidth, height: 30), font: UIFont(name: "Metropolis-Medium", size: 14.0)!, color: green)
        self.view.addSubview(shouldersRadioButton)

        
        //Rest between sets label
        let restBetweenSets = UILabel(frame: CGRect(x: 20, y: 290, width: screenRect.size.width - 80, height: 30))
        restBetweenSets.textColor = UIColor.black
        restBetweenSets.backgroundColor = UIColor.clear
        restBetweenSets.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        restBetweenSets.text = "Rest between sets";
        restBetweenSets.numberOfLines = 1;
        restBetweenSets.textAlignment = NSTextAlignment.center;
        self.view.addSubview(restBetweenSets)

        //Rest UI setup
        restLabel = UILabel(frame: CGRect(x: 80, y: 325, width: screenRect.size.width - 200, height: 30))
        restLabel.textColor = UIColor.black
        restLabel.backgroundColor = UIColor.clear
        restLabel.font = UIFont(name: "Metropolis-Medium", size: 15.0)
        restLabel.text = "45 Seconds";
        restLabel.numberOfLines = 0;
        restLabel.textAlignment = NSTextAlignment.center;
        self.view.addSubview(restLabel)
        
        restDownButton = UIButton(type: UIButtonType.custom)
        restDownButton.setImage(UIImage(named: "down"), for: UIControlState.normal)
        restDownButton.frame = CGRect(x: 20, y: 325, width: 30, height: 30)
        restDownButton.addTarget(self, action: #selector(self.decreaseRest), for: UIControlEvents.touchUpInside)
        self.view.addSubview(restDownButton)
        
        restUpButton = UIButton(type: UIButtonType.custom)
        restUpButton.setImage(UIImage(named: "up"), for: UIControlState.normal)
        restUpButton.frame = CGRect(x: screenRect.size.width - 90, y: 325, width: 30, height: 30)
        restUpButton.addTarget(self, action: #selector(self.increaseRest), for: UIControlEvents.touchUpInside)
        self.view.addSubview(restUpButton)

        //Cancel and save buttons UI
        let bottomButtonsWidth = (screenRect.size.width - 100)/2
        
        //This button will save the workout
        let saveWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
        saveWorkoutButton.setTitle("Save Workout", for: UIControlState.normal)
        saveWorkoutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        saveWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        saveWorkoutButton.titleLabel?.textAlignment = NSTextAlignment.center
        saveWorkoutButton.backgroundColor = green
        saveWorkoutButton.frame = CGRect(x: 40 + bottomButtonsWidth, y: 385, width: bottomButtonsWidth, height: 45)
        saveWorkoutButton.addTarget(self, action: #selector(self.saveWorkout), for: UIControlEvents.touchUpInside)
        self.view.addSubview(saveWorkoutButton)

        //This button will dismiss the popup
        let cancelButton:UIButton = UIButton(type: UIButtonType.custom)
        cancelButton.setTitle("Cancel", for: UIControlState.normal)
        cancelButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        cancelButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        cancelButton.titleLabel?.textAlignment = NSTextAlignment.center
        cancelButton.backgroundColor = orange
        cancelButton.frame = CGRect(x: 20, y: 385, width: bottomButtonsWidth, height: 45)
        cancelButton.addTarget(self, action: #selector(self.dismissPopup), for: UIControlEvents.touchUpInside)
        self.view.addSubview(cancelButton)

        if (workoutDict != nil){
            setInitialValues()
        }
    }

    //workoutDictionary =  ["name" : workoutNameTextField.text!, "muscle_groups" : self.createMuscleGroupsArray(), "rest" : restSeconds]

    //edit workout
    func setInitialValues(){
        
        var muscles = workoutDict!["muscle_groups"] as! [String]
        
        for i in 0..<muscles.count{
            if(muscles[i] == "chest"){chestRadioButton.sendActions(for: .touchUpInside)}
            if(muscles[i] == "back"){backRadioButton.sendActions(for: .touchUpInside)}
            if(muscles[i] == "legs"){legsRadioButton.sendActions(for: .touchUpInside)}
            if(muscles[i] == "biceps"){bicepsRadioButton.sendActions(for: .touchUpInside)}
            if(muscles[i] == "triceps"){tricepsRadioButton.sendActions(for: .touchUpInside)}
            if(muscles[i] == "abs"){absRadioButton.sendActions(for: .touchUpInside)}
            if(muscles[i] == "shoulders"){shouldersRadioButton.sendActions(for: .touchUpInside)}
        }

        workoutNameTextField.text = workoutDict!["name"] as? String
        restSeconds = workoutDict!["rest"] as! Int
        setRestTextWithFormat(restSeconds: restSeconds)
    }
    
    @objc func saveWorkout() -> Void {
        
        if (workoutNameTextField.text == "") {
            
            let alertController = UIAlertController(title: "Workout name can not be empty", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)

        }else if(chestRadioButton.isSelected == false && backRadioButton.isSelected == false && legsRadioButton.isSelected == false &&
            bicepsRadioButton.isSelected == false && tricepsRadioButton.isSelected == false && absRadioButton.isSelected == false &&
            shouldersRadioButton.isSelected == false){
            
            let alertController = UIAlertController(title: "Choose at least one muscle group", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)

        }else{
            
            //Delete if a file exists with same name
            jsonManager.deleteJSONByName(name: workoutNameTextField.text!)
            
            //Save workout to json file
            jsonManager.saveArrayToJSONByName(array: exercisesArray, name: workoutNameTextField.text!)

            //Creating a dictionary from the exercise values
            var workoutDictionary: NSDictionary!
            workoutDictionary =  ["name" : workoutNameTextField.text!, "muscle_groups" : self.createMuscleGroupsArray(), "rest" : restSeconds]

            //Saving workout name to workouts list
            jsonManager.addNewWorkoutToList(dict: workoutDictionary)

            self.dismiss(animated: true) {
                self.delegate?.saveCompleted()
            }

        }
        
    }
    
    func createMuscleGroupsArray() -> [String] {
        
        var result = [String]()
        
        if(chestRadioButton.isSelected){result.append("chest")}
        if(backRadioButton.isSelected){result.append("back")}
        if(legsRadioButton.isSelected){result.append("legs")}
        if(bicepsRadioButton.isSelected){result.append("biceps")}
        if(tricepsRadioButton.isSelected){result.append("triceps")}
        if(absRadioButton.isSelected){result.append("abs")}
        if(shouldersRadioButton.isSelected){result.append("shoulders")}
        
        return result
    }
    
    @objc func decreaseRest () -> (){
        if(restSeconds>15){
            restSeconds -= 15
            setRestTextWithFormat(restSeconds: restSeconds)
        }
    }
    
    @objc func increaseRest () -> (){
        restSeconds += 15
        setRestTextWithFormat(restSeconds: restSeconds)
    }

    func setRestTextWithFormat(restSeconds: Int){
        
        let minutes = restSeconds/60
        let seconds = restSeconds%60
        
        if(minutes>0){
            if(seconds>0){
                restLabel.text = String(format: "%d Min %02d Secs", minutes, seconds)
            }else{
                restLabel.text = String(format: "%d Min", minutes)
            }
        }else{
            restLabel.text = String(format: "%d Seconds", restSeconds)
        }

    }
    
    @objc func dismissPopup() -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
