//
//  Time.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import TimeScoutCore

extension Time {
    
    // MARK: - UI

    static func sumTime(from activities: [ProTimeActivity]) -> Time {
        let numberOfSeconds = activities.compactMap({ $0.durationSeconds }).reduce(0, +)
        return Time(seconds: numberOfSeconds)
    }

    static func sumHours(from activities: [ProTimeActivity]) -> Int {
        let numberOfSeconds = activities.compactMap({ $0.durationSeconds }).reduce(0, +)
        return Time(seconds: numberOfSeconds).displayHours
    }

    static func todayHours(from activities: [ProTimeActivity]) -> Float {
        let sumOfSeconds = activities
            .filter {
                guard let date = $0.creationDate else { return false }
                return Calendar.current.isDateInToday(date) }
            .compactMap({ $0.durationSeconds })
            .reduce(0, +)
        
        return Float(sumOfSeconds / 3600)
    }
    
    static func dailyHours(from activities: [ProTimeActivity]) -> Float {
        hours(for: .day, from: activities)
    }

    static func weeklyHours(from activities: [ProTimeActivity]) -> Float {
        hours(for: .weekday, from: activities)
    }

    /// Number of hours in comparisson to other categories
    /// Example:
    /// health = 3h
    /// emotion = 3h
    /// everything else = 0h
    /// health.score = 50%
    /// emotion.score = 50%
    /// everything else = 0%
    static func score(categoryActivities: [ProTimeActivity], allActivities: [ProTimeActivity]) -> Float {
        let categorySeconds = Time(seconds: categoryActivities.compactMap({ $0.durationSeconds }).reduce(0, +)).totalElapsedSeconds
        let allSeconds = Time(seconds: allActivities.compactMap({ $0.durationSeconds }).reduce(0, +)).totalElapsedSeconds

        guard allSeconds != 0 else {
            return 0
        }
        return Float(categorySeconds/allSeconds) * 100
    }

    // MARK: - Helper

    private static func hours(for component: Calendar.Component, from activities: [ProTimeActivity]) -> Float {
        let sortedDates = activities.sorted(by: {
            if let lhs = $0.creationDate, let rhs = $1.creationDate {
                return lhs < rhs
            } else {
                return true
            }
        })
        guard let first = sortedDates.first?.creationDate, let last = sortedDates.last?.creationDate else {
            return 0
        }
        let numberOfUnits = Float(Calendar.current.numberOf(unit: component, between: first, and: last))
        let numberOfSeconds = Float(activities
            .compactMap({ $0.durationSeconds })
            .reduce(0, +))

        guard numberOfUnits > 0 else {
            if Calendar.current.isDate(first, inSameDayAs: last) {
                return Float(numberOfSeconds / 1 / 3600)
            }
            return 0
        }
        return Float(numberOfSeconds / numberOfUnits / 3600)
    }

}


