//
//  MobileNumberOTPVerifyView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 19/12/25.
//

import SwiftUI

struct MobileNumberOTPVerifyView: View {
    private var mobileNumber: String
    private var router = Router.shared
    private var otpCount = 4
    @State var otp: String = ""
    @State var isFocused: Bool = false
    init(mobileNumber: String) {
        self.mobileNumber = mobileNumber
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
            Text("Enter code sent\nto your number")
                .font(.system(size: 40, weight: Font.Weight.semibold))
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            Color.clear.frame(height: 20)
            Text("We sent it to the number \(mobileNumber)")
                .font(.system(size: 15, weight: Font.Weight.regular))
                .foregroundColor(Color.white.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            Color.clear.frame(height: 50)
            
            // TextField with no keyboard (maintains cursor, copy/paste functionality)
            OTPTextFieldView(
                count: otpCount,
                otp: $otp,
                onOTPComplete: { completedOTP in
                    // OTP is complete, you can handle this if needed
                    router.pushAsFirstMember(.home(.member))
                },
                onFocusChange: { focused in
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        isFocused = focused
                    }
                }
            )
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 60)
            Color.clear.frame(height: 40)
            Button(action: {
                if otp.count == otpCount {
                    router.pushAsFirstMember(.home(.member))
                }
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
                            // Append number to OTP if not already complete
                            if otp.count < otpCount {
                                otp += number
                            }
                        },
                        onDeleteTap: {
                            if !otp.isEmpty {
                                otp.removeLast()
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
    MobileNumberOTPVerifyView(mobileNumber: "+91 9713054321")
}
