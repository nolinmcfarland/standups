//
//  MeetingView.swift
//  Standups
//
//  Created by Nolin McFarland on 9/27/23.
//

import SwiftUI

struct MeetingView: View {
    let meeting: Meeting
    let standup: Standup
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                ForEach(self.standup.attendees) { attendee in
                    Label(attendee.name, systemImage: "person.crop.circle.fill")
                }
                Text("Transcript")
                    .font(.headline)
                    .padding(.top)
                Text(self.meeting.transcript)
            }
        }
        .navigationTitle(Text(self.meeting.date, style: .date))
        .padding()
    }
}

#Preview {
    NavigationStack {
        MeetingView(meeting: Standup.mock.meetings[0], standup: .mock)
    }
}
