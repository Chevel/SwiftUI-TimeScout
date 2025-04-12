//
//  Namespace.swift
//  TimeScout
//
//  Created by Matej on 02/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation

typealias EmptyClosure = (() -> Void)

protocol Unique {
    var id: String { get set }
}
