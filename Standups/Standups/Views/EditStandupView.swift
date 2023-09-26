//
//  EditStandupView.swift
//  Standups
//
//  Created by Nolin McFarland on 9/25/23.
//

import SwiftUI
import SwiftUINavigation

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
        self.focus = .attendee(self.standup.attendees[indices.first!].id)
    }
}


struct EditStandupView: View {
    enum Field: Hashable {
        case attendee(Attendee.ID)
        case title
    }

    @ObservedObject var viewModel: EditStandupViewModel
    @FocusState var focus: Field?

    var body: some View {
        Form {
            Section {
                TextField("Title", text: self.$viewModel.standup.title)
                    .focused(self.$focus, equals: .title)
                HStack {
                    Slider(value: self.$viewModel.standup.duration.seconds, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    Spacer()
                    Text(self.viewModel.standup.duration.formatted(.units()))
                }
                ThemePicker(selection: self.$viewModel.standup.theme)
            } header: {
                Text("Standup Info")
            }
            Section {
                ForEach(self.$viewModel.standup.attendees) { $attendee in
                    TextField("Name", text: $attendee.name)
                        .focused(self.$focus, equals: .attendee(attendee.id))
                }
                .onDelete { indices in
                    self.viewModel.deleteAttendee(atOffsets: indices)
                }
                Button("New attendee", action: self.viewModel.newAttendeeButtonTapped)
            } header: {
                Text("Attendees")
            }
        }
        .bind(self.$viewModel.focus, to: self.$focus)
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
    EditStandupView(viewModel: EditStandupViewModel(standup: .mock))
}
