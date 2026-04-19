//
//  ContentView.swift
//  IOS_LAB_2SEM
//
//  Created by krnklvx on 03.04.2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.usersServiceOverride) private var serviceFromEnv

    var body: some View {
        UsersScreen(service: serviceFromEnv)
    }
}

#Preview {
    ContentView()
}
