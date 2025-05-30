//
//  AddButton.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public struct AddButton: View {
    
    private let size = CGSize(width: 60, height: 60)
    
    public init() {}
    
    public var body: some View {
        Circle()
            .frame(width: size.width, height: size.height)
            .foregroundColor(Color.Pallete.secondary)
            .overlay {
                Image.SFSymbols.plus
                    .foregroundColor(.white)
                    .font(Font.Pallete.Button.big)
                    .padding(.all, 16)
            }
    }
}

// MARK: - Preview

struct AddButton_Previews: PreviewProvider {

    static var previews: some View {
        AddButton()
    }
}
