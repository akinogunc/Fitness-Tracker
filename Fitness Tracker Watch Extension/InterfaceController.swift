//
//  InterfaceController.swift
//  Fitness Tracker Watch Extension
//
//  Created by Maruf Nebil Ogunc on 4.10.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet weak var workoutsTable: WKInterfaceTable!
    @IBOutlet weak var loadingLabel: WKInterfaceLabel!
    var workoutsArray: NSMutableArray!
    var isActivated = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }

    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        if isActivated{
            getWorkoutList()
        }

    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        isActivated = true
        getWorkoutList()
    }
    
    func getWorkoutList() -> Void {
        
        if WCSession.default.isReachable {
            let messageDict = ["message": "send_workout_list"]
            
            WCSession.default.sendMessage(messageDict, replyHandler: { (replyDict) -> Void in
                self.workoutsArray = ((replyDict["message"] as! NSArray).mutableCopy() as! NSMutableArray)
                self.workoutsTable.setHidden(false)
                self.loadingLabel.setHidden(true)
                self.loadTableData()
            }, errorHandler: { (error) -> Void in
                print(error)
            })
        }

    }
    
    private func loadTableData(){

        workoutsTable.setNumberOfRows(workoutsArray.count, withRowType: "WorkoutRow")
        
        for i in 0..<workoutsArray.count{
            
            guard let row = workoutsTable.rowController(at: i) as? WorkoutRowController else {
                print("failed")
                return
                
            }

            let dict = workoutsArray[i] as! NSDictionary
            let workoutName = dict["name"] as! String
            row.workoutName.setText(workoutName)

        }
        
    }

    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {

        let dict = workoutsArray[rowIndex] as! NSDictionary
        let workoutName = dict["name"] as! String
        let messageDict = ["message": "send_workout " + workoutName]

        WCSession.default.sendMessage(messageDict, replyHandler: { (replyDict) -> Void in
            
            let arr = (replyDict["message"] as! NSArray).mutableCopy() as! NSMutableArray
            arr.insert(dict, at: 0)
            
            self.presentController(withName: "workout", context: arr)
            
        }, errorHandler: { (error) -> Void in
            print(error)
        })


    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

