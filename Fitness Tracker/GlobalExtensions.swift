//
//  Global.swift
//  Fitness Tracker
//
//  Created by Maruf Nebil Ogunc on 22.12.2018.
//  Copyright © 2018 Maruf Nebil Ogunc. All rights reserved.
//

import Foundation

extension Date{
    func dateToString() -> String{
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withFullDate]
        return f.string(from: self)
    }
}

extension String{
    func stringToDate() -> Date{
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withFullDate]
        return f.date(from: self)!
    }
}
