//
//  SignupViewModel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 08/05/24.
//

import Foundation

/// ViewModel for Signupview.
class SignupViewModel: ObservableObject {
    
    ///Published property declaraions.
    @Published var dataArray: [SignupModel] = [.userName,.emailAddress,.phoneNumber,.password,.confirmPassword]
    @Published var dataSource: [UserModel] = []
    
    /// Function to authenticate user inputs.
    /// - Parameters:
    ///   - userNameDetails: Is  a container that points to the value typed in the user name textfield.
    ///   - emailAddressDetails: Is a container that points to the value typed in the email address textfield.
    ///   - passwordDetails: Is a container that points to the value typed in the password textfield.
    ///   - phoneNumberDetails: is a container to hold the value typed in the phone number field.
    ///   - confirmPassword: is a container to hold the value typed in the confirmpassword field.
    /// - Returns: Return a tuple containing a boolean value and a string.
    func authenticate(userNameDetails: String?, emailAddressDetails: String?,passwordDetails: String?,phoneNumberDetails: String?,confirmPassword: String?)-> (isValid: Bool,message: String?) {
        guard let userNameDetails = userNameDetails ,!userNameDetails.isEmpty else {
            return (false,"Username cannot be empty")
        }
        guard let emailAddressDetails = emailAddressDetails , emailAddressDetails.isValidEmail() else {
            return (false, "Type in a valid email address.")
        }
        guard let phoneNumberDetails =  phoneNumberDetails , !phoneNumberDetails.isEmpty else {
            return (false, "Invalid phone number.")
        }
        guard let  password = passwordDetails,!password.isEmpty  else {
            return(false,"Password field is empty.")
        }
        guard password.count >= 8  else{
            return (false, "Password must be of lenght 8.")
        }
        guard isAlphanumeric(password) else{
            return (false, "Password must contain alphanumeric characters.")
        }
        guard  password == confirmPassword else{
            return (false,"Please make sure your password matches.")
        }
        return(true,nil)
    }
    
    /// Function itself calls multiple function to check whether the user  already exist or not, if present it will iniates the process of persisting the value inside an array.
    /// - Parameter modelInstance: This is the model of data expecting after the user types in their info in the signup page.
    /// - Returns: Returns a string value.
    func addToMemory(modelInstance:UserModel?)-> (isValid: Bool,message: String?) {
        dataSource = getSavedUsers()
        guard let modelInstance = modelInstance , !checkOldUser(userData: modelInstance) else {
            return (false,"User name already taken, type in a unique one.")
        }
        dataSource.append(modelInstance)
        persistData(inputData: dataSource)
        return(true,"User creation successfull.")
    }
    
    /// Function check whether a user is already existed or not .
    /// - Parameter userData: This is the model that the user getting
    /// - Returns: Returns a boolean value while specific user is present or not.
    func checkOldUser(userData: UserModel) -> Bool {
        let isUserAlreadyExist = dataSource.contains(where: {$0.userName == userData.userName})
        return isUserAlreadyExist
    }
    
    /// Function to get the old users .
    /// - Returns: Returns an array of UserModel that will store the user details while signing up.
    func getSavedUsers() ->[UserModel] {
        guard let savedUsersData = UserDefaults.standard.data(forKey: .savedUsersId),let savedUsers = try?JSONDecoder().decode([UserModel].self, from: savedUsersData) else {
            return []
        }
        return savedUsers
    }
    
    /// Function to enode data to the userdefaults against a value.
    /// - Parameter inputData: Takes in a array of UserModel.
    func persistData(inputData:[UserModel]) {
        do {
            let dataToBeSaved = try JSONEncoder().encode(inputData)
            UserDefaults.standard.set(dataToBeSaved, forKey: .savedUsersId)
        }
        catch {
            print("error while encoding.")
        }
    }
    
    /// isAlphanumeric - fuction is used to perform alphanumeric authentications.
    /// - Parameter string:type String received from the password textfield
    /// - Returns: return is of type  bool
    func isAlphanumeric(_ string: String) -> Bool {
        let letterSet = CharacterSet.letters
        let digitSet = CharacterSet.decimalDigits
        return !string.isEmpty && string.rangeOfCharacter(from: letterSet) != nil && string.rangeOfCharacter(from: digitSet) != nil
    }
}

extension String {
    
    /// A static varible to store the userdefault key
    static var savedUsersId = "savedUsersId"
    
    /// Function to validate mail ID .
    /// - Returns: A boolean value based on validity of the mail.
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$", options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        guard ((regex.firstMatch(in: self, options: [], range: range) ) == nil)  else {
            return true
        }
        return false
    }
}
