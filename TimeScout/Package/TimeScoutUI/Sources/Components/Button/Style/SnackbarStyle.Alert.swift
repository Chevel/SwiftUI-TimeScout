//
//  SnackbarStyle.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public struct SnackbarStyleAlert: ButtonStyle {
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 180, height: 50)
            .font(Font.Pallete.Button.big)
            .foregroundColor(Color.white)
            .background(Color.Pallete.alert)
            .clipShape(Capsule(style: .circular))
    }
}
