//
//  ProfileControllerWrapper.swift
//  IOS_LAB_2SEM
//

import SwiftUI
import UIKit

struct ProfileControllerWrapper: UIViewControllerRepresentable {//связь между SwiftUI и UIKit
    @ObservedObject var viewModel: UsersViewModel
    let user: User

    func makeUIViewController(context: Context) -> ProfileViewController {
        let vc = ProfileViewController() //создаем контроллер
        vc.configure(user: user, followViewModel: viewModel) //настраиваем польз и подписку
        return vc
    }

    //обновление контроллера всегда когда меняются данные
    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        uiViewController.configure(user: user, followViewModel: viewModel) //обновляет инфу
    }
}
