//
//  OTPTextFieldView.swift
//  fandomsocial
//
//  Created by Debdut Saha on 20/12/25.
//

import SwiftUI

struct OTPTextFieldView: View {
    // Required parameters
    let count: Int
    @Binding var otp: String
    
    // Optional customization parameters
    var spacing: CGFloat = 16
    var underlineHeight: CGFloat = 4
    var underlineColor: Color = Color.accent
    var underlineOpacity: Double = 0.8
    var textColor: Color = .white
    var fontSize: CGFloat = 24
    var fontWeight: Font.Weight = .semibold
    var horizontalPadding: CGFloat = 16
    
    // Callbacks
    var onOTPComplete: ((String) -> Void)? = nil
    var onFocusChange: ((Bool) -> Void)? = nil
    
    // Internal state
    @State private var number: [String] = []
    @State private var isFocused: Bool = false
    @State private var focusedIndex: Int = 0
    @State private var isSyncing: Bool = false
    
    init(
        count: Int,
        otp: Binding<String>,
        spacing: CGFloat = 16,
        underlineHeight: CGFloat = 4,
        underlineColor: Color = Color.accent,
        underlineOpacity: Double = 0.8,
        textColor: Color = .white,
        fontSize: CGFloat = 24,
        fontWeight: Font.Weight = .semibold,
        horizontalPadding: CGFloat = 16,
        onOTPComplete: ((String) -> Void)? = nil,
        onFocusChange: ((Bool) -> Void)? = nil
    ) {
        self.count = count
        self._otp = otp
        self.spacing = spacing
        self.underlineHeight = underlineHeight
        self.underlineColor = underlineColor
        self.underlineOpacity = underlineOpacity
        self.textColor = textColor
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.horizontalPadding = horizontalPadding
        self.onOTPComplete = onOTPComplete
        self.onFocusChange = onFocusChange
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<count, id: \.self) { index in
                NoKeyboardTextField(
                    text: Binding(
                        get: { index < number.count ? number[index] : "" },
                        set: { newValue in
                            updateOTP(at: index, with: newValue)
                        }
                    ),
                    isFocused: Binding(
                        get: { isFocused && focusedIndex == index },
                        set: { focused in
                            if focused {
                                isFocused = true
                                focusedIndex = index
                                onFocusChange?(true)
                            }
                        }
                    ),
                    textFontStyle: .systemFont(ofSize: fontSize, weight: fontWeight.uiFontWeight),
                    cursorVisible: false,
                    placeholder: "",
                    onTap: {
                        handleTap(at: index)
                    },
                    textAlignment: .center
                )
                .foregroundColor(textColor)
                .overlay(alignment: .bottom) {
                    underlineColor
                        .opacity(underlineOpacity)
                        .frame(maxWidth: .infinity)
                        .frame(height: underlineHeight)
                }.overlay(alignment: .center) {
                    if focusedIndex == index && isFocused {
                        BlinkingView()
                    }
                }
            }
        }
        .onAppear {
            initializeOTP()
        }
        .onChange(of: otp) { oldValue, newValue in
            // Only sync if the change didn't come from internal update
            if !isSyncing {
                syncFromOTP(newValue)
            }
        }
    }
    
    private func initializeOTP() {
        number = Array(repeating: "", count: count)
        syncFromOTP(otp)
    }
    
    private func syncFromOTP(_ otpValue: String) {
        isSyncing = true
        defer { isSyncing = false }
        
        let otpArray = Array(otpValue.prefix(count))
        number = (0..<count).map { index in
            index < otpArray.count ? String(otpArray[index]) : ""
        }
        
        // Update focused index to the next empty field or last field
        if otpValue.count < count {
            focusedIndex = min(otpValue.count, count - 1)
        } else {
            focusedIndex = count - 1
        }
        
        // Check if OTP is complete
        if otpValue.count == count {
            onOTPComplete?(otpValue)
        }
    }
    
    private func updateOTP(at index: Int, with newValue: String) {
        guard index < number.count else { return }
        
        isSyncing = true
        defer { isSyncing = false }
        
        // Handle paste operation (multiple characters)
        if newValue.count > 1 {
            let digits = newValue.filter { $0.isNumber }
            let startIndex = index
            let endIndex = min(startIndex + digits.count, count)
            
            for (i, digit) in digits.enumerated() {
                let targetIndex = startIndex + i
                if targetIndex < count {
                    number[targetIndex] = String(digit)
                }
            }
            
            // Update the binding
            let newOTP = number.joined()
            otp = newOTP
            
            // Move focus to the next empty field or last field
            let nextIndex = min(endIndex, count - 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                focusedIndex = nextIndex
                isFocused = true
            }
            
            // Check if OTP is complete
            if newOTP.count == count {
                onOTPComplete?(newOTP)
            }
        } else {
            // Single character input
            let char = String(newValue.prefix(1))
            number[index] = char
            
            // Update the binding
            let newOTP = number.joined()
            otp = newOTP
            
            // Auto-advance to next field if character entered
            if !char.isEmpty && index < count - 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    focusedIndex = index + 1
                    isFocused = true
                }
            }
            
            // Check if OTP is complete
            if newOTP.count == count {
                onOTPComplete?(newOTP)
            }
        }
    }
    
    private func handleTap(at index: Int) {
        isFocused = true
        focusedIndex = index
        onFocusChange?(true)
    }
}

struct BlinkingView: View {
    @State var isVisible: Bool = true
    var body : some View {
        VStack {
            if isVisible {
                Color.accent.frame(
                    maxHeight: .infinity,
                )
                .frame(width: 1)
                .padding(.vertical, 16)
            }
        }.onAppear {
            withAnimation(
                .spring(dampingFraction: 1.0)
                    .repeatForever(autoreverses: true)
            ) {
                isVisible.toggle()
            }
        }
    }
}

extension Font.Weight {
    var uiFontWeight: UIFont.Weight {
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        default: return .regular
        }
    }
}

#Preview {
    @Previewable @State var otp: String = ""
    VStack(spacing: 20) {
        OTPTextFieldView(
            count: 4,
            otp: $otp,
            onOTPComplete: { completedOTP in
                print("OTP Complete: \(completedOTP)")
            },
            onFocusChange: { isFocused in
                print("Focus changed: \(isFocused)")
            }
        )
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        
        Text("OTP: \(otp)")
            .foregroundColor(.white)
    }
    .padding()
    .background(Color.black)
}
