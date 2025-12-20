//
//  TermsAndConditionView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 17/12/25.
//

import SwiftUI

struct TermsAndConditionView: View {
    var termsAndConditionText: AttributedString {
        var text = AttributedString("By Continuing, you confirm that, you have read, understood and agree to our Terms & Conditions")
        if let highLighedRange = text.range(of: "Terms & Conditions") {
            text[highLighedRange].foregroundColor = .white
            text[highLighedRange].font = .system(size: 13)
            text[highLighedRange].underlineStyle = .single
        }
        return text
    }
    var body: some View {
        Text(termsAndConditionText)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.white.opacity(0.5))
            .font(.system(size: 12))
            .padding(.horizontal, 16)
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        TermsAndConditionView()
    }
}
