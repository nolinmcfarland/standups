//
//  EditStandupView.swift
//  Standups
//
//  Created by Nolin McFarland on 9/25/23.
//

import SwiftUI
import SwiftUINavigation

struct EditStandupView: View {
    @Binding var standup: Standup

    var body: some View {
        Form {
        }
    }
}

#Preview {
    WithState(initialValue: Standup.mock) { $standup in
        EditStandupView(standup: $standup)
    }
}
