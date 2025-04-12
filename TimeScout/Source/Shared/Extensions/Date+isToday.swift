//
//  Date+isToday.swift
//  TimeScout
//
//  Created by Matej on 05/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation

extension Date {
    
    var isTodayOnCalendar: Bool {
        let dateToCheck = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        return (
            dateToCheck.year == currentDate.year &&
            dateToCheck.month == currentDate.month &&
            dateToCheck.day == currentDate.day
        )
    }
    
    var isThisMonthOnCalendar: Bool {
        let dateToCheck = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        return dateToCheck.year == currentDate.year && dateToCheck.month == currentDate.month
    }

}
