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
    var backgroundUpdateTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
    let jsonManager = JSONManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        application.isIdleTimerDisabled = true
        
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }

        return true
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        let mesaj = message["message"] as! String
        
        if (mesaj == "send_workout_list"){
            
            let workoutsArray = jsonManager.readJSONbyName(name: "workouts")
            replyHandler(["message": workoutsArray])
            
        }else if(mesaj.range(of:"send_workout") != nil){
            
            let stringArray = mesaj.components(separatedBy: " ")
            let workoutArray = jsonManager.readJSONbyName(name: stringArray[1])
            replyHandler(["message": workoutArray])

        }else if(mesaj == "completed"){
            
            let workoutDictionary = message["workout"] as! [String : Any]
            jsonManager.saveCompletedWorkout(dict: workoutDictionary as NSDictionary)
            replyHandler(["message": "ok"])

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
    
    func applicationDidEnterBackground(_ application: UIApplication) {}
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.endBackgroundUpdateTask()
    }
    
    func endBackgroundUpdateTask() {
        UIApplication.shared.endBackgroundTask(self.backgroundUpdateTask)
        self.backgroundUpdateTask = UIBackgroundTaskIdentifier.invalid
    }

    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
    
    
}
