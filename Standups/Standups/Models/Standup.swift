//
//  Standup.swift
//  Standups 
//
//  Created by Nolin McFarland on 9/24/23.
//

import Foundation
import Tagged

struct Standup: Identifiable, Equatable, Codable {
    let id: Tagged<Self, UUID>
    var attendees = [Attendee]()
    var duration: Duration = .seconds(60 * 5)
    var meetings = [Meeting]()
    var theme: Theme = .mint
    var title = ""

    var durationPerAttendee: Duration {
        self.duration / self.attendees.count
    }
}

extension Standup {
    static let mock = Self(
        id: Standup.ID(UUID()),
        attendees: [
            Attendee(id: Attendee.ID(UUID()), name: "Blob"),
            Attendee(id: Attendee.ID(UUID()), name: "Blob Jr"),
            Attendee(id: Attendee.ID(UUID()), name: "Blob Sr"),
            Attendee(id: Attendee.ID(UUID()), name: "Blob Esq"),
            Attendee(id: Attendee.ID(UUID()), name: "Blob III"),
            Attendee(id: Attendee.ID(UUID()), name: "Blob I"),
        ],
        duration: .seconds(60),
        meetings: [
            Meeting(
                id: Meeting.ID(UUID()),
                date: .now.addingTimeInterval(-60 * 60 * 24 * 7),
                transcript: """
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor \
                incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud \
                exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure \
                dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. \
                Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt \
                mollit anim id est laborum.
                """
            )
        ],
        theme: .rose,
        title: "Design"
    )
}
