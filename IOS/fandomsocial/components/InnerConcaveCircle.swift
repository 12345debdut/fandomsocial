//
//  InnerConcaveCircle.swift
//  fandomsocial
//
//  Created by Debdut Saha on 17/12/25.
//

import SwiftUI

struct InnerConcaveCircle: View {
    var size: CGFloat
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color.white,
                        Color(.systemGray6)
                    ]),
                    center: .center,
                    startRadius: 50,
                    endRadius: size / 2
                )
            )
            .overlay(
                // Dark inner shadow (bottom-right)
                Circle()
                    .stroke(Color.black.opacity(0.25), lineWidth: 4)
                    .blur(radius: 6)
                    .offset(x: 4, y: 4)
                    .mask(Circle())
            )
            .overlay(
                // Light inner highlight (top-left)
                Circle()
                    .stroke(Color.white.opacity(0.9), lineWidth: 4)
                    .blur(radius: 6)
                    .offset(x: -4, y: -4)
                    .mask(Circle())
            )
            .frame(width: size, height: size)
    }
}

#Preview {
    InnerConcaveCircle(size: 40)
}
