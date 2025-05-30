//
//  ContentView.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import CoreData
import TimeScoutUI
import TimeScoutCore
import UIKit.UIImpactFeedbackGenerator

struct HomeView: View {
    @Environment(\.managedObjectContext)
    private var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TimeCategory.name, ascending: true)],
        animation: .easeInOut)
    private var items: FetchedResults<TimeCategory>

    @EnvironmentObject var appStateManager: AppStateManager
    @State private var firstTimePaywallAppear = false

    // MARK: - View

    var body: some View {
        contentView
            .popup(
                isPresented: $appStateManager.isSnackbarPresented,
                alignment: .top,
                direction: .top,
                content: SnackbarSuccess(
                    handler: {
                        appStateManager.isSnackbarPresented = false
                    })
            )
            .animation(.spring(), value: appStateManager.isSnackbarPresented)
            .onAppear {
                if appStateManager.selectedCategory == nil {
                    if let userSelectedCategory = UserDefaults.standard.string(forKey: UserDefaults.TimeScoutKey.selectedCategory.rawValue) {
                        appStateManager.selectedCategory = items.first(where: { $0.name == userSelectedCategory })
                    } else {
                        appStateManager.selectedCategory = items.first
                    }
                }
            }
            .background(Color.Pallete.primary)
    }
}

// MARK: - UI

private extension HomeView {
    
    var contentView: some View {
        VStack {
            navigationStack
            
            Spacer()

            MainButton(configuration: appStateManager.selectedCategory == nil ? .add : .action) {
                if let selectedCategory = appStateManager.selectedCategory {
                    storeNewActivity(with: selectedCategory)
                    appStateManager.isSnackbarPresented = true
                } else {
                    appStateManager.isAddActivityShownOnHome = true
                }
            }
            .padding(.all, 32)
            
            Spacer()
            
            if appStateManager.selectedCategory != nil {
                itemSelectionButton
            }
        }
    }
    
    var navigationStack: some View {
        HStack {
            listButton
            Spacer()
            ShareView(linkURL: AppSettings.Constants.appStoreURL)
        }
        .padding(.all, 16)
        .sheet(isPresented: $appStateManager.isListShown) {
            ListView(configuration: .details)
        }
        .sheet(isPresented: $appStateManager.isItemSelectionShown) {
            ListView(configuration: .selection)
        }
        .sheet(isPresented: $appStateManager.isAddActivityShownOnHome) {
            AddActivityView()
        }
    }
    
    var itemSelectionButton: some View {
        let buttonConfiguration: CTAButton.Configuration
        if let itemName = appStateManager.selectedCategory?.name {
            buttonConfiguration = .text(content: itemName, font: Font.Pallete.Button.CTA)
        } else {
            buttonConfiguration = .fallbackImage(content: Image.SFSymbols.plus)
        }
        return CTAButton(configuration: buttonConfiguration) {
            appStateManager.isItemSelectionShown = true
        }
        .buttonStyle(CTAButtonStyle())
        .padding(.bottom, 16)
    }
    
    var listButton: some View {
        Image.SFSymbols.list
            .scaledToFit()
            .frame(width: 30, height: 30)
            .foregroundColor(.white)
            .onTapGesture {
                appStateManager.isListShown = true
            }
    }
}

// MARK: - Core data

private extension HomeView {
    
    func storeNewActivity(with parent: TimeCategory) {
        
        withAnimation {
            let newItem = TimeActivity(context: managedObjectContext)
            newItem.timestamp = Date()
            newItem.relationship = parent
            newItem.activityID = UUID().uuidString
            
            do {
                try managedObjectContext.save()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                assertionFailure("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppStateManager())
    }
}
