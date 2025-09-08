//
//  MainButtonStyle.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

extension MainButton {
    
    struct MainButtonStyle: ButtonStyle {
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration
                .label
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
        }
    }
}
