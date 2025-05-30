//
//  SnackbarStyle.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public struct SnackbarStyleInfo: ButtonStyle {
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 140, height: 50)
            .font(Font.Pallete.snackbar)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.white)
            .background(Color.Pallete.secondary)
            .clipShape(Capsule(style: .circular))
    }
}
