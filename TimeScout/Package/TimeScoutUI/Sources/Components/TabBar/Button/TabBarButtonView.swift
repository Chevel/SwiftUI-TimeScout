//
//  TabBarButtonView.swift
//  TimeScout
//
//  Created by Matej on 02/08/2022.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

public struct TabBarButtonView: View {

    // MARK: - Properties

    private var type: TabBarButtonType
    private var selectedTab: Binding<TabBarButtonType>
    
    public init(type: TabBarButtonType, selectedTab: Binding<TabBarButtonType>) {
        self.type = type
        self.selectedTab = selectedTab
    }

    // MARK: - View

    public var body: some View {
        Button(action: {
            selectedTab.wrappedValue = type
        }, label: {
            type.image.resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(isSelected ? Color.Pallete.secondary : Color.white)
        }).frame(width: 40, height: 40)
    }
}

// MARK: - Computed

private extension TabBarButtonView {
    
    var isSelected: Bool {
        selectedTab.wrappedValue == type
    }
}

// MARK: - Preview

struct TabBarButtonView_Previews: PreviewProvider {

    static var previews: some View {
        TabBarButtonView(type: TabBarButtonType.home, selectedTab: .constant(.home))
            .background(Color.Pallete.primary)
    }
}
