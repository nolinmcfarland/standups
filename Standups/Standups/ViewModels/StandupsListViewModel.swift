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

    func dismissAddStandupButtonTapped() {
        self.destination = nil
    }

    func confirmAddStandupButtonTapped() {
        defer { self.destination = nil }

        guard case var .add(standup) = self.destination
        else { return }

        standup.attendees.removeAll {
            $0.name.allSatisfy(\.isWhitespace)
        }
        if standup.attendees.isEmpty {
            standup.attendees.append(
                Attendee(id: Attendee.ID(UUID()), name: "")
            )
        }
        self.standups.insert(standup, at: 0)
    }
}
