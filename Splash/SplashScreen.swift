//
//  ContentView.swift
//  Elixr-Connect
//
//  Created by Devasurya on 08/05/24.
//

import SwiftUI

/// Splash Screen.
struct SplashScreen: View {
    
    ///State property declaration.
    @State var isActive: Bool = false
    @State var isSignedIn: Bool = false
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        ZStack {
            Color.green
                .opacity(0.5)
                .ignoresSafeArea()
            if isActive {
                if isLoggedIn || isSignedIn {
                    UserDetailsView()
                }
                else {
                    LoginView(isLoginKey: $isLoggedIn, isSignKey: $isSignedIn)
                }
            }
            else {
                splashScreen
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                isActive.toggle()
            }
        })
    }
    
    /// View for the splash screen.
    private var splashScreen :some View {
        Image("Splash Screen")
            .ignoresSafeArea()
    }
}

#Preview {
    SplashScreen()
}
