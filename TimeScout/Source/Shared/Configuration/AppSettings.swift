//
//  AppSettings.swift
//  TimeScout
//
//  Created by Matej on 30. 5. 25.
//

import Foundation
import TimeScoutCore

extension AppSettings {
    
    static var environment: Environment {
#if DEV
        return .dev
#else
        return .prod
#endif
    }
    
    public enum Environment {
        case dev, prod
        
        public static var isDev: Bool {
            return environment == .dev
        }
    }
    
    public static var target: Version {
#if PRO
        return .pro
#else
        return .basic
#endif
    }
    
    public enum Version {
        case basic, pro
    }
}

// MARK: - Constants

public extension AppSettings {
    
    enum Constants {
        
        public static var appStoreURL: URL {
            switch AppSettings.target {
            case .basic: return URL(string: "https://apps.apple.com/us/app/timescout/id1584949806")!
            case .pro: return URL(string: "https://apps.apple.com/us/app/timescoutpro/id1584951815")!
            }
        }
    }
}
