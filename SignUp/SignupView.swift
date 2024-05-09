//
//  SignupView.swift
//  Elixr-Connect
//
//  Created by Devasurya on 08/05/24.
//

import SwiftUI

/// View for SignupView
struct SignupView: View {
    
    /// Stateobject declarations
    @StateObject var viewmodelInstance: SignupViewmodel = SignupViewmodel()
    
    /// State property declarations.
    @State var userInputReceiver: String = ""
    @State var phoneNumber: String = ""
    @State var userName: String = ""
    @State var password: String = ""
    @State var emailAddress: String = ""
    @State var confirmPassword: String = ""
    @State var hidePasswordBool: Bool = false
    @State var alertMessage: String = ""
    @State var returnedMessage: String = ""
    @State var AlertBooleanVariable: Bool = false
    
    var body: some View {
        Text("Sign up")
            .font(.title)
        userInputFields
        signUpButton
    }
    
    /// User input fields.
    private var userInputFields :some View {
        List(viewmodelInstance.dataArray,id: \.self) {
            detail in signUpFields(spModel: detail, textValue: setupSignup(for: detail))
        }
    }
    
    /// Private function to alot Binding property for each fields.
    /// - Parameter variable: Is of type SignupModel .
    /// - Returns: Returns a binding property depending upon the fields.
    private func setupSignup (for variable :SignupModel)->Binding<String> {
        switch variable {
        case .userName:
            return $userName
        case .emailAddress:
            return $emailAddress
        case .phoneNumber:
            return $phoneNumber
        case .password:
            return $password
        case .confirmPassword:
            return $confirmPassword
        }
    }
    
    /// View for representing sign up button.
    private var signUpButton: some View {
        Button {
            let validationResult = viewmodelInstance.authenticate(userNameDetails: userName, emailAddressDetails: emailAddress, passwordDetails: password, phoneNumberDetails: phoneNumber, confirmPassword: confirmPassword)
            if validationResult.isValid {
                self.alertMessage =     viewmodelInstance.addToMemory(modelInstance: UserModel(userName: userName, password: password, phoneNumber: phoneNumber, emailAddress: emailAddress)) ?? "Invalid Message"
                AlertBooleanVariable.toggle()
            }
            else {
                self.alertMessage = validationResult.message ?? "Invalid Message.."
                AlertBooleanVariable.toggle()
            }
        }label: {
            Text("Sign up")
                .foregroundStyle(Color.white)
                .bold()
                .frame(width: 300, height: 30)
                .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))     
        }
        .alert(isPresented: $AlertBooleanVariable, content: {
            Alert(title: Text("Message"),message:Text(alertMessage))
        })
    }
}

/// This is the view created for Four different fields with four different binding property.
struct signUpFields :View {
    let spModel :SignupModel
    @State var isHidden: Bool = false
    @Binding var  textValue :String
    var body: some View {
        HStack{
            Image(systemName:  spModel.iconImage)
                .font(.title3)
                .padding()
            VStack(alignment: .leading, content: {
                Text(spModel.title)
                if spModel.isVisible {
                    HStack{
                        if isHidden {
                            TextField(spModel.placeHolder, text: $textValue)
                        }
                        else{
                            SecureField(spModel.placeHolder, text: $textValue)
                        }
                        Button {
                            isHidden.toggle()
                        }label: {
                            Image(systemName: isHidden ? "eye" : "eye.slash")
                                .foregroundStyle(Color.black)
                        }
                    }
                }
                else {
                    TextField(spModel.placeHolder, text: $textValue)
                }
            })
        }
    }
}

#Preview {
    SignupView()
}
