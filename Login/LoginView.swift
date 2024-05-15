//
//  LoginView.swift
//  Elixr-Connect
//
//  Created by Devasurya on 08/05/24.
//

import SwiftUI
import FBSDKLoginKit

/// Login View.
struct LoginView: View {
    
    /// Stateobject declaration.
    @StateObject private var loginViewModelInstance: LoginViewModel = LoginViewModel()
    
    /// State property declarations
    @State private var userNameValue: String = ""
    @State private var passwordIdValue: String = ""
    @State private var alertMessage: String = ""
    @State private var isSignedUp: Bool = false
    @State private var isLoggedin: Bool = false
    @State private var alertBool: Bool = false
    
    /// Binding property declaration.
    @Binding var isLoginKey: Bool
    @Binding var isSignKey: Bool
    
    @AppStorage ("logged") var logged = false
    @AppStorage ("email") var email = ""
    @State var loginManager = LoginManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray
                    .opacity(0.5)
                    .ignoresSafeArea()
                VStack {
                    headingTitle
                    emailView
                    passwordView
                    loginButton
                    loginWithFacebook
                    signInPrompt
                }
            }
        }
    }
    
    /// View containing heading title.
    private var headingTitle: some View {
        Text ("Login")
            .font(.title)
    }
    
    /// View containing password field.
    private var emailView: some View {
        HStack {
            Image(systemName: "envelope")
                .padding(3)
            TextField("Type in your user name here", text: $userNameValue)
        }
        .frame(width: 300,height: 40)
        .background(Color.white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .cornerRadius(10.0)
        .padding()
    }
    
    /// View containing password field.
    private var passwordView: some View {
        HStack {
            Image(systemName: "lock")
                .padding(3)
            TextField("Type in your password here", text: $passwordIdValue)
        }
        .frame(width: 300,height: 40)
        .background(Color.white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .cornerRadius(10.0)
        .padding()
    }
    
    /// View containing the login button.
    private var loginButton: some View {
        Button {
            if  loginViewModelInstance.authenticateUserInputFields(usernameDetails:userNameValue , passwordDetails: passwordIdValue).isvalid {
                if  loginViewModelInstance.isUserAlreadyExist(userData: UserModel(userName: userNameValue, password: passwordIdValue, phoneNumber: "", emailAddress: "")) {
                    isLoggedin.toggle()
                }
            }
            else {
                self.alertMessage = loginViewModelInstance.authenticateUserInputFields(usernameDetails: userNameValue, passwordDetails: passwordIdValue).message ?? "Invalid Message"
                alertBool.toggle()
            }
        }label: {
            Text("Login")
                .foregroundStyle(Color.white)
                .bold()
                .frame(width: 300, height: 30)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
        .alert(isPresented: $alertBool, content: {
            Alert(title: Text("Alert"),message: Text(alertMessage))
        })
        .navigationDestination(isPresented: $isLoggedin) {
            UserDetailsView()
        }
    }
    
    /// View containg signup button.
    private var signInPrompt: some View {
        HStack{
            Text("Don't have an account?")
            Button {
                isSignedUp.toggle()
            }label: {
                Text("Sign up")
            }
            .navigationDestination(isPresented: $isSignedUp) {
                SignupView( isSignedUp: $isSignKey)
            }
        }
    }
    
    private var loginWithFacebook: some View {
        Button {
            if logged {
                loginManager.logOut()
                email = ""
                logged = false
            }
            else {
                loginManager.logIn(permissions: ["public_Profile","email"], from: nil) { (result, errorValue) in
                    guard let errorValue = errorValue else {
                        print(errorValue?.localizedDescription ?? "")
                        return
                    }
                    
                    guard let result = result, !result.isCancelled else {
                        return
                    }
                    logged = true
                    let request = GraphRequest(graphPath: "me", parameters: ["Field" : "email"])
                    request.start { _, returnedResult, _ in
                        guard let profileData = returnedResult as? [String:Any] else {return}
                        email = profileData["email"] as? String ?? "Invalid mail"
                    }                    
                }
            }
        }label: {
            Text("Login with Facebook")
                .foregroundStyle(Color.white)
                .bold()
                .frame(width: 300, height: 30)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
        
    }
}

