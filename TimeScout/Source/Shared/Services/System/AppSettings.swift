//
//  AppSettings.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation

enum AppSettings {
    
    static var environment: Environment {
        #if DEV
        return .dev
        #else
        return .prod
        #endif
    }
    enum Environment {
        case dev, prod
        
        static var isDev: Bool {
            return environment == .dev
        }
    }
    
    static var target: Version {
        #if PRO
        return .pro
        #else
        return .basic
        #endif
    }

    enum Version {
        case basic, pro
    }

    enum Constants {
        
        static var appStoreURL: URL {
            switch AppSettings.target {
            case .basic: return URL(string: "https://apps.apple.com/us/app/timescout/id1584949806")!
            case .pro: return URL(string: "https://apps.apple.com/us/app/timescoutpro/id1584951815")!
            }
        }

        static var alphabetCharacters: [String] {
            guard let alphabetCharacterSet = Locale.current.exemplarCharacterSet?.intersection(CharacterSet.lowercaseLetters) else {
                return []
            }
            
            let characters = alphabetCharacterSet
                .characters()
                .sorted(by: { String($0).localizedCompare(String($1)) == .orderedAscending })
                .map { String($0).uppercased() }

            // This covers 2/3 of languages
            // see: https://wordfinderx.com/blog/languages-ranked-by-letters-in-alphabet/
            guard characters.count < 46 else {
                return []
            }
            return characters
        }
        
        static let activityCountLimit: Int = 1
        static let sectionCountLimit: Int = 3
        
        enum AnimationSpeet: CGFloat {
            case slow = 1
            case medium = 0.2
            case fast = 0.1
        }
    }
}
