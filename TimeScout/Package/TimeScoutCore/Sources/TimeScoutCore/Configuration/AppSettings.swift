//
//  AppSettings.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation

public enum AppSettings {

    public enum Constants {

        public static var alphabetCharacters: [String] {
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
        
        public static let activityCountLimit: Int = 1
        public static let sectionCountLimit: Int = 3
        
        public enum AnimationSpeed: CGFloat {
            case slow = 1
            case medium = 0.2
            case fast = 0.1
        }
    }
}
