//
//  ProTimelineRow.swift
//  TimeScout
//
//  Created by Matej on 15/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore
import TimeScoutData

struct ProTimelineRow: View {

    let activityName: String
    let activityDurationSeconds: TimeInterval
    let creationDate: Date
    let categories: [ProCategory]
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
        
        contentView
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .foregroundColor(Color.Pallete.primary)
                    .overlay {
                        rightSwipeActionView
                    }
            )
            .clipped()
            .gesture(rowState.isOpen ? nil : dragGesture)
            .gesture(
                DragGesture().onChanged { value in
                    withAnimation {
                        resetRowState()
                    }
                }
            )
    }
    
    // MARK: - UI
    
    private var rightSwipeActionView: some View {
        HStack {
            Spacer()
            Rectangle()
                .cornerRadius(18, corners: [.topRight, .bottomRight])
                .frame(width: Self.swipeActionWidth)
                .foregroundColor(.red)
                .overlay {
                    Image.SFSymbols.trash
                        .scaledToFit()
                        .font(Font.Pallete.icon)
                        .foregroundColor(.white)
                        .padding(.all, 4)
                        .frame(maxHeight: 40)
                }
                .padding(.bottom, 1)
                .onTapGesture {
                    swipeActionHandler()
                }
        }
    }
    
    private var topRow: some View {
        HStack {
            Text(activityName)
                .minimumScaleFactor(0.5)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .font(.Pallete.infoText)
            Spacer()
            HStack(spacing: 8) {
                Text(DateFormatter.timeOnlyDateFormatter.string(from: creationDate))
                    .foregroundColor(.white)
                Image.SFSymbols.timeIcon
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    private var contentView: some View {
        VStack {
            topRow
            bottomRow
        }
        .padding(.all, 16)
        .background(RoundedRectangle(cornerRadius: 18, style: .continuous).foregroundColor(Color.Pallete.primary))
        .offset(x: rowState.isOpen ? rowState.offset : min(translation.width, Self.swipeActionWidth), y: 0)
    }
    
    private var bottomRow: some View {
        HStack {
            HStack(spacing: 8) {
                ForEach(categories.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { item in
                    item.icon
                        .scaledToFit()
                        .foregroundColor(item.color)
                        .frame(width: 20, height: 20)
                }
            }
            Spacer()
            HStack {
                Text(durationAsTime)
                    .minimumScaleFactor(0.2)
                    .foregroundColor(.white)
                Image.SFSymbols.hourglassIcon
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    private func resetRowState() {
        switch rowState {
        case .open: rowState = .normal
        case .normal: break
        }
    }

}

// MARK: - Constants

private extension ProTimelineRow {

    static let swipeActionWidth: CGFloat = 60
    static let swipeActionThreshold: CGFloat = 120
    
    private var durationAsTime: String {
        let h = Time(seconds: activityDurationSeconds).displayHours
        let m = Time(seconds: activityDurationSeconds).displayMinutes
        let s = Time(seconds: activityDurationSeconds).displaySeconds
        return "\(h)h \(m)m \(s)s"
    }

}

// MARK: - RowState

private extension ProTimelineRow {
    
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

struct ProTimelineRow_Previews: PreviewProvider {
    static var previews: some View {
        ProTimelineRow(activityName: "test",
                       activityDurationSeconds: 35.0,
                       creationDate: .distantPast,
                       categories: [.brainPower, .emotion],
                       swipeActionHandler: {})
    }
}
