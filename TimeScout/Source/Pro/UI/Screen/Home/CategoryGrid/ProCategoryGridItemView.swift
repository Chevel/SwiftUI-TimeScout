//
//  ProCategoryGridItemView.swift
//  TimeScout
//
//  Created by Matej on 12/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct ProCategoryGridItemView: View {
    
    @EnvironmentObject private var appStateManager: ProAppStateManager

    // MARK: - Properties

    var category: ProCategory
    @State private var isSelected: Bool
    var isUserInteractionEnabled: Bool
    var displayedValue: String?
    var selectionHandler: (((category: ProCategory, isOn: Bool)) -> Void)?

    init(
        category: ProCategory,
        isSelected: Bool = false,
        isUserInteractionEnabled: Bool = true,
        displayedValue: String? = nil,
        selectionHandler: (((category: ProCategory, isOn: Bool)) -> Void)? = nil
    ) {
        self.category = category
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.displayedValue = displayedValue
        self.selectionHandler = selectionHandler
        self.isSelected = isSelected
    }

    // MARK: - View

    var body: some View {
        if isUserInteractionEnabled {
            AnyView(
                Button(action: {
                    isSelected.toggle()
                    selectionHandler?((category, isSelected))
                }, label: {
                    rectangleView()
                })
            )
        } else {
            AnyView(rectangleView())
        }
    }

    // MARK: - Helper

    private func rectangleView() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(foregroundColor)
            .overlay {
                VStack(spacing: 0) {
                    category.icon
                        .scaledToFit()
                        .frame(maxWidth: 40, maxHeight: 40)
                        .foregroundColor(.white)
                    Text(category.name)
                        .font(Font.Pallete.categoryCardName)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    if let displayedValue {
                        Text(displayedValue)
                            .font(Font.Pallete.categoryCardSubtitle)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                    }
                }.padding(5)
            }
    }

}

// MARK: - Computed

extension ProCategoryGridItemView {

    private var foregroundColor: Color {
        guard isUserInteractionEnabled else {
            return category.color
        }
        return isSelected ? category.color : category.color.opacity(0.15)
    }

}

// MARK: - Preview

struct ProCategoryGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProCategoryGridItemView(category: .health)
    }
}
