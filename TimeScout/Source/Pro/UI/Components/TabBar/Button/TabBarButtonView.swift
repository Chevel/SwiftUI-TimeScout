//
//  TabBarButtonView.swift
//  TimeScout
//
//  Created by Matej on 02/08/2022.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct TabBarButtonView: View {

    // MARK: - Properties

    var type: TabBarButtonType
    @EnvironmentObject var appStateManager: ProAppStateManager

    private var isSelected: Bool {
        appStateManager.selectedTab == type
    }

    // MARK: - View

    var body: some View {
        Button(action: {
            appStateManager.selectedTab = type
        }, label: {
            type.image.resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(isSelected ? Color.Pallete.secondary : Color.white)
        }).frame(width: 40, height: 40)
    }

}

// MARK: - Preview

struct TabBarButtonView_Previews: PreviewProvider {

    static var previews: some View {
        TabBarButtonView(type: TabBarButtonType.home)
            .environmentObject(ProAppStateManager())
            .background(Color.Pallete.primary)
    }

}
