//
//  AppDelegate.swift
//  Fitness Tracker
//
//  Created by AKIN on 15.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//
import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {
    
    var window: UIWindow?
    var backgroundUpdateTask: UIBackgroundTaskIdentifier = 0
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        application.isIdleTimerDisabled = true
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }

        return true
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        if (message["message"] as! String == "send_workout_list"){
            
            var workoutsArray = NSMutableArray()
            
            if let savedWorkoutsObject = UserDefaults.standard.object(forKey: "savedWorkouts") as? NSArray{
                workoutsArray = savedWorkoutsObject.mutableCopy() as! NSMutableArray
            }

            replyHandler(["message": workoutsArray])
            
        }else if((message["message"] as! NSString).pathExtension == "json"){
            
            let workoutArray = readWorkoutJSONbyName(name: message["message"] as! String)
            replyHandler(["message": workoutArray])

        }else if(message["message"] as! String == "completed"){
            
            let workoutDictionary = message["workout"] as! [String : Any]
            saveCompletedWorkout(workoutDictionary: workoutDictionary)
            replyHandler(["message": "ok"])

        }
        
    }
    
    func saveCompletedWorkout(workoutDictionary: [String : Any]) -> Void {
        
        var completedWorkoutsArray = NSMutableArray()
        
        //getting completed workouts array from user defaults
        if let savedWorkoutsObject = UserDefaults.standard.object(forKey: "completedWorkouts") as? NSArray{
            completedWorkoutsArray = savedWorkoutsObject.mutableCopy() as! NSMutableArray
        }
        
        let completedWorkoutDict = NSMutableDictionary()
        let workoutNameWithoutExtension = (workoutDictionary["name"] as! NSString).deletingPathExtension

        completedWorkoutDict["name"] = workoutNameWithoutExtension
        completedWorkoutDict["muscle_groups"] = workoutDictionary["muscle_groups"]
        completedWorkoutDict["date"] = Date()
        
        //Adding the completed workout to array
        completedWorkoutsArray.add(completedWorkoutDict)
        
        UserDefaults.standard.set(completedWorkoutsArray, forKey: "completedWorkouts")
        UserDefaults.standard.synchronize()
        
    }

    func readWorkoutJSONbyName(name: String) -> NSMutableArray {
        
        let filePath = NSString(string: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        var fileAtPath = filePath.strings(byAppendingPaths: [name])
        
        if (FileManager.default.fileExists(atPath: fileAtPath[0])) {
            
            let fileData = try! Data.init(contentsOf: URL.init(fileURLWithPath: fileAtPath[0]))
            let jsonObject = try! JSONSerialization.jsonObject(with: fileData, options: JSONSerialization.ReadingOptions.mutableContainers)
            let rawExercisesArray = jsonObject as! NSMutableArray
            return rawExercisesArray
        }else{
            print("File don't exist")
            return NSMutableArray()
        }
        
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }
    
    func sessionDidBecomeInactive(_ session: WCSession) { }
    
    func sessionDidDeactivate(_ session: WCSession) { }

    func applicationWillResignActive(_ application: UIApplication) {
        self.backgroundUpdateTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            self.endBackgroundUpdateTask()
        })
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.endBackgroundUpdateTask()
    }
    
    func endBackgroundUpdateTask() {
        UIApplication.shared.endBackgroundTask(self.backgroundUpdateTask)
        self.backgroundUpdateTask = UIBackgroundTaskInvalid
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}
