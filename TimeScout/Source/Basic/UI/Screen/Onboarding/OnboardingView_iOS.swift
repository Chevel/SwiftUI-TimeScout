//
//  OnboardingView.swift
//  TimeScout
//
//  Created by Matej on 22. 11. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

struct OnboardingView: View {

#if PRO
    @EnvironmentObject private var appStateManager: ProAppStateManager
#else
    @EnvironmentObject private var appStateManager: AppStateManager
#endif
    @State private var currentIndex = 0

    let pages: [OnboardingView.Page]

    // MARK: - UI

    var body: some View {
        contentView
    }
}

// MARK: - UI

private extension OnboardingView {

    @ViewBuilder
    var contentView: some View {
        TabView(selection: $currentIndex.animation()) {
            ForEach(0 ..< pages.count, id: \.self) { index in
                switch pages[index] {
                case .info(let data):
                    PageView(page: data)
                        .ignoresSafeArea(.all)
                        .tag(index)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.Pallete.Background.primary)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea(.all)
        .overlay {
            VStack(spacing: 24) {
                Spacer()
                Fancy3DotsIndexView(numberOfPages: pages.count, currentIndex: currentIndex)
                nextButton
            }.padding(.bottom, 24)
        }
    }
}

// MARK: - UI

private extension OnboardingView {
    
    var nextButton: some View {
        Button(action: {
            nextPage()
        }, label: {
            HStack {
                Spacer()
                Text("onboarding_button_continue")
                    .font(Font.Pallete.Button.medium)
                    .padding(.all, 16)
                    .foregroundColor(Color.white)
                Spacer()
            }
        }).buttonStyle(BigActionButtonStyle(color: Color.Pallete.secondary))
    }
}

// MARK: - Page Helper

private extension OnboardingView {
    
    func nextPage() {
        if isLastPage {
            withAnimation {
                switch AppSettings.target {
                case .basic: UserDefaults.standard.set(true, forKey: UserDefaults.TimeScoutKey.wasOnboardingShown.rawValue)
                case .pro: UserDefaults.standard.set(true, forKey: UserDefaults.TimeScoutProKey.wasOnboardingShown.rawValue)
                }
                
                appStateManager.currentScreen = .main
            }
            return
        }
        withAnimation {
            currentIndex += 1
        }
    }
    
    var isLastPage: Bool {
        currentIndex == pages.count-1
    }
}
