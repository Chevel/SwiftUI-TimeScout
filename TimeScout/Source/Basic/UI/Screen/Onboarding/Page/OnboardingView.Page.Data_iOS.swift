//
//  Data.swift
//  TimeScout
//
//  Created by Matej on 29. 11. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

extension OnboardingView.Page {

    struct Data {
        let image: Image
        let title: String
        let description: [String]?
        let subTitle: String?
        let isLast: Bool
    }
}
