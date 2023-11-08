//
//  AuthModel.swift
//  BauBuddyVERO
//
//  Created by Murat on 7.11.2023.
//

import Foundation

// MARK: - Welcome
struct Auth: Codable {
    let oauth: Oauth
    let userInfo: UserInfo
    let permissions: [String]
    let apiVersion: String
    let showPasswordPrompt: Bool
}

// MARK: - Oauth
struct Oauth: Codable {
    let accessToken: String
    let expiresIn: Int
    let tokenType: String
    let scope: String?
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case scope
        case refreshToken = "refresh_token"
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let personalNo: Int
    let firstName, lastName, displayName: String
    let active: Bool
    let businessUnit: String
}
