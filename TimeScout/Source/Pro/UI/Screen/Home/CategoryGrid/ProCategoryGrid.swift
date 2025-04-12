//
//  ProCategoryGrid.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct ProCategoryGrid: View {
    
    var isSelectionEnabled = false
    var showsCategoryData = false
    var didUpdateCategorySelection: (([ProCategory: Bool]) -> Void)?
    var didSelectCategory: ((ProCategory) -> Void)?
    
    var preselection = [ProCategory: Bool]()
    
    @State private var categorySelection: [ProCategory: Bool] = [:]
   
    @FetchRequest(sortDescriptors: [SortDescriptor(\.creationDate)])
    private var activities: FetchedResults<ProTimeActivity>
    
    @EnvironmentObject var appStateManager: ProAppStateManager

    var body: some View {
        Grid(alignment: .center, horizontalSpacing: 4, verticalSpacing: 4) {
            ForEach(Array(ProCategory.allCases.enumerated()), id: \.element) { index, item in
                if index % 3 == 0 {
                    let item1 = ProCategory.allCases[index]
                    let item2 = ProCategory.allCases[index+1]
                    let item3 = ProCategory.allCases[index+2]
                    
                    let isItem1Enabled = preselection[item1] ?? false
                    let isItem2Enabled = preselection[item2] ?? false
                    let isItem3Enabled = preselection[item3] ?? false
                    
                    GridRow {
                        row(category: item1, isSelected: isItem1Enabled, isUserInteractionEnabled: isSelectionEnabled)
                        row(category: item2, isSelected: isItem2Enabled, isUserInteractionEnabled: isSelectionEnabled)
                        row(category: item3, isSelected: isItem3Enabled, isUserInteractionEnabled: isSelectionEnabled)
                    }
                }
            }
        }
    }

    private func row(category: ProCategory, isSelected: Bool, isUserInteractionEnabled: Bool) -> some View {
        ProCategoryGridItemView(
            category: category,
            isSelected: isSelected,
            isUserInteractionEnabled: isUserInteractionEnabled,
            displayedValue: showsCategoryData ? percentage(for: category) : nil
        ) { selection in
            categorySelection[selection.category] = selection.isOn
            didUpdateCategorySelection?(categorySelection)
        }
        .onTapGesture {
            didSelectCategory?(category)
        }
    }
}

// MARK: - Computed

private extension ProCategoryGrid {
    
    var allActivities: [ProTimeActivity] {
        return activities.map { $0 }
    }
    
    func activities(for category: ProCategory) -> [ProTimeActivity] {
        activities.filter {
            $0.relationship?
                .compactMap { $0 is ProTimeCategory ? ($0 as! ProTimeCategory) : nil }
                .contains { $0.typeId == category.rawValue } ?? false
        }
    }
    
    func percentage(for category: ProCategory) -> String {
        let percent = Time.score(categoryActivities: activities(for: category), allActivities: allActivities)
        return (String(format: "%.1f", percent) + "%")
    }

}

// MARK: - Preview

struct ProCategoryGrid_Previews: PreviewProvider {
    static var previews: some View {
        ProCategoryGrid(preselection: [.emotion: true])
    }
}
