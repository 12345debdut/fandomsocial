//
//  LandingView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 17/12/25.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        ZStack {
            BackgroundForLandingView()
            BlackOverlayLandingView()
            LandingContentView()
        }
    }
}


#Preview {
    LandingView()
}
