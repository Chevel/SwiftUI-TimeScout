//
//  ListRowView.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct ListRowView: View {
    
    @EnvironmentObject private var appStateManager: AppStateManager

    var displayText: String
    var isRightArrowVisible: Bool = false

    var body: some View {
        HStack {
            Text(displayText)
                .foregroundColor(.white)
                .font(Font.Pallete.infoText)
                .multilineTextAlignment(.leading)
            Spacer()
            if isRightArrowVisible {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .font(Font.Pallete.infoText)
                    .frame(width: 7)
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - Preview

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Pallete.primary
            ListRowView(displayText: "test")
        }
    }
}
