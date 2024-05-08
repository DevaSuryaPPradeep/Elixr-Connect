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
    
    var body: some View {
        Text("Signup")
            .font(.title)
        
    }
    
    /// User
    private var userInputFields :some View {
        List(viewmodelInstance.dataArray,id: \.self) {
            detail in
        }
    }
    
    private var  userInteractiveArea: some View {
        HStack {
            
        }
    }
}
//struct signUpFields :View {
//    let spModel :SignUpModel
//    @State var isHidden: Bool = false
//    @Binding var  textValue :String
//    var body: some View {
//        HStack{
//            IconImage(imageValue: spModel.iconImage)
//                .font(.title3)
//                .padding()
//            VStack(alignment: .leading, content: {
//                Text(spModel.title)
//                if spModel.isVisible {
//                    HStack{
//                        if isHidden {
//                            passwordField(passwordVariable: $textValue, placeHolder: spModel.placeHolder)
//                        }
//                        else{
//                            Textfields(bindingVariable: $textValue, placeholder: spModel.placeHolder)
//                        }
//                        Button {
//                            isHidden.toggle()
//                        }label: {
//                            Image(systemName: isHidden ? "eye" : "eye.slash")
//                                .foregroundStyle(Color.black)
//                        }
//                    }
//                }
//                else {
//                    Textfields(bindingVariable: $textValue, placeholder: spModel.placeHolder)
//                }
//                })
//        }




#Preview {
    SignupView()
}
