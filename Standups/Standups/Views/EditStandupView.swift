//
//  EditStandupView.swift
//  Standups
//
//  Created by Nolin McFarland on 9/25/23.
//

import SwiftUI
import SwiftUINavigation

struct EditStandupView: View {
    enum Field: Hashable {
        case attendee(Attendee.ID)
        case title
    }

    @FocusState var focus: Field?
    @Binding var standup: Standup

    var body: some View {
        Form {
            Section {
                TextField("Title", text: self.$standup.title)
                    .focused(self.$focus, equals: .title)
                HStack {
                    Slider(value: self.$standup.duration.seconds, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    Spacer()
                    Text(self.standup.duration.formatted(.units()))
                }
                ThemePicker(selection: self.$standup.theme)
            } header: {
                Text("Standup Info")
            }
            Section {
                ForEach(self.$standup.attendees) { $attendee in
                    TextField("Name", text: $attendee.name)
                        .focused(self.$focus, equals: .attendee(attendee.id))
                }
                .onDelete { indices in
                    self.standup.attendees.remove(atOffsets: indices)
                    if self.standup.attendees.isEmpty {
                        self.standup.attendees.append(
                            Attendee(id: Attendee.ID(UUID()), name: "")
                        )
                    }
                    self.focus = .attendee(self.standup.attendees[indices.first!].id)
                }
                Button("New attendee") {
                    let attendee = Attendee(id: Attendee.ID(UUID()), name: "")
                    self.standup.attendees.append(attendee)
                    self.focus = .attendee(attendee.id)
                }
            } header: {
                Text("Attendees")
            }
        }
        .onAppear {
            if self.standup.attendees.isEmpty {
                self.standup.attendees.append(
                    Attendee(id: Attendee.ID(UUID()), name: "")
                )
            }
            self.focus = .title
        }
    }
}

struct ThemePicker: View {
    @Binding var selection: Theme

    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                Label(theme.name, systemImage: "paintpalette")
                    .foregroundStyle(theme.mainColor)
                    .tag(theme)
            }
        }
    }
}

extension Duration {
    fileprivate var seconds: Double {
        get { Double(self.components.seconds / 60) }
        set { self = .seconds(newValue * 60) }
    }
}

#Preview {
    WithState(initialValue: Standup.mock) { $standup in
        EditStandupView(standup: $standup)
    }
}
