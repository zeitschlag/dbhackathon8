//
//  Subtrain.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 16.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import Foundation

struct Subtrain {
    var trainNumber: Int?
    var trainType: String?
    var sections: [String]
}

extension Subtrain: Equatable {
    static func ==(lhs: Subtrain, rhs: Subtrain) -> Bool {
        return lhs.trainNumber == rhs.trainNumber && lhs.trainType == rhs.trainType && lhs.sections == rhs.sections
    }
}
