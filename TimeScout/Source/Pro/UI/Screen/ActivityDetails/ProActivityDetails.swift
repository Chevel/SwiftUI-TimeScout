//
//  ProActivityDetails.swift
//  TimeScout
//
//  Created by Matej on 16/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

struct ProActivityDetails: Presentable {

    // MARK: - Presentable
    
    var screenType: ProAppStateManager.MainScreenType { .activityDetails }
    @EnvironmentObject var appStateManager: ProAppStateManager

    // MARK: - Properties

    @ObservedObject var item: ProTimeActivity
    @EnvironmentObject private var navigationBar: NavigationBarView.NavigationBarAccessible

    @State private var updatedCategorySelection = [ProCategory: Bool]()
    @State private var editableDate = Date.now
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    
    @State private var existingNavTitle = ""
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.dismiss) private var dismiss

    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            header
            HorizontalSeparator()
            content
        }
        .overlay {
            backArrowButton.padding(16)
        }
        .background(Color.Pallete.primary.edgesIgnoringSafeArea(.all))
        .onAppear {
            hours = Time(seconds: item.durationSeconds).displayHours
            minutes = Time(seconds: item.durationSeconds).displayMinutes
            seconds = Time(seconds: item.durationSeconds).displaySeconds
            
            notifyScreenChanged()
            navigationBar.view.leftButtonAction = {
                dismiss()
            }
            editableDate = item.creationDate ?? .now
            
            existingNavTitle = navigationBar.view.title ?? ""
            navigationBar.view.title = item.name
        }
        .onDisappear {
            navigationBar.view.title = existingNavTitle
            save()
        }
    }
    
    // MARK: - UI
    
    private func selectedCategories() -> [ProCategory: Bool] {
        var selection = [ProCategory: Bool]()
        for category in item.categories {
            selection[category] = true
        }
        return selection
    }

    private var content: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                DatePicker("pro_event_details_date".translated(), selection: $editableDate)
                    .font(Font.Pallete.infoText)
                    .colorInvert()
                    .colorMultiply(.white)

                VStack(alignment: .leading, spacing: 0) {
                    Text("pro_event_details_duration".translated())
                        .font(.Pallete.infoText)
                        .foregroundColor(.white)
                    TimePicker(hourSelection: $hours, minuteSelection: $minutes, secondsSelection: $seconds)
                }.frame(height: 200)
                
                ProCategoryGrid(
                    isSelectionEnabled: true,
                    didUpdateCategorySelection: { dictionary in
                        dictionary.forEach {
                            updatedCategorySelection[$0.key] = $0.value
                        }
                    },
                    preselection: selectedCategories()
                ).frame(height: 150)
            }
            .padding(.top, 16)
            .padding(.bottom, TabBarView.height + TabBarView.offset + 60)
        }
        .hideNavigationView()
        .padding(.horizontal, 8)
    }
    
    private var header: some View {
        VStack(spacing: 0) {
            Text(dayFormatted)
                .font(Font.Pallete.infoText)
                .foregroundColor(.white)
            
            Text(timeFormatted)
                .font(Font.Pallete.headerTitle)
                .foregroundColor(.white)
                .padding(.all, 8)
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .multilineTextAlignment(.center)
        }
        .frame(height: 160)
    }
    
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
    
    // MARK: - Core data
    
    private func save() {
        item.creationDate = editableDate
        item.durationSeconds = Double((hours*60*60) + (minutes*60) + seconds)

        
        var existingData = [ProCategory: Bool]()
        // fill with existing selection
        item.categories.forEach {
            existingData[$0] = true
        }
        
        // update with new selection
        updatedCategorySelection.forEach {
            existingData[$0.key] = $0.value
        }

        let dbCategories: [ProTimeCategory] = existingData.compactMap {
            guard $0.value else { return nil }

            let category = ProTimeCategory(context: managedObjectContext)
            category.typeId = Int64($0.key.rawValue)
            return category
        }

        guard !dbCategories.isEmpty else { return }
         
        item.relationship = NSSet(array: dbCategories)
    }

}

// MARK: - Computed

private extension ProActivityDetails {
    
    var dayFormatted: String {
        guard let timestamp = item.creationDate else { return "" }
        return DateFormatter.dayInWeekMonthYearFormatter.string(from: timestamp)
    }
    
    var timeFormatted: String {
        guard let timestamp = item.creationDate else { return "" }
        return DateFormatter.timeOnlyDateFormatter.string(from: timestamp)
    }
    
}

// MARK: - Computed

import CoreData.NSManagedObjectContext

struct ProActivityDetails_Previews: PreviewProvider {
    
    static var previews: some View {
        return ProActivityDetails(item: ProTimeActivity.init(context: NSManagedObjectContext(.mainQueue)))
            .environmentObject(ProAppStateManager())
            .environmentObject(NavigationBarView.NavigationBarAccessible())
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)

    }
}

