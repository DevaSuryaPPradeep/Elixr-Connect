//
//  SignupViewmodel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 08/05/24.
//

import Foundation

/// ViewModel for Signupview.
class SignupViewmodel: ObservableObject {

    ///Published property declaraions.
    @Published var dataArray: [SignupModel] = [.userName,.phoneNumber,.password,.confirmPassword]
    
    
    
}
