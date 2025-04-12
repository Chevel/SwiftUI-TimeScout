//
//  TimePicker.swift
//  TimeScout
//
//  Created by Matej on 17/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

struct TimePicker: View {
    @Binding var hourSelection: Int
    @Binding var minuteSelection: Int
    @Binding var secondsSelection: Int
    
    static private let maxHours = 23
    static private let maxMinutes = 59
    static private let maxSeconds = 59
    private let hours = [Int](0...Self.maxHours)
    private let minutes = [Int](0...Self.maxMinutes)
    private let seconds = [Int](0...Self.maxSeconds)
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: .zero) {
                Picker(selection: $hourSelection, label: Text("")) {
                    ForEach(hours, id: \.self) { value in
                        Text("\(value) h")
                            .tag(value)
                            .foregroundColor(.white)
                            .font(.Pallete.infoText)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3, alignment: .center)
                
                Picker(selection: $minuteSelection, label: Text("")) {
                    ForEach(minutes, id: \.self) { value in
                        Text("\(value) m")
                            .tag(value)
                            .foregroundColor(.white)
                            .font(.Pallete.infoText)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3, alignment: .center)
                
                Picker(selection: $secondsSelection, label: Text("")) {
                    ForEach(seconds, id: \.self) { value in
                        Text("\(value) s")
                            .tag(value)
                            .foregroundColor(.white)
                            .font(.Pallete.infoText)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .pickerStyle(.wheel)
                .frame(width: geometry.size.width / 3, alignment: .center)
            }
        }
    }
}

// MARK: - Preview

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(hourSelection: .constant(3),
                   minuteSelection: .constant(1),
                   secondsSelection: .constant(3)
        )
    }
}
