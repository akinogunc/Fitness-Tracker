//
//  SeparatedExerciseCell.swift
//  Fitness Tracker
//
//  Created by AKIN on 16.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class SeparatedExerciseCell: UITableViewCell {

    var countdownLabel: UILabel!
    var exerciseNameLabel: UILabel!
    var repsLabel: UILabel!
    var repsStaticLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Getting size of the device
        let screenRect = UIScreen.main.bounds
        
        countdownLabel = UILabel(frame: CGRect(x: 10, y: 0, width: screenRect.size.width/5 - 10, height: 70))
        countdownLabel.textColor = UIColor.black
        countdownLabel.backgroundColor = UIColor.clear
        countdownLabel.font = UIFont(name: "Metropolis-Bold", size: 16.0)
        countdownLabel.numberOfLines = 1
        self.addSubview(countdownLabel)
        
        exerciseNameLabel = UILabel(frame: CGRect(x: screenRect.size.width/5, y: 0, width: 3*screenRect.size.width/5, height: 70))
        exerciseNameLabel.textColor = UIColor.black
        exerciseNameLabel.backgroundColor = UIColor.clear
        exerciseNameLabel.font = UIFont(name: "Metropolis-Medium", size: 20.0)
        exerciseNameLabel.textAlignment = NSTextAlignment.left;
        exerciseNameLabel.numberOfLines = 2
        self.addSubview(exerciseNameLabel)
        
        repsLabel = UILabel(frame: CGRect(x: 4*screenRect.size.width/5, y: 10, width: screenRect.size.width/5, height: 25))
        repsLabel.textColor = UIColor.black
        repsLabel.backgroundColor = UIColor.clear
        repsLabel.font = UIFont(name: "Metropolis-Bold", size: 20.0)
        repsLabel.textAlignment = NSTextAlignment.center;
        self.addSubview(repsLabel)

        repsStaticLabel = UILabel(frame: CGRect(x: 4*screenRect.size.width/5, y: 35, width: screenRect.size.width/5, height: 25))
        repsStaticLabel.textColor = UIColor.black
        repsStaticLabel.backgroundColor = UIColor.clear
        repsStaticLabel.font = UIFont(name: "Metropolis-Medium", size: 12.0)
        repsStaticLabel.text = "reps"
        repsStaticLabel.textAlignment = NSTextAlignment.center;
        self.addSubview(repsStaticLabel)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
