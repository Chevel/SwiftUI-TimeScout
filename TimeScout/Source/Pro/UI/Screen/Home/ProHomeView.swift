//
//  ProHomeView.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutUI
import TimeScoutData

struct ProHomeView: Presentable {
    
    // MARK: - Presentable

    var screenType: ProAppStateManager.MainScreenType { .home }
    @EnvironmentObject var appStateManager: ProAppStateManager

    // MARK: - Properties
    
    var didSelectCategory: ((ProCategory) -> Void)?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                ProActivityCard()
                ProCategoryChart().frame(minHeight: 250)
                ProCategoryGrid(showsCategoryData: true, didSelectCategory: {
                    didSelectCategory?($0)
                }).frame(minHeight: 450)
            }
            .padding(.top, 8)
            .padding(.bottom, TabBarView.height + TabBarView.offset)
        }
        .padding(.horizontal, 8)
        .background(Color.white)
        .onAppear {
            notifyScreenChanged()
        }
    }
}

// MARK: - Preview

struct ProHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ProHomeView()
            .environmentObject(ProAppStateManager())
    }
}
