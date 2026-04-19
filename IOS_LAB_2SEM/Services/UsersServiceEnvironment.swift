//
//  UsersServiceEnvironment.swift
//  IOS_LAB_2SEM
//

import SwiftUI

private enum UsersServiceKey: EnvironmentKey {
    static let defaultValue: (any UsersService)? = nil
}

extension EnvironmentValues {
    var usersServiceOverride: (any UsersService)? {
        get { self[UsersServiceKey.self] }
        set { self[UsersServiceKey.self] = newValue }
    }
}
