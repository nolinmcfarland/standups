//
//  Attendee.swift
//  Standups
//
//  Created by Nolin McFarland on 9/24/23.
//

import Foundation
import Tagged

struct Attendee: Identifiable, Equatable, Codable {
    let id: Tagged<Self, UUID>
    var name: String
}
