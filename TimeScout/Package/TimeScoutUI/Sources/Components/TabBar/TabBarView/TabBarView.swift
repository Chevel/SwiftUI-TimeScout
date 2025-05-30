//
//  TabBarView.swift
//  TimeScout
//
//  Created by Matej on 02/08/2022.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import EventKitUI
import TimeScoutCore

public struct TabBarView: View {
    
    public static let height: CGFloat = 100
    public static let offset: CGFloat = 45
    
    private var wasMainButtonPressed: Binding<Bool>
    private var selectedTab: Binding<TabBarButtonType>
    
    public init(wasMainButtonPressed: Binding<Bool>, selectedTab: Binding<TabBarButtonType>) {
        self.wasMainButtonPressed = wasMainButtonPressed
        self.selectedTab = selectedTab
    }

    public var body: some View {
        VStack {
            ZStack {
                TabBarShape()
                    .fill(Color.Pallete.primary)
                    .frame(height: Self.height)
                    .overlay(
                        Button {
                            wasMainButtonPressed.wrappedValue = true
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 85, height: 85)
                                    .foregroundColor(.Pallete.primary)
                                Image.SFSymbols.plus
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                            }
                        }.offset(x: 0, y: -45)
                    ).overlay(
                        HStack {
                            TabBarButtonView(type: TabBarButtonType.home, selectedTab: selectedTab)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer(minLength: 90)
                            TabBarButtonView(type: TabBarButtonType.list, selectedTab: selectedTab)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    )
            }
        }
    }
}
