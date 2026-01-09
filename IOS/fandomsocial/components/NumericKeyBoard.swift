//
//  NumericKeypad.swift
//  fandomsocial
//
//  Created by Debdut Saha on 18/12/25.
//

import SwiftUI

struct NumericKeypad: View {
    let onNumberTap: (String) -> Void
    let onDeleteTap: () -> Void
    let onChevronTap: () -> Void

    private let rows: [[Key]] = [
        [.digit("1"), .digit("2"), .digit("3")],
        [.digit("4"), .digit("5"), .digit("6")],
        [.digit("7"), .digit("8"), .digit("9")],
        [.chevron, .digit("0"), .delete]
    ]

    var body: some View {
        VStack(spacing: 12) {
            // Row 1
            HStack(spacing: 12) {
                KeyView(key: .digit("1"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
                KeyView(key: .digit("2"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
                KeyView(key: .digit("3"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
            }
            // Row 2
            HStack(spacing: 12) {
                KeyView(key: .digit("4"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
                KeyView(key: .digit("5"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
                KeyView(key: .digit("6"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
            }
            // Row 3
            HStack(spacing: 12) {
                KeyView(key: .digit("7"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
                KeyView(key: .digit("8"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
                KeyView(key: .digit("9"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
            }
            // Row 4
            HStack(spacing: 12) {
                KeyView(key: .chevron, onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
                KeyView(key: .digit("0"), onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
                KeyView(key: .delete, onNumberTap: onNumberTap, onDeleteTap: onDeleteTap, onChevronTap: onChevronTap)
                    .frame(maxWidth: .infinity, minHeight: 54)
            }
        }
        .padding(.vertical, 8)
    }

    enum Key: Hashable {
        case digit(String)
        case delete
        case chevron
    }

    struct KeyView: View {
        let key: Key
        let onNumberTap: (String) -> Void
        let onDeleteTap: () -> Void
        let onChevronTap: () -> Void

        var body: some View {
            Button {
                switch key {
                case .digit(let d): onNumberTap(d)
                case .delete: onDeleteTap()
                case .chevron: onChevronTap()
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.secondaryColor)
                    content
                }
            }
            .buttonStyle(.plain)
        }

        @ViewBuilder
        var content: some View {
            switch key {
            case .digit(let d):
                Text(d)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
            case .delete:
                Image(systemName: "delete.left")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            case .chevron:
                Image(systemName: "chevron.down")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
        }
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

