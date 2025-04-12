//
//  NSLocalized+Extension.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation

extension String {

    func translated() -> String {
        return NSLocalizedString(self, comment: "")
    }

}
