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
    func saveCompleted(workoutName : String)
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

        //Name your workout label
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

        let bottomButtonsWidth = (screenRect.size.width - 100)/2
        
        //This button will save the workout
        let saveWorkoutButton:UIButton = UIButton(type: UIButtonType.custom)
        saveWorkoutButton.setTitle("Save Workout", for: UIControlState.normal)
        saveWorkoutButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        saveWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        saveWorkoutButton.titleLabel?.textAlignment = NSTextAlignment.center
        saveWorkoutButton.backgroundColor = green
        saveWorkoutButton.frame = CGRect(x: 40 + bottomButtonsWidth, y: 285, width: bottomButtonsWidth, height: 45)
        saveWorkoutButton.addTarget(self, action: #selector(self.saveWorkout), for: UIControlEvents.touchUpInside)
        self.view.addSubview(saveWorkoutButton)

        //This button will dismiss the popup
        let cancelButton:UIButton = UIButton(type: UIButtonType.custom)
        cancelButton.setTitle("Cancel", for: UIControlState.normal)
        cancelButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        cancelButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        cancelButton.titleLabel?.textAlignment = NSTextAlignment.center
        cancelButton.backgroundColor = orange
        cancelButton.frame = CGRect(x: 20, y: 285, width: bottomButtonsWidth, height: 45)
        cancelButton.addTarget(self, action: #selector(self.dismissPopup), for: UIControlEvents.touchUpInside)
        self.view.addSubview(cancelButton)

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
            
            var savedWorkouts: NSMutableArray!
            
            //Getting workouts array
            if let savedWorkoutsObject = UserDefaults.standard.object(forKey: "savedWorkouts") as? NSArray{
                savedWorkouts = savedWorkoutsObject.mutableCopy() as? NSMutableArray
            }else{
                savedWorkouts = NSMutableArray()
            }
            
            //Creating a dictionary from the exercise values
            var workoutDictionary: NSDictionary!
            workoutDictionary =  ["name" : workoutNameTextField.text! + ".json", "muscle_groups" : self.createMuscleGroupsArray()]

            //Adding name of the workout to array
            savedWorkouts?.add(workoutDictionary)
            
            UserDefaults.standard.set(savedWorkouts, forKey: "savedWorkouts")
            UserDefaults.standard.synchronize()

            self.dismiss(animated: true) {
                self.delegate?.saveCompleted(workoutName: self.workoutNameTextField.text!)
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
