//
//  TabBarShape.swift
//  TimeScout
//
//  Created by Matej on 02/08/2022.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import SwiftUI

public struct TabBarShape: Shape {

    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let buttonRadius: CGFloat = 50
        static let buttonPadding: CGFloat = 5
    }

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()

        path.move(to: .init(x: 0, y: rect.height))
        path.addLine(to: .init(x: 0, y: rect.height - Constants.cornerRadius))
        path.addArc(withCenter: .init(x: Constants.cornerRadius, y: Constants.cornerRadius), radius: Constants.cornerRadius, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)

        let lineEnd = rect.width/2 - 2 * Constants.buttonPadding - Constants.buttonRadius
        path.addLine(to: .init(x: lineEnd, y: 0))
        path.addArc(withCenter: .init(x: lineEnd, y: Constants.buttonPadding), radius: Constants.buttonPadding, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
        path.addArc(withCenter: .init(x: rect.width/2, y: Constants.buttonPadding), radius: Constants.buttonPadding + Constants.buttonRadius, startAngle: CGFloat.pi, endAngle: 0, clockwise: false)

        let lineStart = rect.width/2 + 2 * Constants.buttonPadding + Constants.buttonRadius
        path.addArc(withCenter: .init(x: lineStart, y: Constants.buttonPadding), radius: Constants.buttonPadding, startAngle: CGFloat.pi, endAngle: -CGFloat.pi/2, clockwise: true)

        path.addLine(to: .init(x: rect.width - Constants.cornerRadius, y: 0))
        path.addArc(withCenter: .init(x: rect.width - Constants.cornerRadius, y: Constants.cornerRadius), radius: Constants.cornerRadius, startAngle: -CGFloat.pi/2, endAngle: 0, clockwise: true)
        path.addLine(to: .init(x: rect.width, y: rect.height))
        path.close()

        return Path(path.cgPath)
    }
}
