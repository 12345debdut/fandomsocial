//
//  PrimaryButtonWithTwoIconCapsule.swift
//  fandomsocial
//
//  Created by Debdut Saha on 17/12/25.
//

import SwiftUI

struct PrimaryButtonWithTwoIconCapsule: View {
    var leftIcon: String
    var text: String
    var rightIcon: String
    var action: () -> Void = {}
    var body: some View {
        ZStack {
            Color.white
            HStack {
                Color.clear.frame(width: 4)
                ZStack {
                    InnerConcaveCircle(size: 35)
                    Image(leftIcon)
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                Text(text)
                    .font(.system(size: 15, weight: Font.Weight.regular))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: rightIcon)
                    .font(.system(size: 20))
                    .padding(.trailing, 16)
            }
        }.clipShape(Capsule())
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PrimaryButtonWithTwoIconCapsule(
            leftIcon: "mobile", text: "Continue with Phone Number", rightIcon: "arrow.right"
        ).frame(maxWidth: .infinity, maxHeight: 60)
    }
}
