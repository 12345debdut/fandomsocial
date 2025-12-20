//
//  BlackOverlayLandingView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 17/12/25.
//

import SwiftUI

struct BlackOverlayLandingView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            LinearGradient(
                  gradient: Gradient(colors: [
                      .clear,
                      .black.opacity(0.1),
                      .black.opacity(0.25),
                      .black.opacity(0.5),
                      .black
                  ]),
                  startPoint: .top,
                  endPoint: .bottom
              )
            .blendMode(.overlay)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            Color.black
                  .frame(maxWidth: .infinity, maxHeight: 280)
        }.ignoresSafeArea()
    }
}

#Preview {
    BlackOverlayLandingView()
}
