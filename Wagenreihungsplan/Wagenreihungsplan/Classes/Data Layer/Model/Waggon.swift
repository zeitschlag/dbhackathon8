//
//  Waggon.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 15.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import Foundation

struct Waggon {
    var sections: [String]
    var number: Int
}

extension Waggon: Equatable {    
    //TODO: Double check this and add an identifier, a UUID, for example?
    static func ==(lhs: Waggon, rhs: Waggon) -> Bool {
        return lhs.sections == rhs.sections && lhs.number == rhs.number
    }
}
