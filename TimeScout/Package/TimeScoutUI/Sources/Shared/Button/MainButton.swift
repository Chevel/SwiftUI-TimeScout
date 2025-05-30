//
//  MainButton.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

public struct MainButton: View {
    
    public let configuration: Configuration
    public let handler: EmptyClosure
    
    public init(configuration: Configuration, handler: @escaping EmptyClosure) {
        self.configuration = configuration
        self.handler = handler
    }
    
    public var body: some View {
        Button(
            action: handler,
            label: {
                switch configuration {
                case .add:
                    Circle()
                        .foregroundColor(Color.Pallete.secondary)
                        .overlay {
                            Image.SFSymbols.plus
                                .scaledToFit()
                                .foregroundColor(.white)
                                .font(Font.Pallete.Button.big)
                                .padding(.all, 80)
                        }
                case .action:
                    Image.SFSymbols.Button.circle
                        .scaledToFit()
                        .foregroundColor(.white)
                        .font(Font.Pallete.Button.big)
                        .padding(.all, 16)
                }
            })
        .buttonStyle(MainButtonStyle())
    }
}

public extension MainButton {
    
    enum Configuration {
        case add
        case action
    }
}

// MARK: - Preview

struct MainButton_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            Color.Pallete.primary
            MainButton(configuration: .action) {
            }
        }
    }
}
