//
//  BigActionButtonStyle.swift
//  TimeScout
//
//  Created by Matej on 13. 12. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public struct BigActionButtonStyle: ButtonStyle {
    
    public let color: Color
    
    public init(color: Color) {
        self.color = color
    }
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 240, height: 50)
            .font(Font.Pallete.Button.medium)
            .foregroundColor(color)
            .background(configuration.isPressed ? Color.Pallete.secondary : color)
            .clipShape(Capsule(style: .circular))
    }
}
