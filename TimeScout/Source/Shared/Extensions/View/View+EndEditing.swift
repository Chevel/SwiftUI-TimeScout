//
//  View+EndEditing.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import SwiftUI

extension View {

    /// Resigns the first responder in any of the application windows. (closes keyboard, resigns active text field)
    /// - Parameter force: Specify true to force the first responder to resign, regardless of whether it wants to do so.
    func endEditing(_ force: Bool) {
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
        (scene as? UIWindowScene)?.windows.forEach { $0.endEditing(force) }
    }

}

