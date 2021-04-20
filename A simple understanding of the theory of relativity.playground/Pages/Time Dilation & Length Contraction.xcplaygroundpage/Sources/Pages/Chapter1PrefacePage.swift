//
//  PrefacePage.swift
//
//  Created by Roy Rao on 2021/4/10.
//

import SwiftUI

struct Chapter1PrefacePage: View {
    @Binding var currentPage: Chapter1GamePages
    @State private var bMaxScale: Bool = false
    private let maxScale: CGFloat = 1.5
    
    var body: some View {
        VStack {
            Text("Bonjour!")
                .font(.system(.title, design: .monospaced))
                .fixedSize()
                .scaleEffect(bMaxScale ? maxScale : 1)
                .padding(.bottom, 100)
                .onAppear {
                    withAnimation(
                        Animation
                            .easeInOut(duration: 1)
                            .repeatForever(autoreverses: true)
                    ) {
                        bMaxScale.toggle()
                    }
                }
            
            HStack {
                Image(nsImage: NSImage(named: "confetti")!)
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 50)
                    .padding(.trailing, 10)
                Text("Choose one to play!")
                    .font(.system(size: 20, weight: .medium, design: .monospaced))
            }
            .padding(.bottom, 70)
            
            Button {
                currentPage = .td
            } label: {
                Text("What's Time Dilation?")
                    .fixedSize()
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                                    gradient: Gradient(colors: [.red, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                        )
                    )
                    .cornerRadius(40)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, 50)
            
            Button {
                currentPage = .lc
            } label: {
                Text("What's Length Contraction?")
                    .fixedSize()
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                                    gradient: Gradient(colors: [.red, .blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                        )
                    )
                    .cornerRadius(40)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
