//
//  EditStandupViewModel.swift
//  Standups
//
//  Created by Nolin McFarland on 9/25/23.
//

import Foundation

final class EditStandupViewModel: ObservableObject {
    @Published var focus: EditStandupView.Field?
    @Published var standup: Standup
    
    init(
        focus: EditStandupView.Field? = .title,
        standup: Standup
    ) {
        self.focus = focus
        self.standup = standup
        
        if self.standup.attendees.isEmpty {
            self.standup.attendees.append(
                Attendee(id: Attendee.ID(UUID()), name: "")
            )
        }
    }
    
    func newAttendeeButtonTapped() {
        let attendee = Attendee(id: Attendee.ID(UUID()), name: "")
        self.standup.attendees.append(attendee)
        self.focus = .attendee(attendee.id)
    }
    
    func deleteAttendee(atOffsets indices: IndexSet) {
        self.standup.attendees.remove(atOffsets: indices)
        if self.standup.attendees.isEmpty {
            self.standup.attendees.append(
                Attendee(id: Attendee.ID(UUID()), name: "")
            )
        }
        let index = min(indices.first!, self.standup.attendees.count - 1)
        self.focus = .attendee(self.standup.attendees[index].id)
    }
}
