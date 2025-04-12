//
//  AddActivityView.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct AddActivityView: View {
    
    @State private var input = ""
    @EnvironmentObject var appStateManager: AppStateManager
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var items: FetchedResults<TimeCategory>
    @State private var isDuplicateEntrySnackbarShown = false
    @FocusState private var isFocused: Bool
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Color.Pallete.primary.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer().frame(height: 100)
                form
                Spacer()
                confirmButton
            }
            closeButton
        }
        .popup(isPresented: $isDuplicateEntrySnackbarShown,
               alignment: .top,
               direction: .top,
               content:
                SnackbarAlert(title: "snackbar_error_duplicate".translated()) {
            isDuplicateEntrySnackbarShown = false
        })
        .animation(.spring(), value: isDuplicateEntrySnackbarShown)
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
                        appStateManager.closeAddActivity()
                    }
            }
            Spacer()
        }
    }

    private var confirmButton: some View {
        return CTAButton(configuration: .fallbackImage(content: Image.SFSymbols.checkmark)) {
            // entry exists
            if items.contains(where: { $0.name.lowercased() == input.lowercased() }) {
                isDuplicateEntrySnackbarShown = true
            } else { // new entry
                // coredata object
                let item = TimeCategory(context: managedObjectContext)
                item.name = input
                
                // select newly added item
                if appStateManager.selectedCategory == nil {
                    appStateManager.selectedCategory = item
                }
                
                // persist to disk
                PersistenceController.shared.save()
                
                // close sheet
                appStateManager.closeAddActivity()
            }
        }
        .buttonStyle(CTAButtonStyle())
        .padding(.bottom, 16)
    }
}

// MARK: - Preview

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView()
            .environmentObject(AppStateManager())
    }
}

