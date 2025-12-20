//
//  LandingContentView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 17/12/25.
//

import SwiftUI

struct LandingContentView: View {
    @StateObject var router: Router = Router.shared
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image("blueIcon")
                    .resizable()
                    .frame(width: 100, height: 100)
                VStack(spacing: 0) {
                    Text("StarGaze")
                        .font(.system(size: 25, weight: Font.Weight.bold))
                        .foregroundColor(Color.white)
                    Color.clear.frame(height: 10)
                    Text("Feel the magic of Every Moment")
                        .foregroundColor(Color.white.opacity(0.7))
                        .font(.system(size: 12, weight: Font.Weight.regular))
                        .multilineTextAlignment(.center)
                    Color.clear.frame(height: 24)
                    PrimaryButtonWithTwoIconCapsule(leftIcon: "mobile", text: "Continue with Phone Number", rightIcon: "arrow.right")
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .padding(.horizontal, 16)
                        .onTapGesture(perform: {
                            router.push(.mobilenumberinputscreen)
                        })
                    Color.clear.frame(height: 30)
                    Text("Or Continue as Guest")
                        .foregroundColor(Color.white)
                        .font(.system(size: 13, weight: Font.Weight.semibold))
                    Color.clear.frame(height: 30)
                    Color.gray.opacity(0.3).frame(height: 1).padding(.horizontal, 16)
                    Color.clear.frame(height: 30)
                    TermsAndConditionView()
                    Color.clear.frame(height: 20)
                }.offset(y: -20)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        LandingContentView()
    }
}
