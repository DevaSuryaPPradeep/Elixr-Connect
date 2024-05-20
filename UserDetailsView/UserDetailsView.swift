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
    
    /// Stateobject decalrations.
    @StateObject private var viewModelInstance: UserDetailsViewModel = UserDetailsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModelInstance.dataProvider, id: \.self) {details in
                HStack{
                    Image("Icon1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50,height: 50)
                        .clipped()
                        .clipShape(Circle())
                    Text(details.userName)
                        .bold()
                    Spacer()
                    Image(systemName: "phone.fill")
                        .onTapGesture {
                            viewModelInstance.performCall(phoneNumber: details.phoneNumber)
                        }
                }
            }
            .listStyle(.inset)
        }
        List(viewModelInstance.friends,id: \.self) {fetchedDetails in
            Text(fetchedDetails)
        }
        .onAppear(perform: {
            viewModelInstance.fetchFriendList(cursor: nil)
        })
        .navigationTitle(Text("User Details View."))
    }
}

#Preview {
    UserDetailsView()
}
