//
//  UserAvatarURL.swift
//  IOS_LAB_2SEM
//

import Foundation

extension User {
    var avatarURL: URL? {
        let allowed = CharacterSet.urlQueryAllowed.subtracting(CharacterSet(charactersIn: "&=?"))
        let seed = username.addingPercentEncoding(withAllowedCharacters: allowed) ?? username
        return URL(string: "https://api.dicebear.com/7.x/avataaars/png?seed=\(seed)")
    }
}
