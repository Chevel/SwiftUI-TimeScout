//
//  ScreenType.swift
//  TimeScoutUI
//
//  Created by Matej on 30. 5. 25.
//

public enum ScreenType: Identifiable, Hashable {
    case onboarding
    case main

    public var id: String {
        switch self {
        case .onboarding: return "onboarding"
        case .main: return "main"
        }
    }
}
