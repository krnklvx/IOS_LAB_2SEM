//
//  ProfileDetailView.swift
//  IOS_LAB_2SEM
//

import SwiftUI

struct ProfileDetailView: View {
    @ObservedObject var viewModel: UsersViewModel
    let user: User

    private var resolvedUser: User {
        viewModel.users.first(where: { $0.id == user.id }) ?? user
    }

    var body: some View {
        ProfileControllerWrapper(viewModel: viewModel, user: resolvedUser)
            .navigationBarTitleDisplayMode(.inline)
    }
}
