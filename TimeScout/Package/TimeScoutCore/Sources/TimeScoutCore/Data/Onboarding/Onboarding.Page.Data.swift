//
//  Data.swift
//  TimeScout
//
//  Created by Matej on 29. 11. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public enum Onboarding {}

public extension Onboarding.Page {

    struct Data {
        public let image: Image
        public let title: String
        public let description: [String]?
        public let subTitle: String?
        public let isLast: Bool
        
        public init(image: Image, title: String, description: [String]?, subTitle: String?, isLast: Bool) {
            self.image = image
            self.title = title
            self.description = description
            self.subTitle = subTitle
            self.isLast = isLast
        }
    }
}
