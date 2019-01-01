//
//  Element.swift
//  PerfectArchitecture
//
//  Created by Rafael Ruiz on 12/31/18.
//  Copyright © 2018 valid. All rights reserved.
//

import Foundation

class Element {
    let name: String?
    let description: String?
    var isFavorite: Bool
    
    init(_ name: String, _ description: String, _ isFavorite: Bool) {
        self.name = name
        self.description = description
        self.isFavorite = isFavorite
    }
}
