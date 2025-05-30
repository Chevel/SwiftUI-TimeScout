//
//  ListView.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import CoreData
import TimeScoutUI
import TimeScoutCore

struct ListView: View {
    
    @EnvironmentObject var appStateManager: AppStateManager
    var configuration: Configuration
    
    // MARK: - Private
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    private var items: FetchedResults<TimeCategory>
    
    @Environment(\.managedObjectContext)
    private var managedObjectContext
    
    @State private var scrollTarget: String?
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack {
                navigationBarView
                mainView
            }
            .background {
                Color.Pallete.primary.edgesIgnoringSafeArea(.all)
            }
            .overlay(content: {
                addButton.shadow(radius: 6)
                closeButton
                    .ignoresSafeArea(.keyboard)
            })
        }
        .hideNavigationView()
        .tint(.white)
        .sheet(isPresented: $appStateManager.isAddActivityShownOnList) {
            AddActivityView()
        }
        .buttonStyle(DefaultButtonStyle())
    }

    // MARK: - Helper
    
    private func searchForItem(_ txt: String) -> Bool {
        return datasource.contains { activity in
            activity.name.lowercased(with: .current) == txt.lowercased()
        }
    }
    
    private func shouldShowSection(forLetter letter: String) -> Bool {
        return datasource.contains {
            $0.name.lowercased(with: .current).hasPrefix(letter.prefix(1).lowercased(with: .current))
        }
    }
}

// MARK: - Core data

private extension ListView {
    
    func delete(rowItem: TimeCategory) {
        managedObjectContext.delete(rowItem)
        
        do {
            try managedObjectContext.save()
            
            // if we are deleting a selected category, select the first one from list
            if appStateManager.selectedCategory?.name == rowItem.name {
                appStateManager.selectedCategory = items.first
            }
        } catch {
            print("Error - Core Data 💾 - delete time activity")
        }
    }
}

// MARK: - UI

private extension ListView {
    
    var navigationBarView: some View {
        SearchField() {
            appStateManager.searchQuery = $0
        }
        .padding(.top, 62)
    }
    
    @ViewBuilder
    var mainView: some View {
        if items.isEmpty {
            Spacer()
            Text("general_no_data".translated())
                .foregroundColor(.white)
                .font(Font.Pallete.infoText)
            Spacer()
        } else {
            listView.overlay {
                lettersListView.shadow(radius: 6)
            }
        }
    }
    
    var closeButton: some View {
        VStack {
            HStack {
                Spacer()
                CloseButtonView()
                    .padding([.trailing, .top], 16)
                    .onTapGesture {
                        appStateManager.closeListView()
                    }
            }
            Spacer()
        }
    }
    
    var addButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                AddButton()
                    .padding([.trailing, .bottom], 16)
                    .onTapGesture {
                        appStateManager.isAddActivityShownOnList = true
                    }
            }
        }
    }
    
    func listRow(for rowItem: TimeCategory, with configuration: Configuration) -> some View {
        switch configuration {
        case .details:
            return AnyView(
                ZStack {
                    ListRowView(displayText: rowItem.name, isRightArrowVisible: configuration.isRightIconVisible)
                        .background(NavigationLink("", destination: CategoryDetailsView(category: rowItem)).opacity(0))
                }
            )
            
        case .selection:
            return AnyView(
                Button {
                    appStateManager.selectedCategory = rowItem
                    appStateManager.closeListView()
                } label: {
                    ListRowView(displayText: rowItem.name, isRightArrowVisible: configuration.isRightIconVisible)
                }
            )
        }
    }

    var listView: some View {
        ScrollViewReader { scrollProxy in
            List {
                // sections
                ForEach(Array(letterSections.enumerated()), id: \.offset) { sectionIndex, letter in
                    Section(header: sectionHeader(leftText: letter)) {
                        // rows
                        ForEach(Array(rows(for: letter).enumerated()), id: \.offset) { rowIndex, rowItem in
                            listRow(for: rowItem, with: configuration)
                                .swipeActions() {
                                    if !isLocked(for: rowIndex, in: sectionIndex) {
                                        Button {
                                            withAnimation(.easeIn(duration: AppSettings.Constants.AnimationSpeed.medium.rawValue)) {
                                                delete(rowItem: rowItem)
                                            }
                                        } label: {
                                            Label("", systemImage: "trash")
                                        }
                                        .tint(.red)
                                    }
                                }
                                .disabled(isLocked(for: rowIndex, in: sectionIndex))
                                .overlay {
                                    if isLocked(for: rowIndex, in: sectionIndex) {
                                        Color.black
                                            .opacity(0.5)
                                            .overlay {
                                                Image.SFSymbols.Button.lock
                                                    .resizable()
                                                    .scaledToFit()
                                                    .foregroundStyle(Color.Pallete.secondary)
                                                    .frame(width: 30, height: 30)
                                            }
                                    }
                                }
                        }
                    }
                }
                .listRowBackground(Color.Pallete.primary)
                .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 16))
            }
            .onChange(of: scrollTarget) { target in
                if let target = target {
                    scrollTarget = nil
                    withAnimation {
                        scrollProxy.scrollTo(target, anchor: .topLeading)
                    }
                }
            }
        }
        .background(Color.Pallete.primary)
        .edgesIgnoringSafeArea(.all)
    }
    
    func sectionHeader(leftText: String) -> some View {
        ListSectionTitle(leftText: leftText, rightText: "")
            .frame(width: nil, height: 35, alignment: .leading)
            .foregroundColor(.clear)
    }
    
    var lettersListView: some View {
        HStack {
            Spacer()
            VStack(spacing: 1) {
                ForEach(AppSettings.Constants.alphabetCharacters, id: \.self) { letter in
                    Button(action: {
                        withAnimation {
                            scrollTarget = letter
                        }
                    }, label: {
                        Text(letter)
                            .font(Font.Pallete.lettersPicker)
                            .foregroundColor(Color.Pallete.primary)
                    })
                }
            }
        }.padding(.trailing, 3)
    }
}

// MARK: - Data

private extension ListView {
    
    var datasource: [TimeCategory] {
        Array(
            Set(
                items.filter {
                    appStateManager.searchQuery.isEmpty ? true : $0.name.lowercased().contains(appStateManager.searchQuery.lowercased())
                }
            )
        ).sorted { $0.name < $1.name }
    }
    
    var categorySections: [String] {
        let firstLetters: [String] = datasource.compactMap {
            guard let firstLetter = $0.name.first else {
                return nil
            }
            return String(firstLetter)
        }
        return Array(Set(firstLetters)).sorted(by: <)
    }
    
    func rows(for letter: String) -> [TimeCategory] {
        datasource.filter({ $0.name.prefix(1) == letter && searchForItem($0.name) })
    }
    
    var letterSections: [String] {
        categorySections.filter { self.shouldShowSection(forLetter: $0) }
    }
    
    func isLocked(for index: Int, in section: Int) -> Bool {
        false
    }
}

// MARK: - Configuration

extension ListView {
    
    enum Configuration {
        case details
        case selection
        
        var isRightIconVisible: Bool {
            switch self {
            case .selection: return false
            case .details: return true
            }
        }
    }
}

// MARK: - Preview

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(configuration: .details)
            .background(Color.primary)
            .edgesIgnoringSafeArea(.all)
            .environmentObject(AppStateManager())
    }
}
