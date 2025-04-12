//
//  SearchField.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct SearchField: View {

    @State private var searchText: String = ""
    @State private var isEditing: Bool = false
    var textFieldDidChange: ((_ newValue: String) -> Void)?

    var body: some View {
        VStack {
            HStack {
                withAnimation(.easeIn(duration: 0.25)) {
                    TextField("", text: $searchText)
                        .placeholder(when: searchText.isEmpty) {
                            Text("search_filter_query_placeholder".translated())
                                .foregroundColor(Color.Pallete.primary.opacity(0.5))
                                .padding(.horizontal, 8)
                        }
                        .tint(Color.Pallete.primary)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image.SFSymbols.magnifyGlass
                                    .scaledToFit()
                                    .foregroundColor(Color.Pallete.primary)
                                    .font(.system(size: 20, weight: .bold))
                                    .padding(.leading, 4)
                                    .frame(width: 30, height: 30)
                                Spacer()
                            }
                        )
                        .padding(.horizontal, 10)
                        .onTapGesture(perform: {
                            self.isEditing = true
                        })
                        .onChange(of: searchText, perform: { newValue in
                            textFieldDidChange?(searchText)
                        })
                }

                if isEditing {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        Button {
                            self.isEditing = false
                            self.searchText = ""
                            self.endEditing(true)
                        } label: {
                            Text("general_cancel".translated())
                                .foregroundColor(.white)
                                .frame(height: 30)
                        }
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                    }
                }
            }
        }
    }
}

// MARK: - Preview

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Pallete.primary
            SearchField()
        }
        
    }
}
