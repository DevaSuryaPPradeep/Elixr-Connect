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
        VStack{
            Text("UserDetails View")
            List {
                ForEach(viewModelInstance.dataProvider,id: \.self) {
                    Text($0.userName)
                    Text($0.emailAddress)
                    Text($0.phoneNumber)
                }
            }
        }
        .onAppear(perform: {
            viewModelInstance.dataReceiver()
        })
    }
}

#Preview {
    UserDetailsView()
}
