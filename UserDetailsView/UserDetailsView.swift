//
//  UserDetailsView.swift
//  Elixr-Connect
//
//  Created by Devasurya on 09/05/24.
//

import SwiftUI
import CoreTelephony

/// View
struct UserDetailsView: View {
    
    /// Stateobjecct decalrations.
    @StateObject var viewModelInstance: UserDetailsViewModel = UserDetailsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModelInstance.dataProvider,id: \.self) {
                details in
                roundedRectangleView
                    .overlay {
                        VStack{
                            Text("Username")
                                .bold()
                            Text(details.userName)
                            Spacer()
                            HStack {
                                VStack{
                                    Text("Email Address")
                                        .bold()
                                    Text(details.emailAddress)
                                        .font(.subheadline)
                                }
                                Spacer()
                                VStack{
                                    Text("Personal Number")
                                        .bold()
                                    Text(details.phoneNumber)
                                        .font(.subheadline)
                                }
                                Button {
                                    viewModelInstance.performCall(phoneNumber: details.phoneNumber)
                                }
                            label: {
                                Image(systemName: "phone.fill")
                                    .foregroundStyle(Color.cyan)
                            }
                                Spacer()
                                Text("Teams")
                                    .onTapGesture {
                                        viewModelInstance.connectWithTeams()
                                    }
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .listStyle(.inset)
            }
            .navigationTitle(Text("User Details View."))
        }
        .onAppear(perform: {
            viewModelInstance.dataReceiver()
        })
    }
    
    /// View representing rounded rectangle view.
    private var roundedRectangleView: some View{
        RoundedRectangle(cornerRadius: 10.0)
            .stroke(style: StrokeStyle())
            .frame(width: 340,height: 260)
    }
   
}
