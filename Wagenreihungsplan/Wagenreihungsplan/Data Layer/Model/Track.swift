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
    var sections: [String]
}
