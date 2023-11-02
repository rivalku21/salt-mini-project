//
//  Users.swift
//  SaltMiniProject
//
//  Created by Rival Fauzi on 02/11/23.
//

import Foundation

struct UserModel: Decodable {
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}

struct DataModel: Decodable {
    let data: [UserModel]
}

struct UserLoginModel: Codable {
    var email: String
    var password: String
}
