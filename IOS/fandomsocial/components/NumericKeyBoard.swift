//
//  NumericKeypad.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import SwiftUI

struct NumericKeypad: View {
    var onNumberTap: (String) -> Void
    var onDeleteTap: () -> Void
    var onChevronTap: (() -> Void)? = nil
    
    private let rowCount: CGFloat = 4
    
    // Grid columns: 3 flexible columns with spacing
    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    // Keypad items in order: 1-9, then chevron, 0, delete
    private var keypadItems: [KeypadItem] {
        var items: [KeypadItem] = []
        // Numbers 1-9
        for i in 1...9 {
            items.append(.number("\(i)"))
        }
        // Bottom row: chevron, 0, delete
        items.append(.chevron)
        items.append(.number("0"))
        items.append(.delete)
        return items
    }
    
    var body: some View {
        GeometryReader { geometry in
            let buttonHeight = geometry.size.height > 0 ? geometry.size.height / rowCount : 70
            
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(keypadItems, id: \.self) { item in
                    KeypadButton(content: item, height: buttonHeight) {
                        handleTap(for: item)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.secondaryColor)
            )
        }
        .drawingGroup()
    }
    
    private func handleTap(for item: KeypadItem) {
        switch item {
        case .number(let number):
            onNumberTap(number)
        case .chevron:
            onChevronTap?()
        case .delete:
            onDeleteTap()
        }
    }
}

enum KeypadItem: Hashable {
    case number(String)
    case chevron
    case delete
}

struct KeypadButton: View {
    let content: KeypadItem
    let height: CGFloat
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // Button background (transparent for seamless look)
                Color.clear
                
                // Content
                Group {
                    switch content {
                    case .number(let number):
                        Text(number)
                            .font(.system(size: 28, weight: .regular))
                            .foregroundColor(Color.white)
                    case .chevron:
                        Image(systemName: "chevron.down")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.white)
                    case .delete:
                        Image(systemName: "delete.backward")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color.white)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: height)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.2)
            .ignoresSafeArea()
        
        VStack {
            Spacer()
            
            NumericKeypad(
                onNumberTap: { number in
                    print("Number tapped: \(number)")
                },
                onDeleteTap: {
                    print("Delete tapped")
                },
                onChevronTap: {
                    print("Chevron tapped")
                }
            )
            .padding()
            
            Spacer()
        }
    }
}

