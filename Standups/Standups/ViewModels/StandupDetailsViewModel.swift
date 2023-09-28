//
//  StandupDetailsViewModel.swift
//  Standups
//
//  Created by Nolin McFarland on 9/27/23.
//

import SwiftUI
import SwiftUINavigation
import XCTestDynamicOverlay

// MARK: - ViewModel

final class StandupDetailsViewModel: ObservableObject {
    @Published var destination: Destination?
    @Published var standup: Standup
    
    var onConfirmDeletion: () -> Void = unimplemented("StandupDetailModel.onConfirmDeletion")
    
    enum AlertAction {
        case confirmDeletion
    }
    
    enum Destination {
        case alert(AlertState<AlertAction>)
        case edit(EditStandupViewModel)
        case meeting(Meeting)
    }
    
    init(
        destination: Destination? = nil,
        standup: Standup
    ) {
        self.destination = destination
        self.standup = standup
    }
    
    func deleteMeetings(atOffsets indices: IndexSet) {
        self.standup.meetings.remove(atOffsets: indices)
    }
    
    func meetingTapped(meeting: Meeting) {
        self.destination = .meeting(meeting)
    }
    
    func deleteButtonTapped() {
        self.destination = .alert(.delete)
    }
    
    func alertButtonTapped(action: AlertAction) {
        switch action {
        case .confirmDeletion: self.onConfirmDeletion()
        }
    }
    
    func editButtonTapped() {
        self.destination = .edit(EditStandupViewModel(standup: self.standup))
    }
    
    func cancelEditButtonTapped() {
        self.destination = nil
    }
    
    func doneEditingButtonTapped() {
        guard case let .edit(viewModel) = self.destination else { return }
        self.standup = viewModel.standup
        self.destination = nil
    }
}

// MARK: - AlertState Extension

extension AlertState where Action == StandupDetailsViewModel.AlertAction {
    static let delete = AlertState {
        TextState("Delete standup?")
    } actions: {
        ButtonState(role: .destructive, action: .confirmDeletion) {
            TextState("Yes")
        }
        ButtonState(role: .cancel) {
            TextState("Cancel")
        }
    } message: {
        TextState("This action can't be undone.")
    }
}
