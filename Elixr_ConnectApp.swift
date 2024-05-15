//
//  Elixr_ConnectApp.swift
//  Elixr-Connect
//
//  Created by Devasurya on 08/05/24.
//

import SwiftUI
import FBSDKCoreKit

@main
struct Elixr_ConnectApp: App {
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .onOpenURL { URLValue in
                    ApplicationDelegate.shared.application(UIApplication.shared, open: URLValue, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
                }
        }
    }
}
