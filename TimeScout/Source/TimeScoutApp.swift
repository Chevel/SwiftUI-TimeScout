//
//  TimeScoutApp.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutUI
import TimeScoutCore
import TimeScoutData

@main
struct TimeScoutApp: App {

    // MARK: - State

    @StateObject private var appStateManager = AppStateManager()
    @StateObject private var proAppStateManager = ProAppStateManager()
    
    // MARK: - Core data

    private let persistenceController = PersistenceController()
    @Environment(\.scenePhase) private var scenePhase

    // MARK: - View

    var body: some Scene {
        WindowGroup {
            mainView
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _, _ in
            let context = persistenceController.container.viewContext
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print("Error - Core Data 💾 - save")
                }
            }
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

        case .pro:
            ProContentView()
                .environmentObject(proAppStateManager)
        }
    }
}
