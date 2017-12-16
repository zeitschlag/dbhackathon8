//
//  Track.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 15.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import Foundation

struct Track {
    var name: String
    var number: Int
    var trains: [Train]
}

extension Track: Equatable {
    //TODO: Double check this and add an identifier, a UUID, for example?
    static func ==(lhs: Track, rhs: Track) -> Bool {
        return lhs.name == rhs.name && lhs.number == rhs.number && lhs.trains == rhs.trains
    }
    
    
}
