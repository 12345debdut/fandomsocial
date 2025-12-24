//
//  ReelMenuItem.swift
//  fandomsocial
//
//  Created by Debdut Saha on 24/12/25.
//
import SwiftUI

struct ReelMenuItem: View {
    var icon: ImageType
    var text: String
    var action: () -> Void = {}
    var body: some View {
        VStack(spacing: 8) {
            makeImage(from: icon)
                 .font(.system(size: 20))
            
            Text(text)
                .font(.system(size: 14))
        }
        .frame(width: 45, height: 80)
        .foregroundColor(Color.white)
        .background(Color.secondaryColor.opacity(0.8))
        .clipShape(Capsule())
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    ReelMenuItem(icon: ImageType.SystemImage("heart"), text: "2.5K")
}
