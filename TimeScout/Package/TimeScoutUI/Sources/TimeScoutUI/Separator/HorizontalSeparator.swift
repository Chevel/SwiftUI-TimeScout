//
//  HorizontalSeparator.swift
//  TimeScout
//
//  Created by Matej on 03/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public struct HorizontalSeparator: View {

    private var customColor: Color
    
    public init(customColor: Color = .white) {
        self.customColor = customColor
    }
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 0.5)
            .frame(height: 1)
            .foregroundColor(customColor)
    }
}

// MARK: - Preview

struct Separator_Previews: PreviewProvider {

    static var previews: some View {
        HorizontalSeparator()
    }
}
