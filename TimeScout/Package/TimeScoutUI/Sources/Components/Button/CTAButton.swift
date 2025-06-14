//
//  BigActionButton.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI
import TimeScoutCore

public struct CTAButton: View {
    
    private var configuration: Configuration
    private var buttonPressedAction: EmptyClosure
    
    public init(configuration: Configuration, buttonPressedAction: @escaping EmptyClosure) {
        self.configuration = configuration
        self.buttonPressedAction = buttonPressedAction
    }
    
    public var body: some View {
        Button(action: buttonPressedAction, label: {
            HStack {
                Spacer()
                configuration.mainContent
                Spacer()
            }
        })
    }
}

// MARK: - Title

public extension CTAButton {

    enum Configuration {
        case text(content: String, font: Font)
        case fallbackImage(content: Image)
        
        var mainContent: some View {
            switch self {
            case .text(let content, let font):
                return AnyView(
                Text(content)
                    .font(font)
                    .foregroundColor(.white)
                    .padding(.all, 4)
                    .minimumScaleFactor(0.1)
            )
            case .fallbackImage(let content):
                return AnyView(content.frame(width: 30, height: 30).foregroundColor(.white))
            }
        }
    }
}

// MARK: - Preview

struct AddTraitButtonView_Previews: PreviewProvider {

    static var previews: some View {
        CTAButton(configuration: .text(content: "test", font: .title2)) {
            
        }
    }
}
