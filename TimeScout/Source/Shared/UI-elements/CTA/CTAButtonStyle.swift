//
//  BigActionButtonStyle.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct CTAButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 240, height: 50)
            .font(Font.Pallete.infoText)
            .foregroundColor(.white)
            .background(Color.Pallete.secondary)
            .clipShape(Capsule(style: .circular))
    }
    
}
