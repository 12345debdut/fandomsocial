//
//  ContentView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 17/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // Depending on login it should display the home and the login screen
        NavigationRouter {
            LandingView()
        }
    }
}

#Preview {
    ContentView()
}
