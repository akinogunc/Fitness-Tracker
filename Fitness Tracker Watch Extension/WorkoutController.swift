//
//  WorkoutController.swift
//  Fitness Tracker Watch Extension
//
//  Created by Maruf Nebil Ogunc on 12.10.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import HealthKit

class WorkoutController: WKInterfaceController, HKWorkoutSessionDelegate {

    @IBOutlet weak var timerLabel: WKInterfaceLabel!
    @IBOutlet weak var exerciseName: WKInterfaceLabel!
    @IBOutlet weak var cancelButton: WKInterfaceButton!
    @IBOutlet weak var startButton: WKInterfaceButton!
    @IBOutlet weak var doneButton: WKInterfaceButton!
    @IBOutlet weak var startGroup: WKInterfaceGroup!
    @IBOutlet weak var doneGroup: WKInterfaceGroup!

    var isTimerActive = false
    var seconds = 60
    var countdownTimer: Timer!
    var separatedExercisesArray: NSMutableArray = []
    var workoutDictionary: [String : AnyObject]!

    private let healthStore = HKHealthStore()
    private var workoutSession: HKWorkoutSession?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //Getting workout json and converting it to a NSMutableArray
        let arr = (context as! NSArray).mutableCopy() as! NSMutableArray
        
        //Getting workout info from array and removing it
        workoutDictionary = arr[0] as! Dictionary
        arr.removeObject(at: 0)
        
        //Separating exercises by each set and adding rest between them
        seperateExercisesBySetsAndRests(rawExercisesArray: arr)
        
        //initialize first exercise
        let indexOfObject = self.getIndexOfFirstUncompletedExercise()
        let separatedExerciseDict = separatedExercisesArray.object(at: indexOfObject) as! NSDictionary
        let duration = Int(separatedExerciseDict["duration"] as! String)!
        let minutes = duration/60
        let seconds = duration%60
        timerLabel.setText(String(format: "%d:%02d", minutes, seconds))
        exerciseName.setText(separatedExerciseDict["name"] as? String)

    }

    @IBAction func startAction(){
        
        if isTimerActive{
            countdownTimer.invalidate()
            isTimerActive = false
            startButton.setBackgroundImage(UIImage(named: "start.png"))
        }else{
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
            startButton.setBackgroundImage(UIImage(named: "pause.png"))
            isTimerActive = true
            startHKWorkout()
        }

    }

    func startHKWorkout() -> Void {
        
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .other
        
        do {
            workoutSession = try HKWorkoutSession(healthStore: healthStore, configuration: workoutConfiguration)
            workoutSession?.delegate = self
            workoutSession?.startActivity(with: Date())
        } catch {
            print(error)
        }
    }

    func getIndexOfFirstUncompletedExercise() -> Int {
        
        if(separatedExercisesArray.count == 0) {
            return -1
        }
        
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
            
            timerLabel.setText("00:00")
            exerciseName.setText("Completed")
            startGroup.setHidden(true)
            sendCompletedMessage()
            
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
            reloadCountdownLabel(index: indexOfObject)
            
        }else{
            
            WKInterfaceDevice.current().play(.notification)
            separatedExercisesArray.removeObject(at: indexOfObject)
            reloadCountdownLabel(index: indexOfObject)

        }
    }

    func sendCompletedMessage() -> Void {
        
        if WCSession.default.isReachable {
            let messageDict = ["message": "completed", "workout" : workoutDictionary] as [String : Any]
            
            WCSession.default.sendMessage(messageDict, replyHandler: { (replyDict) -> Void in
                
                if(replyDict["message"] as! String == "ok"){
                    self.doneGroup.setHidden(false)
                }
                
            }, errorHandler: { (error) -> Void in
                print(error)
            })
        }

    }
    
    func reloadCountdownLabel(index: Int) -> Void {
        
        if(separatedExercisesArray.count > 0){
            let separatedExerciseDict = separatedExercisesArray.object(at: index) as! NSDictionary
            let duration = Int(separatedExerciseDict["duration"] as! String)!
            let minutes = duration/60
            let seconds = duration%60
            timerLabel.setText(String(format: "%d:%02d", minutes, seconds))
            exerciseName.setText(separatedExerciseDict["name"] as? String)
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

    @IBAction func cancelAction(){
        endWorkout()
        self.dismiss()
    }

    @IBAction func doneAction(){
        endWorkout()
        self.dismiss()
    }
    
    func endWorkout() -> Void {
        countdownTimer?.invalidate()
        countdownTimer = nil
        workoutSession?.stopActivity(with: Date())
        workoutSession?.end()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {}
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didGenerate event: HKWorkoutEvent) {}
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date){}

}
