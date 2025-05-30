//
//  CloseButton.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public struct CloseButtonView: View {
    
    static let size = CGSize(width: 30, height: 30)
    
    public init() {}
    
    public var body: some View {
        Image.SFSymbols.close
            .foregroundColor(.white)
            .frame(width: Self.size.width, height: Self.size.height)
    }
}

// MARK: - Preview

struct CloseButtonView_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            Color.Pallete.primary.edgesIgnoringSafeArea(.all)
            CloseButtonView()
        }
    }
}
