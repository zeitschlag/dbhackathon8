//
//  Train.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 15.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import Foundation

struct Train {
    var subtrains: [Subtrain]
    var waggons: [Waggon]
}

extension Train: Equatable {
    //TODO: Double check this and add an identifier, a UUID, for example?
    static func ==(lhs: Train, rhs: Train) -> Bool {
        return lhs.subtrains == rhs.subtrains && lhs.waggons == rhs.waggons
    }
}
