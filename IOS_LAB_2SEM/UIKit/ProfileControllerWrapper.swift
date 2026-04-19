//
//  ProfileControllerWrapper.swift
//  IOS_LAB_2SEM
//

import SwiftUI
import UIKit

struct ProfileControllerWrapper: UIViewControllerRepresentable {
    @ObservedObject var viewModel: UsersViewModel
    let user: User

    func makeUIViewController(context: Context) -> ProfileViewController {
        let vc = ProfileViewController()
        vc.configure(user: user, followViewModel: viewModel)
        return vc
    }

    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        uiViewController.configure(user: user, followViewModel: viewModel)
    }
}
