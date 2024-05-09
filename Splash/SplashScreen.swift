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
    
    var body: some View {
        ZStack {
            Color.green
                .opacity(0.5)
                .ignoresSafeArea()
            if isActive {
                LoginView()
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
