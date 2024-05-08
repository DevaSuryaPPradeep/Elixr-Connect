//
//  LoginView.swift
//  Elixr-Connect
//
//  Created by Devasurya on 08/05/24.
//

import SwiftUI

/// Login View.
struct LoginView: View {
    
    /// State property declarations
    @State var emailIdValue: String = ""
    @State var passwordIdValue: String = ""
    
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.5)
                .ignoresSafeArea()
            VStack {
                headingTitle
                emailView
                passwordView
                loginButton
                signInPrompt
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
            TextField("Type in your email here", text: $emailIdValue)
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
            
        }label: {
            Text("Login")
                .foregroundStyle(Color.white)
                .bold()
                .frame(width: 300, height: 30)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
    }
    
    /// View containg signup button.
    private var signInPrompt: some View {
        HStack{
            Text("Don't have an account?")
            Button {
                
            }label: {
                Text("Sign up")
            }
        }
    }
}

#Preview {
    LoginView()
}
