//
//  UserDetailsViewModel.swift
//  Elixr-Connect
//
//  Created by Devasurya on 09/05/24.
//

import Foundation
import FBSDKCoreKit


/// Viewmodel for the UserDetailsView.
class UserDetailsViewModel: ObservableObject  {
    
    ///Published property declaration.
    @Published var dataProvider :[UserModel] = []
    @Published var friends: [String] = []
    
    ///  Function to get data from the userdefaults.
    func dataReceiver()  {
        guard let savedUsersData =  UserDefaults.standard.data(forKey: .savedUsersId),
              let savedUsers = try? JSONDecoder().decode([UserModel].self, from: savedUsersData) else {
            return
        }
        dataProvider += savedUsers
        print("dataprovider---->\(dataProvider)")
    }
    
    /// Function to combine two type of arrays together to iterate over a list.
    /// - Returns: returns an array of UserDetails.
    func combineDataSource() -> [UserDetail]{
        return  zip(dataProvider, friends).map { UserDetail(userModel: $0, phoneNumber: $1)
        }
    }
    
    /// Function to perform call functionality with responding numbers.
    /// - Parameter phoneNumber: Is of type String.
    func performCall(phoneNumber: String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
                print("Success")
            }
            else {
                print("can't open the url with phone number:\(phoneNumber)")
            }
        }
        else {
            print("error while initiating the calling feature")
        }
    }
    
    
    /// Function to fetch friends list from a facebook and to call the dataReceiver() functionality.
    func fetchFriendList(cursor: String?) {
        dataReceiver()
        if AccessToken.current != nil {
            var params = [String: String]()
            params["fields"] = "id,name,picture,first_name,last_name,middle_name"
            let request: GraphRequest = GraphRequest(graphPath: "me/friends", parameters: params, httpMethod: .get)
            request.start { (_, result, error) in
                if let error = error {
                    print("\(String(error.localizedDescription))")
                }
                else {
                    if let data = result as? [String: Any] {
                        if let friends = data["data"] as? [Any] {
                            for friend in friends {
                                if let info = friend as? [String: Any],
                                   let id = info["id"],
                                   let name = info["name"],
                                   let picture = info["picture"] as? [String: Any],
                                   let pictureData = picture["data"] as? [String: Any],
                                   let url = pictureData["url"] {
                                    print("id: \(id)\nname:\(name)\nurl:\(url)")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

/// Model for list in user details view.
struct UserDetail: Identifiable {
    let id = UUID()
    let userModel: UserModel
    let phoneNumber: String
}



