//
//  User.swift
//  IOS_LAB_2SEM
//

import Foundation

/// Модель пользователя под Json https://jsonplaceholder.typicode.com/users
struct User: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
