//
//  ActivityDetailsView.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutUI
import TimeScoutCore
import TimeScoutData

struct CategoryDetailsView: View {
    
    // MARK: - Private

    @EnvironmentObject private var appStateManager: AppStateManager
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var managedObjectContext

    @State private var isActivityDetailsOpen = false
    @State private var selectedItem: TimeActivity?

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TimeActivity.timestamp, ascending: true)],
        animation: .easeInOut)
    private var items: FetchedResults<TimeActivity>
    
    // MARK: - Properties

    let category: TimeCategory
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationDestination(isPresented: $isActivityDetailsOpen) {
                    if let selectedItem {
                        EventDetailsView(item: selectedItem)
                    }
                }
        }
        .hideNavigationView()
    }
    
    private var contentView: some View {
        ZStack {
            Color.Pallete.primary.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                header
                    .frame(height: 160)
                    .padding(.top, 30)
                
                HorizontalSeparator()
                
                if sections.isEmpty {
                    VStack {
                        Spacer()
                        Text("general_no_data".translated())
                            .foregroundColor(.white)
                            .font(Font.Pallete.infoText)
                        Spacer()
                    }
                } else {
                    listView
                }
            }
            backArrowButton.padding(.all, 16)
        }
        .hideNavigationView()
    }
    
    // MARK: - UI

    private var backArrowButton: some View {
        VStack {
            HStack {
                Image.SFSymbols.backArrow
                    .font(Font.Pallete.icon)
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            Spacer()
        }
    }
    
    private var header: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text(category.name)
                        .font(Font.Pallete.headerTitle)
                        .foregroundColor(.white)
                        .padding(.all, 8)
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                headerSummary
                    .frame(width: geometry.size.width * 0.5)
                    .padding(.bottom, 8)
            }
        }
    }

    private var headerSummary: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("category_details_today".translated())
                    .font(Font.Pallete.headerDetails)
                    .foregroundColor(.white)
                Spacer()
                Text("\(todayCount)")
                    .font(Font.Pallete.headerDetails)
                    .foregroundColor(.white)
            }

            HStack {
                Text("category_details_month".translated())
                    .font(Font.Pallete.headerDetails)
                    .foregroundColor(.white)
                Spacer()
                Text("\(monthCount)")
                    .font(Font.Pallete.headerDetails)
                    .foregroundColor(.white)
            }

            HStack {
                Text("category_details_total".translated())
                    .font(Font.Pallete.headerDetails)
                    .foregroundColor(.white)
                Spacer()
                Text("\(totalCount)")
                    .font(Font.Pallete.headerDetails)
                    .foregroundColor(.white)
            }
        }
    }
    
    private var listView: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            ScrollViewReader { scrollProxy in
                LazyVStack(alignment: .center, spacing: 1, pinnedViews: [.sectionHeaders]) {
                    ForEach(formattedDaysOfActivities, id: \.self) { key in
                        if let activities = sections[key] {
                            buildSection(title: key, with: activities)
                        }
                    }
                }
            }
        })
    }

    private func buildSection(title: String, with activities: [TimeActivity]) -> some View {
        Section(header: sectionHeader(leftText: title, rightText: String(format: "%d", activities.count))) {
            // rows
            ForEach(Array(sort(activites: activities).enumerated()), id: \.element.activityID) { index, timeEntry in
                row(for: timeEntry, isSeparatorHidden: index == activities.count - 1)
            }
        }
    }
    
    private func sectionHeader(leftText: String, rightText: String) -> some View {
        CategoryDetailsSectionView(leftText: leftText, rightText: rightText)
            .frame(width: nil, height: 35, alignment: .leading)
    }
    
    private func row(for rowItem: TimeActivity, isSeparatorHidden: Bool) -> some View {
        guard let timestamp = rowItem.timestamp else { return AnyView(EmptyView()) }
        
        return AnyView(
            CategoryDetailsRowView(
                displayText: DateFormatter.timeOnlyDateFormatter.string(from: timestamp),
                isSeparatorHidden: isSeparatorHidden,
                swipeActionHandler: {
                    withAnimation(.easeIn(duration: AppSettings.Constants.AnimationSpeed.medium.rawValue)) {
                        delete(rowItem: rowItem)
                    }
                }, tapActionHandler: {
                    selectedItem = rowItem
                    isActivityDetailsOpen = true
                })
        )
    }
    
    // MARK: - Core data
    
    private func delete(rowItem: TimeActivity) {
        managedObjectContext.delete(rowItem)
        do {
            try managedObjectContext.save()
        } catch {
            print("Error - Core Data 💾 - delete time activity")
        }
    }
}

// MARK: - Computed

private extension CategoryDetailsView {
    
    private func sort(activites: [TimeActivity]) -> [TimeActivity] {
        activites
            .sorted(by: {
                if let lhs = $0.timestamp, let rhs = $1.timestamp {
                    return lhs > rhs
                } else {
                    return true
                }
            })
    }
    
    private var sections: [String: [TimeActivity]] {
        Dictionary(grouping: items.filter({ $0.relationship == category })) {
            if let date = $0.timestamp {
                return DateFormatter.dayInWeekMonthYearFormatter.string(from: date)
            } else {
                return ""
            }
        }
    }
    
    private var datesWithActivities: [Date: [TimeActivity]] {
        Dictionary(grouping: items.filter({ $0.relationship == category })) { $0.timestamp ?? Date() }
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
                if let lhs = $0.timestamp, let rhs = $1.timestamp {
                    return lhs > rhs // sorted by most recent on top
                } else {
                    return true
                }
            }
            .map { DateFormatter.dayInWeekMonthYearFormatter.string(from: $0.timestamp ?? Date()) } // convert to displayable format
        
        let orderedNoDuplicates = NSOrderedSet(array: allCategoryActivitiesAsTimeFormat).compactMap({ $0 as? String })

        return Array(orderedNoDuplicates)
    }

    private var totalCount: Int {
        formattedDaysOfActivities.map { sections[$0]?.count ?? 0 }.reduce(0, +)
    }
    
    private var todayCount: Int {
        items
            .filter({ $0.relationship == category })
            .compactMap({ $0.timestamp })
            .filter { $0.isTodayOnCalendar }
            .count
    }

    private var monthCount: Int {
        items
            .filter({ $0.relationship == category })
            .compactMap({ $0.timestamp })
            .filter { $0.isThisMonthOnCalendar }
            .count
    }
}

// MARK: - Preview

import CoreData.NSManagedObjectContext

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsView(category: TimeCategory.init(context: NSManagedObjectContext.init(.mainQueue)))
            .environmentObject(AppStateManager())
    }
}
