//
//  LoginViewModel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 10/05/24.
//

import Foundation

/// Login View Model.
class LoginViewModel:ObservableObject {
    
    /// Declaration of @published property.
    @Published var dataSource: [UserModel] = []
    
    /// Function to authenticate user interactive textfields in the view
    /// - Parameters:
    ///   - usernameDetails: Collects the user response in the username field.
    ///   - passwordDetails: Collects the password response in the password field.
    /// - Returns: Returns  a tuple of a boolean value and a String value.
    func authenticateUserInputFields(usernameDetails: String?, passwordDetails: String?) -> (isvalid: Bool, message: String?) {
        guard let username = usernameDetails , !username.isEmpty else {
            return (false, "UserName Can't be Empty")
        }
        guard let password = passwordDetails , !password.isEmpty else {
            return (false,"Password  field cannot be empty")
        }
        return (true, nil)
    }
    
    /// Function to check whether the credentials typed in by the user matches the credentials in the storage.
    /// - Parameter userData: Is of type UserModel which will be collecting the userInput.
    /// - Returns: Returns a boolean value based on the presense of the user credentials in the data retieved from the userDefaults.
    func isUserAlreadyExist(userData: UserModel) -> Bool {
        dataSource = getSavedUsers()
        let isUserAlreadyExist = dataSource.contains(where: {$0.userName == userData.userName && $0.password == userData.password})
        print("isUserAlreadyExist--->\(isUserAlreadyExist)")
        return isUserAlreadyExist
    }
    
    /// Function to get the old users .
    /// - Returns: Returns an array of UserModel that will store the user details while signing up.
    func getSavedUsers() ->[UserModel] {
        guard let savedUsersData = UserDefaults.standard.data(forKey: .savedUsersId),let savedUsers = try?JSONDecoder().decode([UserModel].self, from: savedUsersData) else {
            return []
        }
        print("SavedUsers--->\(savedUsers)")
        return savedUsers
    }
}
