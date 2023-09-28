//
//  StandupDetailsView.swift
//  Standups
//
//  Created by Nolin McFarland on 9/27/23.
//

import SwiftUI

struct StandupDetailsView: View {
    @ObservedObject var viewModel: StandupDetailsViewModel
    
    var body: some View {
        List {
            Section {
                Button {
                    // ..
                } label: {
                    Label("Start meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundStyle(Color.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text(self.viewModel.standup.duration.formatted(.units()))
                }
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(self.viewModel.standup.theme.rawValue.capitalized)
                        .font(.headline)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .foregroundStyle(self.viewModel.standup.theme.accentColor)
                        .background(self.viewModel.standup.theme.mainColor)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            } header: {
                Text("Standup Info")
            }
            if !self.viewModel.standup.meetings.isEmpty {
                Section {
                    ForEach(self.viewModel.standup.meetings) { meeting in
                        Button {
                            // ..
                        } label: {
                            HStack {
                                Image(systemName: "calendar")
                                Text(meeting.date, style: .date)
                                Text(meeting.date, style: .time)
                            }
                        }
                    }
                    .onDelete { indices in
                        // ..
                    }
                } header: {
                    Text("Past Meetings")
                }
            }
            if !self.viewModel.standup.attendees.isEmpty {
                Section {
                    ForEach(self.viewModel.standup.attendees) { attendee in
                        HStack {
                            Text(attendee.name)
                        }
                    }
                } header: {
                    Text("Attendees")
                }
                Button("Delete", role: .destructive) {
                    // ..
                }
            }
        }
        .navigationTitle(self.viewModel.standup.title)
    }
}

#Preview {
    NavigationStack {
        StandupDetailsView(viewModel: StandupDetailsViewModel(standup: .mock))
    }
}
