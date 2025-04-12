//
//  CategoryDetailsSectionView.swift
//  TimeScout
//
//  Created by Matej on 05/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct CategoryDetailsSectionView: View {
    
    let leftText: String
    let rightText: String
    var backgroundColor: Color = .white
    var textColor: Color = Color.Pallete.primary
    
    var body: some View {
        Rectangle()
            .overlay(
                HStack {
                    Text(leftText)
                        .font(Font.Pallete.infoText)
                        .foregroundColor(textColor)
                    Spacer()
                    Text(rightText)
                        .font(Font.Pallete.infoText)
                        .foregroundColor(textColor)
                }.padding(.horizontal, 8)
            )
            .foregroundColor(backgroundColor)
    }
}

// MARK: - Preview

struct CategoryDetailsSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Pallete.primary
            ListSectionTitle(leftText: "test", rightText: "5")
        }
        
    }
}
