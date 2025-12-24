//
//  NavigationScreen.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import Foundation

enum Route: Hashable {
    case landingscreen
    case mobilenumberinputscreen
    case mobileNumberOTPVerificationScreen(String)
    case home(UserType)
    case commentsection
}
