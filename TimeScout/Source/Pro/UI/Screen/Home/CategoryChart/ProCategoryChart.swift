//
//  ProCategoryWheel.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Charts
import SwiftUI
import TimeScoutCore
import TimeScoutData

struct ProCategoryChart: View {

    @EnvironmentObject private var appStateManager: ProAppStateManager

    @FetchRequest(sortDescriptors: [SortDescriptor(\.creationDate)])
    private var activities: FetchedResults<ProTimeActivity>

    @State private var selectedAngle: Double?

    // MARK: - Main

    var chartTitle: String {
        guard let selectedCategory, let data = data(for: selectedCategory) else {
            return "chart_pie_center_title".translated()
        }
        return selectedCategory.name + "\n" + "\(data.percent)%"
    }
    
    var body: some View {
        baseChart
            .chartBackground { chartProxy in
                if #available(iOS 17.0, *) {
                    GeometryReader { geometry in
                        if let anchor = chartProxy.plotFrame {
                            let frame = geometry[anchor]
                            Text(chartTitle)
                                .multilineTextAlignment(.center)
                                .position(x: frame.midX, y: frame.midY)
                                .font(UIDevice.current.isIpad ? .Pallete.Chart.centerTextIpad : .Pallete.Chart.centerText)
                                .bold()
                                .foregroundStyle(Color.Pallete.primary)
                        }
                    }
                }
            }
            .chartForegroundStyleScale([
                ProCategory.health.name: ProCategory.health.color,
                ProCategory.emotion.name: ProCategory.emotion.color,
                ProCategory.brainPower.name: ProCategory.brainPower.color,
                
                ProCategory.friends.name: ProCategory.friends.color,
                ProCategory.family.name: ProCategory.family.color,
                ProCategory.spouse.name: ProCategory.spouse.color,
                
                ProCategory.money.name: ProCategory.money.color,
                ProCategory.fun.name: ProCategory.fun.color,
                ProCategory.work.name: ProCategory.work.color
            ])
            .chartXAxis(.hidden)
            .scaledToFit()
    }
}

// MARK: - UI

private extension ProCategoryChart {
    
    @ViewBuilder
    var baseChart: some View {
        if #available(iOS 17.0, *) {
            Chart {
                ForEach(allData) { data in
                    chartSliceFor(data: data)
                }
            }
            .chartAngleSelection(value: $selectedAngle)
        } else {
            Chart {
                ForEach(allData) { data in
                    chartSliceFor(data: data)
                }
            }
        }
    }
    
    func data(for category: ProCategory) -> Data? {
        allData.first { $0.category == category }
    }

    func chartSliceFor(data: Data) -> some ChartContent {
        if #available(iOS 17.0, *) {
            return SectorMark(
                angle: .value("charts_title".translated(), isDataEmpty ? 100 : data.percent),
                innerRadius: .ratio(0.6),
                angularInset: 2
            )
            .cornerRadius(5)
            .foregroundStyle(by: .value("", data.category.name))
            .opacity(data.category == selectedCategory ? 1 : 0.5)

        } else {
            return BarMark(
                x: .value("", data.percent),
                y: .value("", "charts_title".translated())
            )
            .annotation(content: {
                data.category.icon
                    .offset(y: 75)
                    .zIndex(1)
                    .foregroundColor(.white)
                    .font(.Pallete.infoText)
                    .imageScale(.medium)
            })
            .foregroundStyle(by: .value("", data.category.name))
        }
    }
}

// MARK: - Computed

private extension ProCategoryChart {
    
    var isDataEmpty: Bool {
        allData.first { $0.percent != 0 } == nil
    }
    
    var allData: [Data] {
        ProCategory.allCases.map { Data(category: $0, percent: percentage(for: $0)) }
    }
    
    var categoryRanges: [(category: ProCategory, range: Range<Double>)] {
        var total = 0
        return allData.compactMap {
            guard $0.percent != 0 else {
                return nil
            }
            
            let newTotal = total + $0.percent
            let result = (category: $0.category, range: Double(total) ..< Double(newTotal))
        
            total = newTotal
            
            return result
        }
    }

    var selectedCategory: ProCategory? {
        guard let selectedAngle else { return nil }
        
        if let selected = categoryRanges.first(where: { $0.range.contains(selectedAngle) }) {
            return selected.category
        }
        return nil
    }

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
    
    func percentage(for category: ProCategory) -> Int {
        return Int(Time.score(categoryActivities: activities(for: category), allActivities: allActivities))
    }
}

extension ProCategoryChart {
    
    struct Data: Identifiable {
        let category: ProCategory
        let percent: Int

        let id = UUID()
    }
}

// MARK: - Preview

struct ProCategoryChart_Previews: PreviewProvider {
    static var previews: some View {
        ProCategoryChart()
    }
}
