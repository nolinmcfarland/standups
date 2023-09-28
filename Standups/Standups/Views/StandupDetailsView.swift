//
//  StandupDetailsView.swift
//  Standups
//
//  Created by Nolin McFarland on 9/27/23.
//

import SwiftUI
import SwiftUINavigation

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
                            self.viewModel.meetingTapped(meeting: meeting)
                        } label: {
                            HStack {
                                Image(systemName: "calendar")
                                Text(meeting.date, style: .date)
                                Text(meeting.date, style: .time)
                            }
                        }
                    }
                    .onDelete { indices in
                        self.viewModel.deleteMeetings(atOffsets: indices)
                    }
                } header: {
                    Text("Past Meetings")
                }
            }
            if !self.viewModel.standup.attendees.isEmpty {
                Section {
                    ForEach(self.viewModel.standup.attendees) { attendee in
                        Label(attendee.name, systemImage: "person.crop.circle.fill")
                    }
                } header: {
                    Text("Attendees")
                }
                Button("Delete", role: .destructive, action: self.viewModel.deleteButtonTapped)
            }
        }
        .navigationTitle(self.viewModel.standup.title)
        .navigationDestination(
            unwrapping: self.$viewModel.destination,
            case: /StandupDetailsViewModel.Destination.meeting
        ) { $meeting in
            MeetingView(meeting: meeting, standup: self.viewModel.standup)
        }
        .alert(
            unwrapping: self.$viewModel.destination,
            case: /StandupDetailsViewModel.Destination.alert
        ) { action in
            guard let action else { return }
            self.viewModel.alertButtonTapped(action: action)
        }
    }
}

#Preview {
    NavigationStack {
        StandupDetailsView(viewModel: StandupDetailsViewModel(standup: .mock))
    }
}
