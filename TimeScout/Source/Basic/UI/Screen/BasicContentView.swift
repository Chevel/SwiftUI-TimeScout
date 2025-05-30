//
//  BasicContentView.swift
//  TimeScout
//
//  Created by Matej on 30. 12. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

struct BasicContentView: View {

    @EnvironmentObject private var appStateManager: AppStateManager

    private let pages: [Onboarding.Page] = [
        .info(.init(
            image: Image("onboarding-1"),
            title: NSLocalizedString("onboarding_basic_page_1_title", comment: ""),
            description: nil,
            subTitle: NSLocalizedString("onboarding_basic_page_1_message", comment: ""),
            isLast: false
        )),
        .info(.init(
            image: Image("onboarding-2"),
            title: NSLocalizedString("onboarding_basic_page_2_title", comment: ""),
            description: nil,
            subTitle: NSLocalizedString("onboarding_basic_page_2_message", comment: ""),
            isLast: false
        )),
        .info(.init(
            image: Image("onboarding-3"),
            title: NSLocalizedString("onboarding_basic_page_3_title", comment: ""),
            description: nil,
            subTitle: NSLocalizedString("onboarding_basic_page_3_message", comment: ""),
            isLast: true
        ))
    ]

    var body: some View {
        switch appStateManager.currentScreen {
        case .onboarding:
            OnboardingView(pages: pages)

        case .main:
            HomeView()
        }
    }
}

#Preview {
    BasicContentView()
        .environmentObject(AppStateManager())
}
