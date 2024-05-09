//
//  UserModel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 09/05/24.
//

import Foundation

/// Model
struct UserModel: Codable,Hashable {
    let userName: String
    let password: String
    let phoneNumber: String 
    let emailAddress: String
}
