//
//  HomeMenuView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 24/12/25.
//
import SwiftUI

struct HomeMenuView: View {
    var isSelected: Bool = false
    var icon: ImageType
    var text: String
    var body: some View {
        VStack(spacing: 0) {
            makeImage(from: icon)
                .font(.system(size: 18))
                .foregroundColor(
                    isSelected ? Color.white : Color.white.opacity(0.7)
                )
            Color.clear.frame(height: 6)
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(
                    isSelected ? Color.white : Color.white.opacity(0.7)
                )
        }.frame(maxHeight: .infinity)
    }
}

#Preview {
    HStack {
        HomeMenuView(isSelected: true, icon: ImageType.SystemImage("heart"), text: "Love")
        HomeMenuView(isSelected: false, icon: ImageType.SystemImage("heart"), text: "Love")
    }.background(Color.black)
}
