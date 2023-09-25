//
//  StandupsList.swift
//  Standups
//
//  Created by Nolin McFarland on 9/24/23.
//

import SwiftUI
import SwiftUINavigation

struct StandupsListView: View {
    @ObservedObject var viewModel: StandupsListViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(self.viewModel.standups) { standup in
                    CardView(standup: standup)
                        .listRowBackground(
                            standup.theme.mainColor
                                .overlay(
                                    LinearGradient(
                                        colors: [.white.opacity(0.3), .clear],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                }
            }
            .toolbar {
                Button(action: self.viewModel.addStandupButtonTapped) {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("Daily Standups")
            .sheet(
                unwrapping: self.$viewModel.destination,
                case: /StandupsListViewModel.Destination.add
            ) { $standup in
                EditStandupView(standup: $standup)
            }
        }
    }
}

struct CardView: View {
    let standup: Standup

    var body: some View {
        VStack(alignment: .leading) {
            Text(self.standup.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(self.standup.attendees.count)", systemImage: "person.3")
                Spacer()
                Label(self.standup.duration.formatted(.units()), systemImage: "clock")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(self.standup.theme.accentColor)
    }
}

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}

#Preview {
    StandupsListView(viewModel: StandupsListViewModel(standups: [.mock]))
}
