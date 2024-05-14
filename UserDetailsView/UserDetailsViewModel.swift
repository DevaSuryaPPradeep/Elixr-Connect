//
//  UserDetailsViewModel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 09/05/24.
//

import Foundation
import UIKit

/// Viewmodel for the UserDetailsView.
class UserDetailsViewModel: ObservableObject  {
    
    ///Published property declaration.
    @Published var dataProvider :[UserModel] = []
    
    ///  Function to get data from the userdefaults.
    func dataReceiver()  {
        guard let savedUsersData =  UserDefaults.standard.data(forKey: .savedUsersId),
              let savedUsers = try? JSONDecoder().decode([UserModel].self, from: savedUsersData) else {
            return
        }
        dataProvider += savedUsers
        print("dataprovider---->\(dataProvider)")
    }
    
    /// Function to perform call functionality with responding numbers.
    /// - Parameter phoneNumber: Is of type String.
    func performCall(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
        else {
            print("error while initiating the calling feature")
        }
    }
    
    /// Function to connect the user with Microsoft teams app.
    func connectWithTeams(){
            let url = URL(string: "TeamsDemo://")!
        
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        }

//
//func connectWithTeams() {
//    let teamsURLString = "TeamsDemo://"
//    guard let teamsURL = URL(string: teamsURLString) else {
//        print("Invalid URL")
//        return
//    }
//    guard UIApplication.shared.canOpenURL(teamsURL) else {
//        print("Unable to open Microsoft Teams")
//        return
//    }
//    UIApplication.shared.open(teamsURL) { success in
//        if success {
//            print("Microsoft Teams opened successfully")
//        } else {
//            print("Failed to open Microsoft Teams")
//        }
//    }
//}

/// Function to connect the user with Microsoft teams app.
//func connectWithTeams() {
//    let url = URL(string: "TeamsDemo://")!
//
//     UIApplication.shared.open(url, options: [:], completionHandler: nil)
//}
//}
