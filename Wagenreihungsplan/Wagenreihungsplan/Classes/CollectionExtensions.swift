//
//  CollectionExtensions.swift
//  Wagenreihungsplan
//
//  Created by Nathan Mattes on 16.12.17.
//  Copyright © 2017 Nathan Mattes. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
