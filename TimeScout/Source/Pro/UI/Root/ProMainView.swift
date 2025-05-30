//
//  ProHome.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutUI
import TimeScoutData

struct ProMainView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appStateManager: ProAppStateManager
    @State private var selectedCategory: ProCategory? {
        didSet {
            if selectedCategory != nil {
                appStateManager.isCategoryDetailsShown = true
            }
        }
    }
    @State private var firstTimePaywallAppear = false

    // MARK: - View

    var body: some View {
        NavigationStack {
            ZStack {
                contentView
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("TIMESCOUTPRO")
                                .font(Font.Pallete.headerDetails)
                                .foregroundStyle(Color.Pallete.Foreground.primary)
                        }
                    }
                    .toolbarBackground(Color.Pallete.primary, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarTitleDisplayMode(.inline)
                VStack {
                    Spacer()
                    TabBarView() {
                        appStateManager.isAddActivityShown = true
                    }
                    .shadow(color: .black.opacity(0.3), radius: 3, y: -5)
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
            .ignoresSafeArea(.keyboard)
            .background(Color.Pallete.primary.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $appStateManager.isAddActivityShown) {
                ProAddActivity()
            }
            .sheet(isPresented: $appStateManager.isCategoryDetailsShown) {
                if let selectedCategory {
                    ProCategoryDetails(category: selectedCategory)
                }
            }
        }
    }
    
    // MARK: - UI
    
    private var contentView: some View {
        switch appStateManager.selectedTab {
        case .home: return AnyView(ProHomeView() { selectedCategory = $0 })
        case .list: return AnyView(ProTimelineView())
        }
    }
}

// MARK: - Preview

struct ProMainView_Previews: PreviewProvider {

    static var previews: some View {
        ProMainView()
            .environmentObject(ProAppStateManager())
    }
}
