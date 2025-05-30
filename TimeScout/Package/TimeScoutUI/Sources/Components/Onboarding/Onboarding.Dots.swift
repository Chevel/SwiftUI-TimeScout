//
//  Onboarding.Dots.swift
//  TimeScout
//
//  Created by Matej on 22. 11. 24.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public struct Fancy3DotsIndexView: View {
    
    // MARK: - Drawing Constants
    
    private let circleSize: CGFloat = 16
    private let circleSpacing: CGFloat = 12
    
    private let primaryColor = Color.Pallete.Background.secondary
    private let secondaryColor = Color.white.opacity(0.6)
    
    private let smallScale: CGFloat = 0.6

    // MARK: - Properties
    
    private let numberOfPages: Int
    private let currentIndex: Int
    
    public init(numberOfPages: Int, currentIndex: Int) {
        self.numberOfPages = numberOfPages
        self.currentIndex = currentIndex
    }

    // MARK: - Body
    
    public var body: some View {
        HStack(spacing: circleSpacing) {
            ForEach(0..<numberOfPages) { index in
                if shouldShowIndex(index) {
                    Circle()
                        .fill(currentIndex == index ? primaryColor : secondaryColor)
                        .scaleEffect(currentIndex == index ? 1 : smallScale)
                        .frame(width: circleSize, height: circleSize)
                        .transition(AnyTransition.opacity.combined(with: .scale))
                        .id(index)
                }
            }
        }
    }
}

private extension Fancy3DotsIndexView {
    
    func shouldShowIndex(_ index: Int) -> Bool {
        ((currentIndex - 1)...(currentIndex + 1)).contains(index)
    }
}
