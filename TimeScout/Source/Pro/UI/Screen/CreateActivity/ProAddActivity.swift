//
//  ProAddActivity.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct ProAddActivity: View {
    
    @EnvironmentObject var appStateManager: ProAppStateManager

    @Environment(\.managedObjectContext) private var managedObjectContext
    @FocusState private var isFocused: Bool
    @State private var input = ""
    @State private var selectedCategories: [ProCategory] = []

    // MARK: - View
    
    var body: some View {
        ZStack {
            Color.Pallete.primary.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 100)
                form
                
                ProCategoryGrid(isSelectionEnabled: true, didUpdateCategorySelection: {
                    selectedCategories = $0.compactMap({ $0.value ? $0.key : nil })
                })
                .padding(.all, 16)
                .ignoresSafeArea(.keyboard)
                
                Spacer()
                confirmButton
                    .disabled(isButtonDisabled)
                    .opacity(isButtonDisabled ? 0.3 : 1.0)
            }
            closeButton
        }
    }
    
    // MARK: - UI
    
    private var form: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("add_activity_form_title".translated())
                .foregroundColor(Color.white)
                .font(Font.Pallete.infoText)
            
            TextField("add_activity_form_placeholder".translated(), text: $input)
                .textFieldStyle(AddActivityTextFieldStyle())
                .tint(Color.Pallete.primary)
                .focused($isFocused)
                .onAppear {
                    isFocused = true
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("general_done".translated()) {
                            isFocused = false
                        }
                    }
                }
        }
        .padding(.all, 16)
    }

    private var closeButton: some View {
        VStack {
            HStack {
                Spacer()
                CloseButtonView()
                    .padding([.trailing, .top], 16)
                    .onTapGesture {
                        endEditing(true)
                        appStateManager.isAddActivityShown = false
                    }
            }
            Spacer()
        }
    }

    private var confirmButton: some View {
        return CTAButton(configuration: .fallbackImage(content: Image.SFSymbols.checkmark)) {
            appStateManager.startTimer()
            beginNewActivity(with: selectedCategories)
        }
        .buttonStyle(CTAButtonStyle())
        .padding(.bottom, 16)
    }
    
    // MARK: - Core data
    
    private func beginNewActivity(with categories: [ProCategory]) {
        let dbCategories = categories.map {
            let category = ProTimeCategory(context: managedObjectContext)
            category.typeId = Int64($0.rawValue)
            return category
        }
        
        let newItem = ProTimeRunningActivity(context: managedObjectContext)
        newItem.name = input
        newItem.creationDate = Date()
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
    
}

// MARK: - Computed

private extension ProAddActivity {
    
    var isButtonDisabled: Bool { selectedCategories.isEmpty || input.isEmpty }
    
}

// MARK: - Preview

struct ProAddActivity_Previews: PreviewProvider {
    static var previews: some View {
        ProAddActivity().environmentObject(ProAppStateManager())
    }
}
