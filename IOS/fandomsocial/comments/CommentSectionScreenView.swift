//
//  CommentSectionScreenView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 24/12/25.
//

import SwiftUI
import os

struct CommentSectionScreenView: View {
    @Binding var shown: Bool
    var body: some View {
        CrossModalView(shown: $shown, content: {
            CommentSectionView()
        })
    }
}

#Preview {
    CommentSectionScreenView(shown: .constant(true))
}
