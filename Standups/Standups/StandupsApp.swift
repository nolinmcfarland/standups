//
//  StandupsApp.swift
//  Standups
//
//  Created by Nolin McFarland on 9/24/23.
//

import SwiftUI

@main
struct StandupsApp: App {
    var body: some Scene {
        WindowGroup {
            StandupsListView(
                viewModel: StandupsListViewModel(
//                    destination: .details(
//                        StandupDetailsViewModel(
//                            destination: .alert(.delete),
//                            standup: .mock
//                        )
//                    ),
                    standups: [.mock]
                )
            )
        }
    }
}
