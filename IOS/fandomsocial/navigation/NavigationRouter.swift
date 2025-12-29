//
//  NavigationRouter.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import Foundation
import SwiftUI
import os

struct NavigationRouter<Root>: View where Root : View {
    @ViewBuilder var contentView:() -> Root
    
    @ObservedObject private var router = Router.shared
    
    var body: some View {
        NavigationStack(path: $router.screens) {
            contentView()
                .navigationBarBackButtonHidden()
                .navigationDestination(for: Route.self) { screen in
                    switch screen {
                    case .landingscreen:
                        LandingView()
                    case .mobilenumberinputscreen:
                        MobileNumberView()
                    case .mobileNumberOTPVerificationScreen(let mobileNumber):
                        MobileNumberOTPVerifyView(mobileNumber: mobileNumber)
                    case .home(let userType):
                        HomeScreenView(userType: userType)
                    }
                }
        }
    }
}
