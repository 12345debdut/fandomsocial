//
//  CrossModalView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 29/12/25.
//

import SwiftUI

struct CrossModalView<Content: View>: View {
    @Binding var shown: Bool
    let content: Content
    @State private var contentVisible: Bool = false
    
    init(shown: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._shown = shown
        self.content = content()
    }

    var body: some View {
        let viewShown: Binding<Bool> = Binding<Bool>(
            get: {
                return shown
            }, set: { visible in
                if visible {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.spring(bounce: 0.3)) {
                            contentVisible = true
                        }
                    }
                } else {
                    withAnimation(.spring(duration: 0.3)) {
                        contentVisible = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: {
                        shown = false
                    })
                }
            }
        )
        if viewShown.wrappedValue == true {
            ZStack {
                Color.black.opacity(0.6).ignoresSafeArea()
                    .onTapGesture {
                        viewShown.wrappedValue = false
                    }
                if contentVisible {
                    VStack(spacing: 0) {
                        Color.clear.frame(height: 40)
                        Color.white.frame(width: 60, height: 60).clipShape(Circle()).overlay {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: Font.Weight.medium))
                        }.onTapGesture {
                            viewShown.wrappedValue = false
                        }
                        Color.clear.frame(height: 8)
                        VStack {
                            content
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white.cornerRadius(20))
                        .padding(.horizontal, 12)
                    }.transition(AnyTransition.move(edge: .bottom))
                }
            }.onAppear {
                viewShown.wrappedValue = true
            }
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
        } else {
            
        }
    }
}

#Preview {
    CrossModalView(shown: .constant(true)) {
        Text("Hello, World!")
    }
}
