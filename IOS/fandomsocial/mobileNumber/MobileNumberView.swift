//
//  MobileNumberView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import SwiftUI

struct MobileNumberView: View {
    var router = Router.shared
    @State var mobileNumber: String = ""
    @State var isFocused: Bool = false
    
    // Pre-create keypad handlers to avoid closure creation overhead
    private func handleNumberTap(_ number: String) {
        if isFocused {
            mobileNumber += number
        }
    }
    
    private func handleDeleteTap() {
        if isFocused && !mobileNumber.isEmpty {
            mobileNumber.removeLast()
        }
    }
    
    private func handleChevronTap() {
        isFocused = false
    }
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "arrow.backward")
                .font(.system(size: 20, weight: Font.Weight.medium))
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    router.pop()
                }
                .padding(.horizontal, 20)
            Color.clear.frame(height: 30)
            Text("Enter your\nmobile number")
                .font(.system(size: 40, weight: Font.Weight.semibold))
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            Color.clear.frame(height: 20)
            Text("We will send you a confirmation code")
                .font(.system(size: 14, weight: Font.Weight.regular))
                .foregroundColor(Color.white.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            Color.clear.frame(height: 50)
            
            // TextField with no keyboard (maintains cursor, copy/paste functionality)
            NoKeyboardTextField(
                text: $mobileNumber,
                isFocused: $isFocused,
                placeholder: "Enter your number",
                onTap: {}
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 60)
            .padding(.horizontal, 16)
            .background(
                Color.secondaryColor
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            )
            .padding(.horizontal, 20)
            Color.clear.frame(height: 40)
            Button(action: {
                router.push(.mobileNumberOTPVerificationScreen(mobileNumber))
            }, label: {
                Text("Next")
                    .font(.system(size: 20, weight: Font.Weight.medium))
                    .frame(maxWidth: .infinity)
                    .padding(12)
                    .background(Color.accent.clipShape(Capsule()))
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 20)
            })
            Color.clear.frame(height: 30)
            
            Spacer()
            
            // Keypad - always rendered to avoid first-load hitch
            NumericKeypad(
                onNumberTap: handleNumberTap,
                onDeleteTap: handleDeleteTap,
                onChevronTap: handleChevronTap
            )
            .padding(.horizontal, 20)
            .opacity(isFocused ? 1.0 : 0.0)
            .offset(y: isFocused ? 0.0 : 100.0)
            .allowsHitTesting(isFocused)
            .accessibilityHidden(!isFocused)
            // No animation on first appearance to eliminate hitch
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isFocused)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.black)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MobileNumberView()
}
