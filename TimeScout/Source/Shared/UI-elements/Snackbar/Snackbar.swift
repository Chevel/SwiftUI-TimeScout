//
//  Snackbar.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

struct SnackbarSuccess: View {

    let handler: EmptyClosure
    var body: some View {
        CTAButton(configuration: .text(content: "snackbar_event_saved".translated(), font: Font.Pallete.snackbar), buttonPressedAction: handler)
            .buttonStyle(SnackbarStyleInfo())
    }

}

struct SnackbarAlert: View {
    
    let title: String
    let handler: EmptyClosure
    var body: some View {
        CTAButton(configuration: .text(content: title, font: Font.Pallete.snackbar), buttonPressedAction: handler)
            .buttonStyle(SnackbarStyleAlert())
    }

}

// MARK: - Preview

struct SnackbarUndo_Previews: PreviewProvider {
    static var previews: some View {
        SnackbarSuccess {
            
        }
    }
}

struct SnackbarAlert_Previews: PreviewProvider {
    static var previews: some View {
        SnackbarAlert(title: "test") {
            
        }
    }
}

// MARK: -

struct Popup<T: View>: ViewModifier {
    let popup: T
    let alignment: Alignment
    let direction: Direction
    var isPresented: Binding<Bool>

    init(isPresented: Binding<Bool>, alignment: Alignment, direction: Direction, content: T) {
        self.isPresented = isPresented
        self.alignment = alignment
        self.direction = direction
        self.popup = content
    }

    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented.wrappedValue {
                popup
                    .transition(.offset(x: 0, y: direction.offset(popupFrame: geometry.frame(in: .global))))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
            }
        }
    }
}

extension Popup {
    enum Direction {
        case top, bottom

        func offset(popupFrame: CGRect) -> CGFloat {
            switch self {
            case .top:
                let aboveScreenEdge = -popupFrame.maxY
                return aboveScreenEdge
            case .bottom:
                let belowScreenEdge = UIScreen.main.bounds.height - popupFrame.minY
                return belowScreenEdge
            }
        }
    }
}

extension View {
    func popup<T: View>(
        isPresented: Binding<Bool>,
        alignment: Alignment = .center,
        direction: Popup<T>.Direction = .bottom,
        content: T
    ) -> some View {
        return modifier(Popup(isPresented: isPresented, alignment: alignment, direction: direction, content: content))
    }
}

private extension View {
    func onGlobalFrameChange(_ onChange: @escaping (CGRect) -> Void) -> some View {
        background(GeometryReader { geometry in
            Color.clear.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
        })
        .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
    }

    func print(_ varargs: Any...) -> Self {
        Swift.print(varargs)
        return self
    }
}

private struct FramePreferenceKey: PreferenceKey {
    static let defaultValue = CGRect.zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
