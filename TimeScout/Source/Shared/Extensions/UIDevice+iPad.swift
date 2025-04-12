//
//  UIDevice+iPad.swift
//  TimeScout
//
//  Created by Matej on 30. 12. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import UIKit

extension UIDevice {

    var isIpad: Bool {
        userInterfaceIdiom == .pad
    }
}
