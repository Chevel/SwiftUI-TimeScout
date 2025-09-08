//
//  NavigationBarView.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutUI
import TimeScoutCore

struct NavigationBarView: View {

    // MARK: - Properties

    var title: String?
    var color: Color = .clear
    @EnvironmentObject var appStateManager: ProAppStateManager
    var leftButtonAction: EmptyClosure?

    // MARK: - View

    var body: some View {
        ZStack {
            HStack {
                Image.SFSymbols.backArrow
                    .font(Font.Pallete.icon)
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        leftButtonAction?()
                    }
                    .disabled(!appStateManager.isDetailsPushed)
                    .opacity(appStateManager.isDetailsPushed ? 1 : 0)
                HStack {
                    Spacer()
                    if let title {
                        Text(title)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(Font.Pallete.infoText)
                    }
                    Spacer()
                }
                ShareView(linkURL: AppSettings.Constants.appStoreURL)
            }.padding(.horizontal, 8)
        }.frame(height: Self.height)
    }
    
}

extension NavigationBarView {
    
    final class NavigationBarAccessible: ObservableObject {
        @Published var view: NavigationBarView = NavigationBarView(title: "TIMESCOUTPRO", color: .Pallete.primary)
    }
    
}

extension NavigationBarView {
    
    static var height: CGFloat = 60

}

// MARK: - Preview

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(color: .red)
            .environmentObject(ProAppStateManager())
    }
}
