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
                onTap: {
                    // Show custom keypad
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        isFocused = true
                    }
                }
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
            
            ZStack(alignment: .bottom) {
                if !isFocused {
                    Spacer()
                }
                
                if isFocused {
                    NumericKeypad(
                        onNumberTap: { number in
                            mobileNumber += number
                        },
                        onDeleteTap: {
                            if !mobileNumber.isEmpty {
                                mobileNumber.removeLast()
                            }
                        },
                        onChevronTap: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                isFocused = false
                            }
                        }
                    )
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
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
