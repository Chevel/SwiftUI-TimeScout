//
//  ProAddActivity.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

struct ProCategoryDetails: View {
    
    let category: ProCategory
    
    @EnvironmentObject
    var appStateManager: ProAppStateManager
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.creationDate)])
    private var activities: FetchedResults<ProTimeActivity>
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 40) {
            header
            details
            footer
            Spacer()
        }
        .padding(.horizontal, 8)
        .background(category.color.edgesIgnoringSafeArea(.all))
        .overlay {
            closeButton
        }
    }
    
    // MARK: - UI
    
    private var header: some View {
        VStack(spacing: 16) {
            Text(category.name)
                .font(Font.Pallete.headerTitle)
                .foregroundColor(.white)
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .multilineTextAlignment(.center)
            category.icon
                .font(Font.Pallete.headerTitle)
                .foregroundColor(.white)
                .scaledToFit()
                .frame(height: 80)
        }.padding(.top, 32)
    }

    private var footer: some View {
        VStack {
            Text("category_details_focus".translated())
                .font(Font.Pallete.categoryDetailsFooterTitle)
                .foregroundColor(.white)

            Text((String(format: "%.1f", Time.score(categoryActivities: categoryActivities, allActivities: allActivities)) + "%"))
                .font(Font.Pallete.categoryDetailsFooterSubtitle)
                .foregroundColor(.white)
        }
    }
    
    private var details: some View {
        VStack(spacing: 8) {
            HStack {
                Text("category_details_today".translated())
                    .foregroundColor(.white)
                    .font(Font.Pallete.infoText)
                Spacer()
                Text(String(format: "%0.1f", Time.todayHours(from: categoryActivities)) + "h / 24h")
                    .foregroundColor(.white)
                    .font(Font.Pallete.infoText)
            }
            HStack {
                Text("category_details_daily".translated())
                    .foregroundColor(.white)
                    .font(Font.Pallete.infoText)
                Spacer()
                Text("~" + String(format: "%0.1f", Time.dailyHours(from: categoryActivities)) + "h")
                    .foregroundColor(.white)
                    .font(Font.Pallete.infoText)
            }
            HStack {
                Text("category_details_weekly".translated())
                    .foregroundColor(.white)
                    .font(Font.Pallete.infoText)
                Spacer()
                Text("~" + String(format: "%0.1f", Time.weeklyHours(from: categoryActivities)) + "h")
                    .foregroundColor(.white)
                    .font(Font.Pallete.infoText)
            }
        }.padding(.horizontal, 8)
    }
    
    private var closeButton: some View {
        VStack {
            HStack {
                Spacer()
                CloseButtonView()
                    .padding([.trailing, .top], 16)
                    .onTapGesture {
                        appStateManager.isCategoryDetailsShown = false
                    }
            }
            Spacer()
        }
    }
}

// MARK: - Computed

extension ProCategoryDetails {

    private var allActivities: [ProTimeActivity] {
        return activities.map { $0 }
    }

    private var categoryActivities: [ProTimeActivity] {
        activities.filter {
            $0.relationship?
                .compactMap { $0 is ProTimeCategory ? ($0 as! ProTimeCategory) : nil }
                .contains { $0.typeId == category.rawValue } ?? false
        }
    }
    
}

// MARK: - Category data

extension ProCategoryDetails {
    
    struct CategoryData {
        let category: ProCategory
        var scorePercentage: Float
        var todayHours: Int
        var dailyHours: Float
        var weeklyHours: Float
        var totalTime: Time
    }

}

// MARK: - Preview

struct ProCategoryDetails_Previews: PreviewProvider {

    static var previews: some View {
        ProCategoryDetails(category: .health)
            .environmentObject(ProAppStateManager())
    }
}
