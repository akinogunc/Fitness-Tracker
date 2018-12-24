//
//  ExerciseCell.swift
//  Fitness Tracker
//
//  Created by AKIN on 16.08.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {

    var exerciseLabel: UILabel!
    var setsLabel: UILabel!
    var repsLabel: UILabel!
    var restLabel: UILabel!
    var isCardio: Bool!

    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, isCardio: Bool) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //Getting size of the device
        let screenRect = UIScreen.main.bounds
        
        if (isCardio) {//UI of cardio exercise
        
            exerciseLabel = UILabel(frame: CGRect(x: 10, y: 0, width: screenRect.size.width/2 - 10, height: 70))
            exerciseLabel.textColor = UIColor.black
            exerciseLabel.backgroundColor = UIColor.clear
            exerciseLabel.font = UIFont(name: "Metropolis-Medium", size: 16.0)
            exerciseLabel.numberOfLines = 2
            self.addSubview(exerciseLabel)

            restLabel = UILabel(frame: CGRect(x: screenRect.size.width/2, y: 10, width: screenRect.size.width/2 - 10, height: 25))
            restLabel.textColor = UIColor.black
            restLabel.backgroundColor = UIColor.clear
            restLabel.font = UIFont(name: "Metropolis-Bold", size: 20.0)
            restLabel.textAlignment = NSTextAlignment.center;
            self.addSubview(restLabel)

            let restStaticLabel = UILabel(frame: CGRect(x: screenRect.size.width/2, y: 35, width: screenRect.size.width/2 - 10, height: 25))
            restStaticLabel.textColor = UIColor.black
            restStaticLabel.backgroundColor = UIColor.clear
            restStaticLabel.font = UIFont(name: "Metropolis-Medium", size: 12.0)
            restStaticLabel.text = "minutes";
            restStaticLabel.textAlignment = NSTextAlignment.center;
            self.addSubview(restStaticLabel)

        }else{//UI of the weights exercise
            
            exerciseLabel = UILabel(frame: CGRect(x: 10, y: 0, width: screenRect.size.width/2 - 10, height: 70))
            exerciseLabel.textColor = UIColor.black
            exerciseLabel.backgroundColor = UIColor.clear
            exerciseLabel.font = UIFont(name: "Metropolis-Medium", size: 16.0)
            exerciseLabel.numberOfLines = 2
            self.addSubview(exerciseLabel)

            setsLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 - 10, y: 10, width: screenRect.size.width/6, height: 25))
            setsLabel.textColor = UIColor.black
            setsLabel.backgroundColor = UIColor.clear
            setsLabel.font = UIFont(name: "Metropolis-Bold", size: 20.0)
            setsLabel.textAlignment = NSTextAlignment.center;
            self.addSubview(setsLabel)
            
            let setsStaticLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 - 10, y: 35, width: screenRect.size.width/6, height: 25))
            setsStaticLabel.textColor = UIColor.black
            setsStaticLabel.backgroundColor = UIColor.clear
            setsStaticLabel.font = UIFont(name: "Metropolis-Medium", size: 12.0)
            setsStaticLabel.text = "sets";
            setsStaticLabel.textAlignment = NSTextAlignment.center;
            self.addSubview(setsStaticLabel)

            let splitLine = UIView(frame: CGRect(x: screenRect.size.width/2 + screenRect.size.width/6 - 10, y: 10, width: 1, height: 50))
            splitLine.backgroundColor = UIColor.black
            splitLine.alpha = 0.4
            self.addSubview(splitLine)
            
            repsLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 + screenRect.size.width/6 - 10, y: 10, width: screenRect.size.width/6, height: 25))
            repsLabel.textColor = UIColor.black
            repsLabel.backgroundColor = UIColor.clear
            repsLabel.font = UIFont(name: "Metropolis-Bold", size: 20.0)
            repsLabel.textAlignment = NSTextAlignment.center;
            self.addSubview(repsLabel)
            
            let repsStaticLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 + screenRect.size.width/6 - 10, y: 35, width: screenRect.size.width/6, height: 25))
            repsStaticLabel.textColor = UIColor.black
            repsStaticLabel.backgroundColor = UIColor.clear
            repsStaticLabel.font = UIFont(name: "Metropolis-Medium", size: 12.0)
            repsStaticLabel.text = "reps";
            repsStaticLabel.textAlignment = NSTextAlignment.center;
            self.addSubview(repsStaticLabel)
            
            let splitLine2 = UIView(frame: CGRect(x: screenRect.size.width/2 + 2*screenRect.size.width/6 - 10, y: 10, width: 1, height: 50))
            splitLine2.backgroundColor = UIColor.black
            splitLine2.alpha = 0.4
            self.addSubview(splitLine2)

            restLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 + 2*screenRect.size.width/6 - 10, y: 10, width: screenRect.size.width/6, height: 25))
            restLabel.textColor = UIColor.black
            restLabel.backgroundColor = UIColor.clear
            restLabel.font = UIFont(name: "Metropolis-Bold", size: 20.0)
            restLabel.textAlignment = NSTextAlignment.center;
            self.addSubview(restLabel)
            
            let restStaticLabel = UILabel(frame: CGRect(x: screenRect.size.width/2 + 2*screenRect.size.width/6 - 10, y: 35, width: screenRect.size.width/6, height: 25))
            restStaticLabel.textColor = UIColor.black
            restStaticLabel.backgroundColor = UIColor.clear
            restStaticLabel.font = UIFont(name: "Metropolis-Medium", size: 12.0)
            restStaticLabel.text = "duration";
            restStaticLabel.textAlignment = NSTextAlignment.center;
            self.addSubview(restStaticLabel)

        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
