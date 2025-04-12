//
//  UpsellButtonStyle.swift
//  TimeScout
//
//  Created by Matej on 2. 12. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct UpsellButton: View {

    var title: String
    var action: EmptyClosure

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                Text(title)
                    .font(Font.Pallete.paywallText)
                    .padding(.all, 4)
                    .foregroundColor(Color.Pallete.Foreground.primary)
                Spacer()
            }
            .frame(height: 60)
        }
        .buttonStyle(UpsellButtonStyle())
    }
}

fileprivate struct UpsellButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.Pallete.paywallText)
            .foregroundColor(Color.Pallete.Foreground.primary)
            .background(Color.Pallete.secondary)
            .clipShape(Capsule(style: .circular))       
    }
}
