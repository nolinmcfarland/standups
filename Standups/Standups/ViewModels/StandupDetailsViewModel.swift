//
//  StandupDetailsViewModel.swift
//  Standups
//
//  Created by Nolin McFarland on 9/27/23.
//

import SwiftUI

final class StandupDetailsViewModel: ObservableObject {
    @Published var standup: Standup
    
    init(standup: Standup) {
        self.standup = standup
    }
}
