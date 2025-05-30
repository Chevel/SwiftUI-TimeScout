//
//  TimeScoutApp.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

@main
struct TimeScoutApp: App {

    // MARK: - State

    @StateObject private var appStateManager = AppStateManager()
    @StateObject private var proAppStateManager = ProAppStateManager()
    @StateObject private var navigationBar = NavigationBarView.NavigationBarAccessible()
    
    // MARK: - Core data

    private let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) private var scenePhase

    // MARK: - View

    var body: some Scene {
        WindowGroup {
            mainView
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
    
    @ViewBuilder
    private var mainView: some View {
        switch AppSettings.target {
        case .basic:
            BasicContentView()
                .environmentObject(appStateManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)

        case .pro:
            ProContentView()
                .environmentObject(proAppStateManager)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(navigationBar)
        }
    }
}
