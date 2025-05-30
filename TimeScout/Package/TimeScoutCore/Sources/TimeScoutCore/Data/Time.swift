//
//  Time.swift
//  TimeScoutCore
//
//  Created by Matej on 8. 5. 25.
//

import Foundation

public struct Time {

    /// xx:00:00
    public let displayHours: Int
    /// 00:xx:00
    public let displayMinutes: Int
    /// 00:00:xx
    public let displaySeconds: Int

    /// Full duration in seconds
    public let totalElapsedSeconds: TimeInterval

    // MARK: - Init

    public init(seconds: TimeInterval) {
        self.displayHours = Int(seconds / 3600.0)
        self.displayMinutes = Int((seconds.truncatingRemainder(dividingBy: 3600)) / 60.0)
        self.displaySeconds = Int((seconds.truncatingRemainder(dividingBy: 3600)).truncatingRemainder(dividingBy: 60.0))
        self.totalElapsedSeconds = seconds
    }

    public init(fromDate: Date) {
        self.init(seconds: Date.now.timeIntervalSince(fromDate))
    }
}
