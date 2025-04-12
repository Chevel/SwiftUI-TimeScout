//
//  EventDetailsView.swift
//  TimeScout
//
//  Created by Matej on 08/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct EventDetailsView: View {
    
    @ObservedObject var item: TimeActivity
    @EnvironmentObject var appStateManager: AppStateManager

    @State private var editableDate = Date.now
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.presentationMode) private var presentationMode

    // MARK: - View
    
    var body: some View {
        ZStack {
            backArrowButton.padding(.all, 16)
            
            VStack(spacing: 0) {
                header
                HorizontalSeparator()
                content
                confirmButton
            }
        }
        .background(Color.Pallete.primary.edgesIgnoringSafeArea(.all))
        .onAppear { editableDate = item.timestamp ?? .now }
    }
    
    // MARK: - UI
    
    private var content: some View {
        VStack {
            DatePicker("event_details_date".translated(), selection: $editableDate)
                .font(Font.Pallete.infoText)
                .colorInvert()
                .colorMultiply(.white)
            Spacer()
        }
        .hideNavigationView()
        .padding(.horizontal, 8)
        .padding(.top, 16)
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
        .padding(.top, 30)
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
    
    private var confirmButton: some View {
        return CTAButton(configuration: .fallbackImage(content: Image.SFSymbols.checkmark)) {
            save()
        }
        .buttonStyle(CTAButtonStyle())
        .padding(.bottom, 16)
    }
    
    // MARK: - Core data
    
    private func save() {
        item.timestamp = editableDate
        presentationMode.wrappedValue.dismiss()
    }

}

// MARK: - Computed

private extension EventDetailsView {
    
    var dayFormatted: String {
        guard let timestamp = item.timestamp else { return "" }
        return DateFormatter.dayInWeekMonthYearFormatter.string(from: timestamp)
    }
    
    var timeFormatted: String {
        guard let timestamp = item.timestamp else { return "" }
        return DateFormatter.timeOnlyDateFormatter.string(from: timestamp)
    }
    
}

// MARK: - Computed

import CoreData.NSManagedObjectContext

struct EventDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        EventDetailsView(item: TimeActivity.init(context: NSManagedObjectContext.init(.mainQueue)))
            .environmentObject(AppStateManager())
    }
}
