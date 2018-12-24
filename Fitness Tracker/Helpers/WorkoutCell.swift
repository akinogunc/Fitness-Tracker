//
//  WorkoutCell.swift
//  Fitness Tracker
//
//  Created by AKIN on 16.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {

    var workoutLabel: UILabel!
    var startWorkoutButton: UIButton!
    var workoutDuration: UILabel!
    var muscleGroupsLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //Getting size of the device
        let screenRect = UIScreen.main.bounds

        //Label of the exercise name
        workoutLabel = UILabel(frame: CGRect(x: 10, y: 10, width: screenRect.size.width/2 - 10, height: 25))
        workoutLabel.textColor = UIColor.black
        workoutLabel.backgroundColor = UIColor.clear
        workoutLabel.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        workoutLabel.numberOfLines = 1
        self.addSubview(workoutLabel)
        
        //Label of the minutes of workout duration
        muscleGroupsLabel = UILabel(frame: CGRect(x: 10, y: 35, width: screenRect.size.width/2 - 10, height: 25))
        muscleGroupsLabel.textColor = UIColor.black
        muscleGroupsLabel.backgroundColor = UIColor.clear
        muscleGroupsLabel.font = UIFont(name: "Metropolis-Medium", size: 14.0)
        muscleGroupsLabel.textAlignment = NSTextAlignment.left;
        muscleGroupsLabel.numberOfLines = 1
        self.addSubview(muscleGroupsLabel)

        //Label of the minutes of workout duration
        workoutDuration = UILabel(frame: CGRect(x: screenRect.size.width/2, y: 10, width: screenRect.size.width/4, height: 25))
        workoutDuration.textColor = UIColor.black
        workoutDuration.backgroundColor = UIColor.clear
        workoutDuration.font = UIFont(name: "Metropolis-Bold", size: 20.0)
        workoutDuration.textAlignment = NSTextAlignment.center;
        self.addSubview(workoutDuration)

        let restStaticLabel = UILabel(frame: CGRect(x: screenRect.size.width/2, y: 35, width: screenRect.size.width/4, height: 25))
        restStaticLabel.textColor = UIColor.black
        restStaticLabel.backgroundColor = UIColor.clear
        restStaticLabel.font = UIFont(name: "Metropolis-Medium", size: 12.0)
        restStaticLabel.text = "minutes";
        restStaticLabel.textAlignment = NSTextAlignment.center;
        self.addSubview(restStaticLabel)

        //This button will save the workout
        startWorkoutButton = UIButton(type: UIButton.ButtonType.custom)
        startWorkoutButton.setTitle("Start", for: UIControl.State.normal)
        startWorkoutButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        startWorkoutButton.titleLabel?.font = UIFont(name: "Metropolis-Medium", size: 18.0)
        startWorkoutButton.titleLabel?.textAlignment = NSTextAlignment.center
        startWorkoutButton.backgroundColor = UIColor.init(red: 0, green: 179.0/255.0, blue: 85.0/255.0, alpha: 1)
        startWorkoutButton.frame = CGRect(x: 3*screenRect.size.width/4, y: 10, width: screenRect.size.width/4 - 10, height: 50)
        self.addSubview(startWorkoutButton)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
