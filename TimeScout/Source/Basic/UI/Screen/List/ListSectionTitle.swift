//
//  ListSectionTitle.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct ListSectionTitle: View {
    
    let leftText: String
    let rightText: String
    
    var body: some View {
        Rectangle()
            .overlay(
                HStack {
                    Text(leftText)
                        .font(Font.Pallete.infoText)
                        .foregroundColor(Color.Pallete.primary)
                    Spacer()
                    Text(rightText)
                        .font(Font.Pallete.infoText)
                        .foregroundColor(Color.Pallete.primary)
                }
            )
    }
}

// MARK: - Preview

struct ListSectionTitle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Pallete.primary
            ListSectionTitle(leftText: "test", rightText: "5")
        }
        
    }
}
