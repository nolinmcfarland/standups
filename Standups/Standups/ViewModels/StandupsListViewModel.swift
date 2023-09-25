//
//  StandupsListViewModel.swift
//  Standups
//
//  Created by Nolin McFarland on 9/25/23.
//

import Foundation

final class StandupsListViewModel: ObservableObject {
    @Published var destination: Destination?
    @Published var standups: [Standup]

    enum Destination {
        case add(Standup)
    }

    init(
        destination: Destination? = nil,
        standups: [Standup] = []
    ) {
        self.destination = destination
        self.standups = standups
    }

    func addStandupButtonTapped() {
        self.destination = .add(Standup(id: Standup.ID(UUID())))
    }
}
