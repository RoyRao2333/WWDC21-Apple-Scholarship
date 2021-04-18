//
//  ChapterIIPrefacePage.swift
//  WWDC_raw
//
//  Created by Roy Rao on 2021/4/17.
//

import SwiftUI

struct Chapter2PrefacePage: View {
    @Binding var currentPage: Chapter2GamePages
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
                Text("Click one of the buttons below and let's go!")
                    .font(.system(size: 15, weight: .medium, design: .monospaced))
            }
            .padding(.bottom, 70)
            
            Button {
                currentPage = .tp
            } label: {
                Text("Quick look in Twin Paradox with diagrams")
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
                currentPage = .it
            } label: {
                Text("Travel between planets!")
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
        }
    }
}
