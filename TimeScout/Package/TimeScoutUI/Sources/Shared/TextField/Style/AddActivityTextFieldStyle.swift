//
//  AddActivityTextFieldStyle.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public struct AddActivityTextFieldStyle: TextFieldStyle {
    
    public init(){}

    // Hidden function to conform to this protocol
    public func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(Color.white)
                .frame(height: 40)
                .background(Color.white)
            
            HStack {
                configuration
            }
            .padding(.leading)
            .foregroundColor(.gray)
        }
    }
}
