//
//  Calendar+NumberOf.swift
//  TimeScout
//
//  Created by Matej on 14/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation

extension Calendar {

    func numberOf(unit: Component, between start: Date, and end: Date) -> Int {
        let fromDate = startOfDay(for: start)
        let toDate = startOfDay(for: end)
        let numberOfDays = dateComponents([unit], from: fromDate, to: toDate)

        return numberOfDays.day ?? 0
    }

}
