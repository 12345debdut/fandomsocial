//
//  HomeScreenView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import SwiftUI

struct HomeScreenView: View {
    var userType: UserType = .guest
    @Environment(\.imageScale) private var safeAreaInsets
    var body: some View {
        ZStack {
            // MARK: BG Image
            GeometryReader { proxy in
                Image("homeBgImage")
                    .resizable()
                    .scaledToFill()
                    // Fill the available space to avoid white gaps at edges
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            }
            .ignoresSafeArea(.all)
            
            // MARK: Top header
            VStack {
                // MARK: Header section
                HomeHeaderView()
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                // MARK: Profile and comment section
                HStack(alignment: .bottom) {
                    // MARK: Profile section
                    ProfileSectionView()
                    
                    Color.clear.frame(width: 16)
                    
                    // MARK: Comment section
                    VStack(spacing: 16) {
                        
                        VStack(spacing: 8) {
                            Image(systemName: "heart")
                                 .font(.system(size: 20))
                            
                            Text("2.5K")
                                .font(.system(size: 14))
                        }
                        .frame(width: 45, height: 80)
                        .foregroundColor(Color.white)
                        .background(Color.secondaryColor.opacity(0.8))
                        .clipShape(Capsule())

                        VStack(spacing: 8) {
                            Image(systemName: "ellipsis.message.fill")
                                 .font(.system(size: 20))
                            
                            Text("6.4K")
                                .font(.system(size: 14))
                        }
                        .frame(width: 45, height: 80)
                        .foregroundColor(Color.white)
                        .background(Color.secondaryColor.opacity(0.8))
                        .clipShape(Capsule())
                        
                        Image("share")
                             .resizable()
                             .scaledToFill()
                             .frame(width: 45, height: 45)
                             .foregroundColor(Color.white)
                             .background(Color.secondaryColor.opacity(0.8)
                             .clipShape(Circle()))
                        
                        Image(systemName:"paperplane")
                             .font(.system(size: 15))
                             .frame(width: 45, height: 45)
                             .foregroundColor(Color.white)
                             .background(Color.secondaryColor.opacity(0.8).clipShape(Circle()))
                       
                        Image(systemName:"ellipsis")
                            .rotationEffect(Angle(degrees: 90))
                            .font(.system(size: 15))
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color.white)
                            .background(Color.secondaryColor.opacity(0.8).clipShape(Circle()))
                            
                    }
                }.padding(.horizontal, 16)
                
                Color.clear.frame(height: 10)
                
                LazyHGrid(rows: [GridItem(.flexible())]) {
                    HomeMenuView(isSelected: true, icon: "house.fill", text: "Home")
                        .frame(maxHeight: .infinity)
                    
                    HomeMenuView(icon: "squares.leading.rectangle", text: "Main Stage")
                        .frame(maxHeight: .infinity)
                    
                    GlossyMenuView()
                        .frame(maxHeight: .infinity)
                    
                    HomeMenuView(icon: "shield.fill", text: "Backstage")
                        .frame(maxHeight: .infinity)
                    
                    HomeMenuView(icon: "person", text: "Profile")
                        .frame(maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(Color.secondaryColor.opacity(0.9))
                .clipShape(Capsule())
                .padding(.horizontal, 16)
            }
        }
    }
}

struct GlossyMenuView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct HomeMenuView: View {
    var isSelected: Bool = false
    var icon: String
    var text: String
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: Font.Weight.bold))
                .foregroundColor(
                    isSelected ? Color.white : Color.white.opacity(0.7)
                )
            Color.clear.frame(height: 2)
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(
                    isSelected ? Color.white : Color.white.opacity(0.7)
                )
        }
    }
}

#Preview {
    HomeScreenView()
}
