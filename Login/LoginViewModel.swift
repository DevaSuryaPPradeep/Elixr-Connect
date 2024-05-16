//
//  LoginViewModel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 10/05/24.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

/// Login View Model.
class LoginViewModel:ObservableObject {
    
    /// Declaration of @published property.
    @Published var dataSource: [UserModel] = []
    @Published var isloggedIn: Bool = false
    @Published var facebookLoginModel: FaceboookLoginModel = FaceboookLoginModel(first_name: "", name: "", email: "")
    @Published var isAuth: Bool = true
    @Published var errorMessage: String = ""
    
    /// Declaration to acess LoginManager.
    let loginManager: LoginManager = LoginManager()
    
    
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
    
    /// Function to facilitate login with facebook  funcitonality.
    func loginWithFacebook() {
        self.isAuth = false
        guard let config = LoginConfiguration(permissions: [.publicProfile, .email], tracking: .limited) else {
            print("Configuration failed")
            return
        }
        loginManager.logIn(configuration: config) { completion in
            switch completion {
            case .success(granted:let grantedPermissions, declined:let declinedPermissions , token:let accessToken):
                print(" Logged in! \(grantedPermissions) \(declinedPermissions) accessToken--->\(String(describing: accessToken))")
                self.isloggedIn.toggle()
            case .cancelled:
                print("User cancelled login.")
            case .failed(let returnedError):
                self.errorMessage = returnedError.localizedDescription
                
                GraphRequest(graphPath: "me", parameters: ["field" : "id, name, first_name, email"]).start { (connection,result, error) in
                    if error == nil {
                        let fbProfileDetails = result as? NSDictionary
                        print(" FB details \(String(describing: fbProfileDetails))")
                        self.isAuth = true
                        self.facebookLoginModel.email = fbProfileDetails?.value(forKey: "email") as? String ?? "Invalid email"
                        self.facebookLoginModel.first_name = fbProfileDetails?.value(forKey: "first_name") as? String ?? "Invalid first_name"
                        self.facebookLoginModel.id = fbProfileDetails?.value(forKey: "id") as? String ?? "Invalid id"
                        if let token = AccessToken.current ,!token.isExpired {
                            print("Token = \(token.tokenString)")
                        }
                        else {
                            print("No valid token found or token is expired")
                        }
                    }
                    else {
                        print("Unexpected result:\(String(describing: result))")
                    }
                }
            }
        }
    }
}






//
//    func logout() {
//        self.facebookLoginModel.email = ""
//        self.facebookLoginModel.first_name = ""
//        self.facebookLoginModel.id = ""
//        self.facebookLoginModel.name = ""
//    }
//}
//    func loginWithFacebook() {
//        guard let config = LoginConfiguration(permissions: [.publicProfile, .email], tracking: .limited) else {
//            print("Configuration failed")
//            return
////        }
//        loginManager.logIn(configuration: config) { completion in
//            switch completion {
//            case .success(granted: let grandedSet, declined: let declainedSet, token: let token):
//                print("grandSet--->\(grandedSet),declainedSet--->\(declainedSet) ,token--->\(String(describing: token))")
//                if ((token?.isExpired) == nil) {
//                    self.isloggedIn.toggle()
//                }
//            case .failed(let error):
//                print(error.localizedDescription)
//            case .cancelled:
//                print("Cancelled")
//            }
//        }
