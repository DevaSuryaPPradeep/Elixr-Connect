//
//  UserDetailsViewModel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 09/05/24.
//

import Foundation

/// Viewmodel for the UserDetailsView.
class UserDetailsViewModel: ObservableObject  {
    
    ///Published property declaration.
    @Published var dataProvider :[UserModel] = []
    
    ///  Function to get data from the userdefaults.
    @MainActor
    func dataReceiver()  {
        guard let savedUsersData =  UserDefaults.standard.data(forKey: .savedUsersId),
              let savedUsers = try? JSONDecoder().decode([UserModel].self, from: savedUsersData) else {
           return
        }
        dataProvider += savedUsers
        print("dataprovider---->\(dataProvider)")
    }
}
