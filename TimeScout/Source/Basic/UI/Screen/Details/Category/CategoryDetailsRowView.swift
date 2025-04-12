//
//  CategoryDetailsRowView.swift
//  TimeScout
//
//  Created by Matej on 05/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import SwiftUI

struct CategoryDetailsRowView: View {

    var displayText: String
    var isSeparatorHidden: Bool = true
    var textColor: Color = Color.white
    var backgroundColor: Color = Color.Pallete.primary
    var separatorColor: Color = .white
    var swipeActionHandler: EmptyClosure
    var tapActionHandler: EmptyClosure?

    // MARK: - Private

    @GestureState private var translation: CGSize = .zero
    @State private var rowState: RowState = .normal

    // MARK: - View
    
    var body: some View {
        let dragGesture = DragGesture()
            .updating($translation) { (value, state, _) in
                guard value.translation.width <= 0 else { return }
                state = value.translation
            }
            .onEnded { value in
                // reset swipe to right
                if value.translation.width >= 0 {
                    rowState = .normal
                } else {
                    guard abs(value.translation.width) < Self.swipeActionThreshold else {
                        // if drag exceeds 100 trigger swipe action
                        swipeActionHandler()
                        return
                    }
                    rowState = .open(offset: -Self.swipeActionWidth)
                }
            }
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(displayText)
                    .foregroundColor(textColor)
                    .font(Font.Pallete.infoText)
                    .padding(.all, 8)
                    .padding(.horizontal, 8)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        .background(Rectangle().foregroundColor(backgroundColor))
        .gesture(rowState.isOpen ? nil : dragGesture)
        .gesture(
            DragGesture().onChanged { value in
                withAnimation {
                    resetRowState()
                }
              }
        )
        .gesture(
            TapGesture(count: 1).onEnded({ _ in
                // only normal cell allows tap action response
                // meaning, when you have swipe to delete opened, tap only closes the swipe action
                if case .normal = rowState {
                    tapActionHandler?()
                }
                withAnimation {
                    resetRowState()
                }
            })
        )
        .padding(.horizontal, 8)
        .offset(x: rowState.isOpen ? rowState.offset : min(translation.width, Self.swipeActionWidth), y: 0)
        .overlay {
            if !isSeparatorHidden {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer()
                    HorizontalSeparator(customColor: separatorColor)
                        .padding(.horizontal, 8)
                }
            }
        }
        .overlay {
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: rowState.isOpen ? abs(rowState.offset) : abs(translation.width))
                    .foregroundColor(.red)
                    .overlay {
                        Image.SFSymbols.trash
                            .scaledToFit()
                            .font(Font.Pallete.icon)
                            .foregroundColor(.white)
                            .padding(.all, 4)
                    }
                    .padding(.bottom, 1)
                    .onTapGesture {
                        swipeActionHandler()
                    }
            }
        }
        .animation( .linear, value: translation.width)
    }
    
    private func resetRowState() {
        switch rowState {
        case .open: rowState = .normal
        case .normal: break
        }
    }
}

// MARK: - Constants

private extension CategoryDetailsRowView {

    static let swipeActionWidth: CGFloat = 60
    static let swipeActionThreshold: CGFloat = 120

}

// MARK: - RowState

private extension CategoryDetailsRowView {
    
    enum RowState {
        case open(offset: CGFloat)
        case normal
        
        var offset: CGFloat {
            switch self {
            case .normal: return .zero
            case .open(let offset):
                if offset < 0 {
                    return max(offset, -swipeActionWidth)
                } else {
                    return min(offset, swipeActionWidth)
                }
            }
        }
        
        var isOpen: Bool {
            switch self {
            case .normal: return false
            case .open: return true
            }
        }
    }

}

// MARK: - Preview

struct CategoryDetailsRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.Pallete.primary
            ListRowView(displayText: "test")
        }
    }
}
