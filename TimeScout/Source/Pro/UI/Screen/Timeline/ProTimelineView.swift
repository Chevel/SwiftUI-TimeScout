//
//  ProTimelineView.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore
import TimeScoutData

struct ProTimelineView: Presentable {
    
    // MARK: - Presentable

    var screenType: ProAppStateManager.MainScreenType { .timeline }
    @EnvironmentObject var appStateManager: ProAppStateManager

    // MARK: - Private
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ProTimeActivity.creationDate, ascending: true)],
        animation: .easeInOut)
    private var items: FetchedResults<ProTimeActivity>
    
    @Environment(\.managedObjectContext)
    private var managedObjectContext
    
    @State
    private var isActivityDetailsOpen = false
    
    @State
    private var selectedItem: ProTimeActivity?
    
    // MARK: - View

    var body: some View {
        content
            .onAppear {
                notifyScreenChanged()
            }
            .background(.white)
            .navigationDestination(isPresented: $isActivityDetailsOpen) {
                if let selectedItem {
                    ProActivityDetails(item: selectedItem).hideNavigationView()
                }
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if items.isEmpty {
            if #available(iOS 17.0, *) {
                ContentUnavailableView(
                    "",
                    systemImage: "list.bullet",
                    description:
                        Text("general_no_data")
                        .font(UIDevice.current.isIpad ? .Pallete.Chart.centerTextIpad : .Pallete.Chart.centerText)
                        .bold()
                        .foregroundStyle(Color.Pallete.primary)
                )
            } else {
                Color.Pallete.Background.secondary.overlay {
                    VStack {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.Pallete.primary)
                        
                        Text("general_no_data")
                            .font(UIDevice.current.isIpad ? .Pallete.Chart.centerTextIpad : .Pallete.Chart.centerText)
                            .bold()
                            .foregroundStyle(Color.Pallete.primary)
                    }
                }
            }
        } else {
            ScrollView(.vertical, showsIndicators: false, content: {
                ScrollViewReader { scrollProxy in
                    LazyVStack(alignment: .center, spacing: 4, pinnedViews: [.sectionHeaders]) {
                        ForEach(formattedDaysOfActivities, id: \.self) { key in
                            if let activities = sections[key] {
                                buildSection(title: key, with: activities)
                            }
                        }
                    }.padding(.bottom, TabBarView.height + TabBarView.offset)
                }
            })
        }
    }
}

private extension ProTimelineView {

    static let rowHeight: CGFloat = 95
}

private extension ProTimelineView {
    
    // MARK: - Computed
    
    var allActivities: [ProTimeActivity] {
        return items.map { $0 }
    }
    
    // Returns an array where each item is a 1 day of activities formatted, sorted by most recent on top
    // Example:
    // Lets say we have the following [TimeActivity]:
    // 09:00 on Monday, 1.4.2023
    // 10:00 on Monday, 1.4.2023
    // 03:00 on Wednesday, 1.1.2023
    // 04:00 on Wednesday, 1.1.2023
    // 11:00 on Wednesday, 1.1.2023
    // 01:00 on Tuesday, 1.8.2023
    //
    // The result would be: ["Tuesday", "Monday", "Wednesday"]
    private var formattedDaysOfActivities: [String] {
        let allCategoryActivitiesAsTimeFormat = sections.values
            .reduce([], +) // flatten array
            .sorted {
                if let lhs = $0.creationDate, let rhs = $1.creationDate {
                    return lhs > rhs // sorted by most recent on top
                } else {
                    return true
                }
            }
            .map { DateFormatter.dayInWeekMonthYearFormatter.string(from: $0.creationDate ?? .now) } // convert to displayable format
        
        let orderedNoDuplicates = NSOrderedSet(array: allCategoryActivitiesAsTimeFormat).compactMap({ $0 as? String })

        return Array(orderedNoDuplicates)
    }

    private var sections: [String: [ProTimeActivity]] {
        Dictionary(grouping: items) {
            DateFormatter.dayInWeekMonthYearFormatter.string(from: $0.creationDate ?? .now)
        }
    }
    
    private func buildSection(title: String, with activities: [ProTimeActivity]) -> some View {
        Section(header: sectionHeader(leftText: title, rightText: String(format: "%d", activities.count))) {
            // rows
            ForEach(Array(sort(activites: activities).enumerated()), id: \.element.activityID) { index, timeEntry in
                row(for: timeEntry, isSeparatorHidden: index == activities.count - 1)
                    .frame(height: Self.rowHeight)
                    .padding(.horizontal, 8)
                    .onTapGesture {
                        var activityCategories: [String: String] = [:]
                        for category in timeEntry.categories {
                            activityCategories[category.name] = ""
                        }
                                
                        selectedItem = timeEntry
                        isActivityDetailsOpen = true
                    }
            }
        }
    }
    
    private func sort(activites: [ProTimeActivity]) -> [ProTimeActivity] {
        activites.sorted(by: {
            if let lhs = $0.creationDate, let rhs = $1.creationDate {
                return lhs > rhs
            } else {
                return true
            }
        })
    }
    
    private func row(for rowItem: ProTimeActivity, isSeparatorHidden: Bool) -> some View {
        guard let creationDate = rowItem.creationDate else { return AnyView(EmptyView()) }

        return AnyView(
            ProTimelineRow(
                activityName: rowItem.name,
                activityDurationSeconds: rowItem.durationSeconds,
                creationDate: creationDate,
                categories: rowItem.categories,
                swipeActionHandler: {
                    withAnimation(.easeIn(duration: AppSettings.Constants.AnimationSpeed.medium.rawValue)) {
                        delete(rowItem: rowItem)
                    }
                }
            )
        )
    }

    private func sectionHeader(leftText: String, rightText: String) -> some View {
        CategoryDetailsSectionView(
            leftText: leftText,
            rightText: rightText,
            backgroundColor: Color.Pallete.primary,
            textColor: .white
        ).frame(width: nil, height: 35, alignment: .leading)
    }
    
}

// MARK: - Core data

private extension ProTimelineView {
    
    private func delete(rowItem: ProTimeActivity) {
        managedObjectContext.delete(rowItem)
        do {
            try managedObjectContext.save()
        } catch {
            print("Error - Core Data 💾 - delete pro activity")
        }
    }
    
}

// MARK: - Preview

struct ProTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        ProTimelineView()
            .environmentObject(ProAppStateManager())
            .environmentObject( NavigationBarView.NavigationBarAccessible())
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)

    }
}
