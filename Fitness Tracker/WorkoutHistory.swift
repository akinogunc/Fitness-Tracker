//
//  WorkoutHistory.swift
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 17.10.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import UIKit

class WorkoutHistory: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var workoutsTableView: UITableView!
    var completedWorkoutsArray = NSMutableArray()
    let screenRect = UIScreen.main.bounds
    let jsonManager = JSONManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        //Customizing navigation bar
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Metropolis-Bold", size: 20)!]
        self.navigationItem.title = "History"

        //Creating table view which will show workouts
        workoutsTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height))
        workoutsTableView.backgroundColor = UIColor.white
        workoutsTableView.delegate = self
        workoutsTableView.dataSource = self
        self.view.addSubview(workoutsTableView)
        
        
        //getting completed workouts array from json
        completedWorkoutsArray = jsonManager.readJSONbyName(name: "history")

        //reverse array for showing last completed workout at first
        completedWorkoutsArray = NSMutableArray(array: completedWorkoutsArray.reversed())
        
        //refreshing table view
        workoutsTableView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedWorkoutsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "workoutHistoryCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WorkoutHistoryCell
        if(cell == nil){
            cell = WorkoutHistoryCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none

        //Setting exercise values from json array
        let completedWorkoutDict = completedWorkoutsArray.object(at: indexPath.row) as! NSDictionary
        
        //converting muscle groups array to a single string
        let muscleGroupsAsString = (completedWorkoutDict["muscle_groups"] as! Array).joined(separator: ",")
        
        let att = [NSAttributedString.Key.font : UIFont(name: "Metropolis-Bold", size: 14.0)]
        let boldString = NSMutableAttributedString(string:"Muscles: ", attributes: att as [NSAttributedString.Key : Any])
        let att2 = [NSAttributedString.Key.font : UIFont(name: "Metropolis-Medium", size: 14.0)]
        let normalString = NSMutableAttributedString(string:muscleGroupsAsString, attributes:att2 as [NSAttributedString.Key : Any])
        boldString.append(normalString)
        
        //convert string to date in the json
        let dateString = completedWorkoutDict["date"] as! String
        
        //Formatting the date
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM d")//Oct 7
        let dateFormatter2 = DateFormatter()
        dateFormatter2.setLocalizedDateFormatFromTemplate("EEE")//Wed
        
        //Setting the labels on the cell
        cell?.workoutNameLabel.text = (completedWorkoutDict["name"] as! String)
        cell?.muscleGroupsLabel.attributedText = boldString
        cell?.dateLabel.text = dateFormatter.string(from: dateString.stringToDate())
        cell?.dayLabel.text = dateFormatter2.string(from: dateString.stringToDate())

        return cell!
    }


}
