//
//  UserDetailsView.swift
//  Elixr-Connect
//
//  Created by Devasurya on 09/05/24.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject var viewModelInstance: UserDetailsViewModel = UserDetailsViewModel()
    var body: some View {
        
        List {
            ForEach(viewModelInstance.dataProvider,id: \.self) {
                details in
                RoundedRectangle(cornerRadius: 10.0)
                    .stroke(style: StrokeStyle())
                    .frame(width: 340,height: 260)
                    .overlay {
                        VStack{
                            Image(systemName: "person")
                                .resizable()
                                .clipShape(Circle())
                                .scaledToFit()
                                .frame(width: 50,height: 50)
                            Text("Username")
                                .bold()
                            Text(details.userName)
                                .padding()
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
}

#Preview {
    UserDetailsView()
}
