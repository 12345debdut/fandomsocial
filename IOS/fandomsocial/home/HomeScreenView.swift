//
//  HomeScreenView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import SwiftUI

enum BottomMenuItem: Identifiable, Hashable {
    case ImageText(ImageType, String)
    case Glossy(ImageType)

    var id: String {
        switch self {
        case let .ImageText(icon, text):
            return "imageText_\(icon)_\(text)"
        case let .Glossy(icon):
            return "glossy_\(icon)"
        }
    }
}

enum ReelOptions: Identifiable, Hashable {
    case ImageText(ImageType, String)
    case Image(ImageType)
    case RotatedImage(ImageType, Angle)

    var id: String {
        switch self {
        case let .ImageText(icon, text):
            return "imageText_\(icon)_\(text)"
        case let .Image(icon):
            return "image_\(icon)"
        case let .RotatedImage(icon, angle):
            return "rotatedImage_\(icon)_\(angle.degrees)"
        }
    }
}

struct HomeScreenView: View {
    var userType: UserType = .guest
    @State private var selectedIndex: Int = 0
    @State private var menuItems: [BottomMenuItem] = [.ImageText(ImageType.SystemImage("house.fill"), "Home"), .ImageText(ImageType.SystemImage("squares.leading.rectangle"), "Main Stage"),.Glossy(ImageType.SystemImage("camera")), .ImageText(ImageType.SystemImage("shield.fill"), "Backstage"), .ImageText(ImageType.SystemImage("person"), "Profile")]
    
    @State private var reelOptions: [ReelOptions] = [
        .ImageText(ImageType.SystemImage("heart"), "2.5K"), .ImageText(ImageType.SystemImage("ellipsis.message.fill"), "6.4K"), .Image(ImageType.CustomImage("share")), .Image(ImageType.SystemImage("paperplane")), .RotatedImage(ImageType.SystemImage("ellipsis"), Angle.degrees(90))
    ]
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
                        ForEach(reelOptions, id: \.id) { item in
                            switch item {
                            case let .ImageText(icon, text):
                                ReelMenuItem(icon: icon, text: text)
                            case let .Image(icon):
                                ReelMenuRoundedItem(icon: icon)
                            case let .RotatedImage(icon, angle):
                                ReelMenuRoundedItem(icon: icon, angle: angle)
                            }
                        }
                    }
                }.padding(.horizontal, 16)
                
                Color.clear.frame(height: 10)
                HStack(spacing: 0) {
                    ForEach(Array(menuItems.enumerated()), id: \.element.id) { index, item in
                        switch item {
                        case let .ImageText(icon, text):
                            HomeMenuView(isSelected: selectedIndex == index, icon: icon, text: text)
                                .frame(maxHeight: .infinity, alignment: .center)
                                .onTapGesture { selectedIndex = index }
                        case let .Glossy(icon):
                            GlossyMenuView(icon: icon)
                                .frame(maxHeight: .infinity, alignment: .center)
                                .onTapGesture { selectedIndex = index }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 65)
                .background(Color.secondaryColor.opacity(0.9))
                .clipShape(Capsule())
                .padding(.horizontal, 16)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeScreenView()
}
