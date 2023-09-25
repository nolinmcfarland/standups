//
//  Theme.swift
//  Standups
//
//  Created by Nolin McFarland on 9/24/23.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable, Equatable, Hashable, Codable {
    case indigo
    case mint
    case rose

    var id: Self { self }

    var name: String { rawValue.capitalized }

    var mainColor: Color {
        switch self {
        case .indigo: .indigo
        case .mint: .mint
        case .rose: .pink
        }
    }

    var accentColor: Color {
        switch self {
        case .mint: .black
        case .indigo, .rose: .white
        }
    }
}
