//
//  LoginViewModel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 10/05/24.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

/// Login view model.
class LoginViewModel:ObservableObject {
    
    /// Declaration to acess LoginManager.
    let loginManager: LoginManager = LoginManager()
    
    /// Declaration of @published property.
    @Published var isAuth: Bool = true
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var dataSource: [UserModel] = []
    @Published var facebookLoginModel: FaceboookLoginModel = FaceboookLoginModel(first_name: "", name: "", email: "")
    
    
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
        AccessToken.current = nil
        Profile.current = nil
        print("SavedUsers--->\(savedUsers)")
        return savedUsers
    }
    
    /// Function To  faciltate login with facebook functionality.
    func loginWithFacebookWithPermissions() {
        print("User logged out from Facebook")
        print("isLoggedIn--->\(isLoggedIn),AccessToken---->\(String(describing: AccessToken.current)),profile--->\(String(describing: Profile.current))")
        let configuredPermissions:[String] = ["public_profile","user_friends","email"]
        loginManager.logIn(permissions: configuredPermissions, from: nil) { [weak self] loginResult, resulantError in
            guard let self = self else {
                return
            }
            if resulantError != nil {
                print("resulantError----->\(String(describing: resulantError))")
            }
            else if let loginResult = loginResult, !loginResult.isCancelled {
                print("grantedPermissions--->\(loginResult.grantedPermissions),declinedPermissions-----> \(loginResult.declinedPermissions), \((loginResult.isCancelled)),token----->\(String(describing: loginResult.token?.tokenString)) ")
                self.isLoggedIn.toggle()
                GraphRequest(graphPath: "me/friends", parameters: ["fields": "id, name, first_name, email"]).start(completion: { (connection, result, error) in
                    if error == nil{
                        let fbProfileDetails = result as! NSDictionary
                        print("DEBUG: FB details \(fbProfileDetails)")
                        self.facebookLoginModel.email = fbProfileDetails.value(forKey: "email") as? String ?? "Invalid email"
                        self.facebookLoginModel.id = fbProfileDetails.value(forKey: "id") as? String ??  "invalid id"
                        self.facebookLoginModel.name = fbProfileDetails.value(forKey: "name") as? String ?? "Invalid name"
                        if let token = AccessToken.current, !token.isExpired {
                            print("DEBUG: Token=\(token.tokenString)")
                        }
                    }
                }
                ) }
            else {
                if let cancelled = loginResult?.isCancelled {
                    cancelled ?  print("User cancelled the login."): print("Failed with error \(String(describing: resulantError?.localizedDescription))")
                }
            }
        }
    }
    
    /// Function to perform log out funtionality.
    func logOut() {
        loginManager.logOut()
        self.isLoggedIn = false
        self.facebookLoginModel = FaceboookLoginModel(first_name: "", name: "", email: "") // Reset the model
        AccessToken.current = nil
        Profile.current = nil
        print("User logged out from Facebook")
        print("isLoggedIn--->\(isLoggedIn),AccessToken---->\(String(describing: AccessToken.current)),profile--->\(String(describing: Profile.current))")
    }
}

