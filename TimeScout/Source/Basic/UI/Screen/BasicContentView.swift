//
//  BasicContentView.swift
//  TimeScout
//
//  Created by Matej on 30. 12. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutResources

struct BasicContentView: View {

    @EnvironmentObject private var appStateManager: AppStateManager
    private let pages: [OnboardingView.Page] = [
        .info(.init(
            image: Image("onboarding-1", bundle: .timeScoutResources),
            title: NSLocalizedString("onboarding_basic_page_1_title", bundle: .timeScoutLanguageResources, comment: ""),
            description: nil,
            subTitle: NSLocalizedString("onboarding_basic_page_1_message", bundle: .timeScoutLanguageResources, comment: ""),
            isLast: false
        )),
        .info(.init(
            image: Image("onboarding-2", bundle: .timeScoutResources),
            title: NSLocalizedString("onboarding_basic_page_2_title", bundle: .timeScoutLanguageResources, comment: ""),
            description: nil,
            subTitle: NSLocalizedString("onboarding_basic_page_2_message", bundle: .timeScoutLanguageResources, comment: ""),
            isLast: false
        )),
        .info(.init(
            image: Image("onboarding-3", bundle: .timeScoutResources),
            title: NSLocalizedString("onboarding_basic_page_3_title", bundle: .timeScoutLanguageResources, comment: ""),
            description: nil,
            subTitle: NSLocalizedString("onboarding_basic_page_3_message", bundle: .timeScoutLanguageResources, comment: ""),
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
