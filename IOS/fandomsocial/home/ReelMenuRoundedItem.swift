//
//  ReelMenuRoundedItem.swift
//  fandomsocial
//
//  Created by Debdut Saha on 24/12/25.
//

import SwiftUI

struct ReelMenuRoundedItem: View {
    var icon: ImageType
    var angle: Angle = Angle.degrees(0)
    var action: () -> Void = {}
    var body: some View {
        switch icon {
        case .CustomImage(_):
            makeImage(from: icon)
                 .resizable()
                 .scaledToFill()
                 .frame(width: 45, height: 45)
                 .foregroundColor(Color.white)
                 .background(Color.secondaryColor.opacity(0.8)
                 .clipShape(Circle()))
        case .SystemImage(_):
            makeImage(from: icon)
                 .rotationEffect(angle)
                 .frame(width: 45, height: 45)
                 .foregroundColor(Color.white)
                 .background(Color.secondaryColor.opacity(0.8)
                 .clipShape(Circle()))
        }
    }
}

#Preview {
    ReelMenuRoundedItem(icon: ImageType.SystemImage("heart"))
}
