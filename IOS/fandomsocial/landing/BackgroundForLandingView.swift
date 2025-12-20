//
//  BackgroundForLanding.swift
//  fandomsocial
//
//  Created by Debdut Saha on 17/12/25.
//

import SwiftUI

struct BackgroundForLandingView: View {
    var body: some View {
        VStack {
            Image("partySelfie")
                .resizable()
                .frame(maxWidth: .infinity,maxHeight: UIScreen.main.bounds.height * 0.75)
            Spacer()
        }
    }
}

#Preview {
    BackgroundForLandingView()
}
