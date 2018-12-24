//
//  WorkoutHistoryCell.swift
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 17.10.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class WorkoutHistoryCell: UITableViewCell {

    var workoutNameLabel: UILabel!
    var muscleGroupsLabel: UILabel!
    var dateLabel: UILabel!
    var dayLabel: UILabel!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Getting size of the device
        let screenRect = UIScreen.main.bounds
        
        //Label of the exercise name
        workoutNameLabel = UILabel(frame: CGRect(x: 10, y: 10, width: screenRect.size.width*0.7, height: 25))
        workoutNameLabel.textColor = UIColor.black
        workoutNameLabel.backgroundColor = UIColor.clear
        workoutNameLabel.font = UIFont(name: "Metropolis-Medium", size: 20.0)
        workoutNameLabel.numberOfLines = 1
        workoutNameLabel.textAlignment = NSTextAlignment.left;
        self.addSubview(workoutNameLabel)
        
        //Label of the minutes of workout duration
        muscleGroupsLabel = UILabel(frame: CGRect(x: 10, y: 35, width: screenRect.size.width*0.7, height: 25))
        muscleGroupsLabel.textColor = UIColor.black
        muscleGroupsLabel.backgroundColor = UIColor.clear
        muscleGroupsLabel.font = UIFont(name: "Metropolis-Medium", size: 14.0)
        muscleGroupsLabel.textAlignment = NSTextAlignment.left;
        muscleGroupsLabel.numberOfLines = 1
        self.addSubview(muscleGroupsLabel)
        
        let splitLine = UIView(frame: CGRect(x: screenRect.size.width*0.7, y: 10, width: 1, height: 50))
        splitLine.backgroundColor = UIColor.black
        splitLine.alpha = 0.4
        self.addSubview(splitLine)

        //date of the workout
        dateLabel = UILabel(frame: CGRect(x: screenRect.size.width*0.7, y: 10, width: screenRect.size.width*0.3, height: 25))
        dateLabel.textColor = UIColor.black
        dateLabel.backgroundColor = UIColor.clear
        dateLabel.font = UIFont(name: "Metropolis-Bold", size: 18.0)
        dateLabel.textAlignment = NSTextAlignment.center;
        dateLabel.numberOfLines = 1
        self.addSubview(dateLabel)

        //day of the workout
        dayLabel = UILabel(frame: CGRect(x: screenRect.size.width*0.7, y: 35, width: screenRect.size.width*0.3, height: 25))
        dayLabel.textColor = UIColor.black
        dayLabel.backgroundColor = UIColor.clear
        dayLabel.font = UIFont(name: "Metropolis-Medium", size: 16.0)
        dayLabel.textAlignment = NSTextAlignment.center;
        dayLabel.numberOfLines = 1
        self.addSubview(dayLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
