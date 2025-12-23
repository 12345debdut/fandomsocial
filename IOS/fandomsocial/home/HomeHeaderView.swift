//
//  HomeHeaderView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 23/12/25.
//


//
//  HomeHeaderView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 23/12/25.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        HStack {
            Color.secondaryColor.opacity(0.7)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay {
                    Image(systemName: "magnifyingglass")
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color.white)
                }
            HStack(spacing: 20) {
                Text("For You")
                    .font(.system(size: 14, weight: Font.Weight.bold))
                    .foregroundColor(Color.white)
                Text("Scouters")
                    .font(.system(size: 12))
                    .foregroundColor(Color.white)
                Text("Trackings")
                    .font(.system(size: 12))
                    .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity)
            Color.secondaryColor.opacity(0.7)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay {
                    Image(systemName: "tray")
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(Color.white)
                }
            Image(systemName: "ellipsis")
                .rotationEffect(Angle.degrees(90))
                .frame(width: 6, height: 10)
                .foregroundColor(Color.white)
            Spacer()
        }
    }
}

#Preview {
    HomeHeaderView()
        .background(Color.gray)
}