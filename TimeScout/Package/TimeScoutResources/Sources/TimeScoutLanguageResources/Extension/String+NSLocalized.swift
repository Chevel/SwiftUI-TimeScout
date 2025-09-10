//
//  File.swift
//  TimeScoutResources
//
//  Created by Matej on 10. 9. 25.
//

import Foundation

public extension String {

    func translated() -> String {
        return NSLocalizedString(self, bundle: .module, comment: "")
    }
}
