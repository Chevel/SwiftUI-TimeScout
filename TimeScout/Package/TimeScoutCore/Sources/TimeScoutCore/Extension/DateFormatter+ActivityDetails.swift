//
//  DateFormatter+ActivityDetails.swift
//  TimeScout
//
//  Created by Matej on 03/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation

public extension DateFormatter {

    /// 3:00:12 PM
    static let timeOnlyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeStyle = .medium
        return formatter
    }()

    /// Wednesday, July 10, 2021
    static let dayInWeekMonthYearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EEEE, MMM dd, YYYY"
        return formatter
    }()
}
