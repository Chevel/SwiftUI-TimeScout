//
//  File.swift
//  TimeScoutUI
//
//  Created by Matej on 8. 5. 25.
//

import Foundation
import TimeScoutCore

public extension Time {

    /// HH:MM:SS AM/PM
    var displayString: String {
        return String(format:"%02i:%02i:%02i", displayHours, displayMinutes, displaySeconds)
    }
}
