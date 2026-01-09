//
//  KeyPadPerfTest.swift
//  fandomsocial
//
//  Created by Debdut Saha on 04/01/26.
//

import SwiftUI

struct KeypadPerfTest: View {
    @State private var show = false
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()
            Button("Toggle") { withAnimation { show.toggle() } }
                .padding()
                .background(.white)
                .cornerRadius(8)

            if show {
                NumericKeypad(onNumberTap: { _ in }, onDeleteTap: {}, onChevronTap: { withAnimation { show = false } })
                    .padding(.horizontal, 20)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeOut(duration: 0.25), value: show)
    }
}

#Preview {
    KeypadPerfTest()
}
