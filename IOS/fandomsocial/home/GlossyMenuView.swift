//
//  GlossyMenuView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 24/12/25.
//

import SwiftUI

struct GlossyMenuView: View {
    var icon: ImageType
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.orange, .yellow],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            Color.white
                .clipShape(Circle())
                .padding(3)
            makeImage(from: icon)
                .font(.system(size: 14))
        }
        .frame(width: 45, height: 45)
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
    }
}

#Preview {
    VStack {
        GlossyMenuView(icon: ImageType.SystemImage("camera"))
    }.background(Color.black)
}
