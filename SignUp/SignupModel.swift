//
//  SignupModel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 08/05/24.
//

import Foundation

/// Model for SignupModel.
enum SignupModel {
    case userName
    case emailAddress
    case phoneNumber
    case password
    case confirmPassword
}

extension SignupModel {
    
    /// A computed property used to declare Title for each fields.
    var title: String {
        switch self {
        case .userName:
            return "User Name"
        case .emailAddress:
            return "Email Address"
        case .phoneNumber:
            return "Phone Number"
        case .password:
            return "Password"
        case .confirmPassword:
            return "Re-enter Password"
            
        }
    }
    
    /// A computed property to declare the placeholder for  each fields.
    var placeHolder: String {
        switch self {
        case .userName:
            return "Enter the username here."
        case .emailAddress:
            return "Enter the Email here."
        case .phoneNumber:
            return "Enter the contact number here."
        case .password:
            return "Enter the password here."
        case .confirmPassword:
            return "Re-enter the password here."
            
        }
    }
    
    /// A computed property to declare the icon image value for each fields.
    var iconImage: String {
        switch self {
        case .userName:
            return "person"
        case .emailAddress:
            return "mail.stack"
        case .phoneNumber:
            return  "phone"
        case .password:
            return "lock"
        case .confirmPassword:
            return "lock"
            
        }
    }
    
    /// A computed property to declare the icon image for
    var isVisible: Bool {
        switch self {
        case .userName,.phoneNumber, .emailAddress:
            return false
        case .password,.confirmPassword:
            return  true
        }
    }
}
