//
//  EditStandupViewModelTests.swift
//  StandupsTests
//
//  Created by Nolin McFarland on 9/25/23.
//

import XCTest
@testable import Standups

final class EditStandupViewModelTests: XCTestCase {
    typealias SUT = EditStandupViewModel
    
    func testDeleteAttendee() {
        let sut = SUT(
            standup: Standup(
                id: Standup.ID(UUID()),
                attendees: [
                    Attendee(id: Attendee.ID(UUID()), name: "Nolin"),
                    Attendee(id: Attendee.ID(UUID()), name: "Nolin Jr")
                ]
            )
        )
        sut.deleteAttendee(atOffsets: [0])
        
        XCTAssertEqual(sut.standup.attendees.count, 1)
        XCTAssertEqual(sut.standup.attendees[0].name, "Nolin")
        XCTAssertEqual(sut.focus, .attendee(sut.standup.attendees[0].id))
    }
    
    func testAddAttendee() {
        let sut = SUT(
            standup: Standup(
                id: Standup.ID(UUID()),
                attendees: []
            )
        )
        
        XCTAssertEqual(sut.standup.attendees.count, 1)
        XCTAssertEqual(sut.focus, .title)
        
        sut.newAttendeeButtonTapped()
        
        XCTAssertEqual(sut.standup.attendees.count, 2)
        XCTAssertEqual(sut.focus, .attendee(sut.standup.attendees[1].id))
    }
}
