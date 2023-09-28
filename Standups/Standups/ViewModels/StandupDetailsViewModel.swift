//
//  StandupDetailsViewModel.swift
//  Standups
//
//  Created by Nolin McFarland on 9/27/23.
//

import SwiftUI

final class StandupDetailsViewModel: ObservableObject {
    @Published var destination: Destination?
    @Published var standup: Standup
    
    enum Destination {
        case meeting(Meeting)
    }
    
    init(
        destiantion: Destination? = nil,
        standup: Standup
    ) {
        self.destination = destiantion
        self.standup = standup
    }
    
    func deleteMeetings(atOffsets indices: IndexSet) {
        self.standup.meetings.remove(atOffsets: indices)
    }
    
    func meetingTapped(meeting: Meeting) {
        self.destination = .meeting(meeting)
    }
}
