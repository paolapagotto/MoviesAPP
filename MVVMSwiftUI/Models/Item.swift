//
//  Item.swift
//  MVVMSwiftUI
//
//  Created by Pagotto, Paola Fagundes on 15/04/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var id: String
    var watched: Bool
    
    init(timestamp: Date, id: String, watched: Bool) {
        self.timestamp = timestamp
        self.id = id
        self.watched = watched
    }
}
