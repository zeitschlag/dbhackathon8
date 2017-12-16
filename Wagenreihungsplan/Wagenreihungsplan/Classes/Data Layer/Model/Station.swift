//
//  Station.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 15.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import Foundation

struct Station {
    
    var shortCode: String
    var name: String
    var tracks: [Track]
    
}

extension Station: Equatable {
    //TODO: Double check this and add an identifier, a UUID, for example?
    static func ==(lhs: Station, rhs: Station) -> Bool {
        return lhs.shortCode == rhs.shortCode && lhs.name == rhs.name && lhs.tracks == rhs.tracks
    }
    
}
