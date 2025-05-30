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

struct TabBarView: View {
    
    static let height: CGFloat = 100
    static let offset: CGFloat = 45
    
    @EnvironmentObject var appStateManager: ProAppStateManager
    var mainButtonPressedHandler: EmptyClosure

    var body: some View {
        VStack {
            ZStack {
                TabBarShape()
                    .fill(Color.Pallete.primary)
                    .frame(height: Self.height)
                    .overlay(
                        Button {
                            appStateManager.isAddActivityShown = true
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
                            TabBarButtonView(type: TabBarButtonType.home)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer(minLength: 90)
                            TabBarButtonView(type: TabBarButtonType.list)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    )
            }
        }
    }

}

// MARK: - Preview

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            TabBarView() {
                print("")
            }
        }
        .previewDevice("iPhone 12")
        .environmentObject(ProAppStateManager())
        
        VStack {
            Spacer()
            TabBarView() {
                print("")
            }
        }
        .previewDevice("iPhone SE (2nd generation)")
        .environmentObject(ProAppStateManager())
    }
}
