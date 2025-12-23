//
//  ProfileSectionView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 23/12/25.
//


//
//  ProfileSectionView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 23/12/25.
//

import SwiftUI

struct ProfileSectionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Image("homeBgImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2))
                            .frame(width: 46, height: 46)
                            .foregroundColor(Color.gray)
                    }
                    .overlay(alignment: .bottom) {
                        Color.gray.opacity(0.8)
                            .clipShape(Circle())
                            .overlay {
                                Text("U")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 20, height: 20)
                            .offset(y: 10)
                    }
                Color.clear.frame(width: 16, height: 6)
                VStack(alignment: .leading, spacing: 0) {
                    Text("airbazoo")
                        .font(.system(size: 16, weight: Font.Weight.semibold))
                        .foregroundColor(Color.white)
                    Color.clear.frame(width: 10, height: 6)
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "bookmark.circle")
                            .font(.system(size: 12))
                            .foregroundColor(Color.white)
                        Text("125000")
                            .font(.system(size: 12))
                            .foregroundColor(Color.white.opacity(0.7))
                        
                    }
                }
                Color.clear.frame(width: 12, height: 6)
                Button(action: {}, label: {
                    Text("Follow")
                        .font(.system(size: 14))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                })
                    .background(Color.accent)
                    .clipShape(Capsule())
                    
            }
            Color.clear.frame(height: 24)
            Text("I will serve as your make up artist, visit my website to know more")
                .font(.system(size: 18, weight: Font.Weight.semibold))
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundColor(Color.white)
            Color.clear.frame(height: 12)
            Text("Design eye-catching Instagram Story templates and content to boost engagement")
                .font(.system(size: 15))
                .foregroundColor(Color.white.opacity(0.6))
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileSectionView()
        .padding(20)
        .background(Color.black)
}