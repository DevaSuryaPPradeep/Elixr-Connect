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
            HStack {
                ForEach(viewModelInstance.dataProvider,id: \.self) {
                    details in
                    Text(details.userName)
                    Text(details.emailAddress)
                    Text(details.phoneNumber)
                }
                .listStyle(.inset)
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
