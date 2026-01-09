//
//  CommentSectionView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 29/12/25.
//

import SwiftUI
import os

struct CommentSectionView: View {
    @StateObject private var viewModel = CommentSectionViewModel()
    @State private var animatedSet = Set<String>()
    let animatedCount: Int = 4
    var body: some View {
        VStack(spacing: 0) {
            Text("Comments")
                .font(.system(size: 20, weight: Font.Weight.bold))
                .padding(.top, 24)
                .padding(.bottom, 30)
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.items) { item in
                        let isAnimated = animatedSet.contains(item.id)
                        CommentSectionItemView(item: item)
                        .opacity(isAnimated ? 1 : 0)
                        .offset(y: isAnimated ? 0 : 30)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
            CommentBoxView()
        }.task {
            viewModel.fetchData()
            let items = viewModel.items
            _ = await MainActor.run(body: {
                animatedSet.insert(items[0].id)
            })
            try? await Task.sleep(nanoseconds: 350_000_000)
            _ = await MainActor.run(body: {
                for index in 1..<animatedCount {
                    _ = withAnimation(.spring(duration: 0.35).delay(calculateDelayBasedOnIndex(index))) {
                        animatedSet.insert(items[index].id)
                    }
                }
                for index in animatedCount..<viewModel.items.count {
                    animatedSet.insert(items[index].id)
                }
            })
        }
    }
    
    private func calculateDelayBasedOnIndex(_ index: Int) -> Double {
        let delay = Double(index - 1) * 0.35
        guard delay > 0 else {
            return 0
        }
        return delay - 0.2
    }
}

struct CommentBoxView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.15),radius: 40)
            
            Color.white
                .clipShape(Capsule())
                .padding(4)
                .shadow(color: Color.black.opacity(0.1),radius: 2)
            
            HStack {
                Text("Comment as John Doe")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color.black.opacity(0.5))
                    .padding(.horizontal, 16)
                Spacer()
                Image("send")
                    .resizable()
                    .scaleEffect(2)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                    .overlay {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color.white)
                    }
                    .padding(.horizontal, 12)
            }
        }
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

struct CommentSectionItemView: View {
    var item: CommentSectionItem
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            LazyAssetImage(name: item.image, size: .init(width: 40, height: 40), scale: 3)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 6) {
                    Text(item.name)
                        .font(.system(size: 14, weight: .bold))
                    Text(item.date)
                        .foregroundColor(Color.black.opacity(0.6))
                        .font(.system(size: 14, weight: .regular))
                }
                Color.clear.frame(height: 8)
                Text(item.comment)
                    .font(.system(size: 13))
                    .foregroundColor(Color.black.opacity(0.8))
                
                Color.clear.frame(height: 16)
                HStack(spacing: 24) {
                    Text("\(item.likes) likes")
                        .font(.system(size: 12))
                        .foregroundColor(Color.black.opacity(0.6))
                    
                    Text("Reply")
                        .font(.system(size: 12))
                        .foregroundColor(Color.black.opacity(0.6))
                }
                Color.clear.frame(height: 20)
                HStack {
                    Color.black.opacity(0.4).frame(width: 30, height: 1)
                    Text("View \(item.replyCount) more replies")
                        .font(.system(size: 12))
                        .foregroundColor(Color.black.opacity(0.6))
                }
                Color.clear.frame(height: 20)
            }
            Image(systemName: item.isLiked ? "heart.fill" : "heart")
                .foregroundColor(Color.black.opacity(0.6))
                .font(.system(size: 18))
            
        }
    }
}

#Preview {
    CommentSectionView()
}
