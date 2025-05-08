//
//  ProActivityCard.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore
import UIKit.UIImpactFeedbackGenerator

struct ProActivityCard: View {
    
    // MARK: - Properties

    @EnvironmentObject var appStateManager: ProAppStateManager
    
    // MARK: - Private
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var runningActivities: FetchedResults<ProTimeRunningActivity>
    @State private var timerString = Self.defaultTimestamp

    // MARK: - View

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 100)
            .overlay {
                VStack(spacing: 8) {
                    HStack {
                        Text("activity_card_title".translated())
                            .foregroundColor(.white)
                            .font(Font.Pallete.ProCard.title)
                        Spacer()
                        timerButton
                    }
                    HStack {
                        runningActivityView
                        Spacer()
                        displayedTimestamp
                    }
                }.padding(.all, 16)
            }
            .foregroundColor(Color.Pallete.primary)
    }
    
    // MARK: - UI
    
    private var displayedTimestamp: some View {
        Text(timerString)
            .onReceive(appStateManager.timer) { input in
                timerString = state.displayDuration
            }
            .foregroundColor(.white)
            .font(Font.Pallete.ProCard.subtitle)
    }

    private var runningActivityView: some View {
        Text(state.activityName)
            .foregroundColor(.white)
            .font(Font.Pallete.ProCard.subtitle)
    }
    
    private var timerButton: some View {
        Button {
            switch state {
            case .running:
                stop()

            case .off:
                appStateManager.isAddActivityShown = true
            }
        } label: {
            timerIcon.frame(width: 50, height: 50)
        }
    }
    
    private var timerIcon: some View {
        state.iconView
    }
    
    // MARK: - State

    private func stop() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        timerString = Self.defaultTimestamp
        appStateManager.stopTimer()
        storeRunningActivityDuration()
        deleteRunningActivity()
    }

}

// MARK: - Core data

private extension ProActivityCard {
    
    func storeRunningActivityDuration() {
        guard
            case let .running(activity) = state,
            let dbCategories = activity.relationship?.compactMap({ $0 as? ProTimeCategory })
        else { return }

        let newItem = ProTimeActivity(context: managedObjectContext)
        newItem.name = activity.name
        newItem.durationSeconds = Time(fromDate: activity.creationDate).totalElapsedSeconds
        newItem.creationDate = activity.creationDate
        newItem.activityID = UUID().uuidString
        newItem.relationship = NSSet(array: dbCategories)
        
        do {
            try managedObjectContext.save()
            appStateManager.isAddActivityShown = false
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            assertionFailure("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteRunningActivity() {
        runningActivities.forEach {
            managedObjectContext.delete($0)
        }
        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            assertionFailure("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

}

// MARK: - Computed

private extension ProActivityCard {
   
    static var defaultTimestamp: String { "00:00:00" }
    
}

// MARK: - State

private extension ProActivityCard {

    private var state: ActivityState {
        guard let runningActivity = runningActivities.first else { return .off }
        return .running(activity: runningActivity)
    }

    private enum ActivityState {
        case running(activity: ProTimeRunningActivity)
        case off

        var isActive: Bool {
            switch self {
            case .running: return true
            case .off: return false
            }
        }

        var displayDuration: String {
            switch self {
            case .running(let activity): return Time(fromDate: activity.creationDate).displayString
            case .off: return ProActivityCard.defaultTimestamp
            }
        }
        
        var activityName: String {
            switch self {
            case .running(let activity): return activity.name
            case .off: return "activity_card_subtitle_empty".translated()
            }
        }
        
        var iconView: some View {
            switch self {
            case .running:
                return Image.SFSymbols.Timer.stop
                    .scaledToFit()
                    .foregroundColor(.white)
                    .font(Font.Pallete.icon)
            case .off:
                return Image.SFSymbols.Button.circle
                    .scaledToFit()
                    .foregroundColor(.white)
                    .font(Font.Pallete.icon)
            }
        }
    }
    
}
    
// MARK: - Style

extension Font.Pallete {
    
    enum ProCard {
        static let title = Font.system(size: 21, weight: .bold)
        static let subtitle = Font.system(size: 16, weight: .semibold)
    }
    
}

// MARK: - Preview

struct ProActivityCard_Previews: PreviewProvider {
    static var previews: some View {
        ProActivityCard()
            .environmentObject(ProAppStateManager())
    }
}
