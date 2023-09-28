//
//  StandupsListViewModel.swift
//  Standups
//
//  Created by Nolin McFarland on 9/25/23.
//

import Combine
import Foundation
import SwiftUI

final class StandupsListViewModel: ObservableObject {
    @Published var destination: Destination? {
        didSet { self.bind() }
    }
    @Published var standups: [Standup]
    
    private var destinationCancellable: AnyCancellable?

    enum Destination {
        case add(EditStandupViewModel)
        case details(StandupDetailsViewModel)
    }

    init(
        destination: Destination? = nil,
        standups: [Standup] = []
    ) {
        self.destination = destination
        self.standups = standups
        self.bind()
    }

    func addStandupButtonTapped() {
        self.destination = .add(
            EditStandupViewModel(standup: Standup(id: Standup.ID(UUID())))
        )
    }

    func dismissAddStandupButtonTapped() {
        self.destination = nil
    }

    func confirmAddStandupButtonTapped() {
        defer { self.destination = nil }

        guard case let .add(editStandupViewModel) = self.destination
        else { return }
        var standup = editStandupViewModel.standup

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
    
    func standupTapped(standup: Standup) {
        self.destination = .details(StandupDetailsViewModel(standup: standup))
    }
    
    private func bind() {
        switch self.destination {
        case .details(let standupDetailsViewModel):
            standupDetailsViewModel.onConfirmDeletion = { [weak self, id = standupDetailsViewModel.standup.id] in
                guard let self else { return }
                withAnimation {
                    self.standups.removeAll { $0.id == id }
                    self.destination = nil
                }
                self.destinationCancellable = standupDetailsViewModel.$standup
                    .sink { [weak self] standup in
                        guard
                            let self,
                            let index = self.standups.firstIndex(where: { $0.id == standup.id })
                        else {
                            return
                        }
                        self.standups[index] = standup
                    }
            }
        case .add, .none:
            break
        }
    }
}
