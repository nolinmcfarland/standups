//
//  Meeting.swift
//  Standups
//
//  Created by Nolin McFarland on 9/24/23.
//

import Foundation
import Tagged

struct Meeting: Identifiable, Equatable, Codable {
    let id: Tagged<Self, UUID>
    let date: Date
    var transcript: String
}
