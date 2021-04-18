//
//  TPGamePage.swift
//  WWDC_raw
//
//  Created by Roy Rao on 2021/4/18.
//

import SwiftUI
import AVKit

struct TPGamePage: View {
    @Binding var currentPage: Chapter2GamePages
    @State private var area = CGRect()
    @State private var phase: TPPhase = .allenDiagram1
    @State private var dialogStr: TPDialogs = .preface
    private let allenPlayer = AVPlayer(
        url: Bundle.main.url(forResource: "ground_reference", withExtension: "mp4")!
    )
    private let bobPlayer = AVPlayer(
        url: Bundle.main.url(forResource: "spacecraft_reference", withExtension: "mp4")!
    )
    @State private var bReady: Bool = true
    @State private var bAllen: Bool = false
    @State private var bBob: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                // MARK: diagram -
                HStack {
                    AVPlayerViewRepresented(player: allenPlayer)
                        .frame(width: 256.2, height: 326.2)
                        .padding(.leading, 20)
                        .disabled(true)
                        .isHidden(!bAllen)
                        .onAppear {
                            allenPlayer.isMuted = true
                            allenPlayer.pause()
                        }
                        .onChange(of: bAllen) { _ in
                            if bAllen {
                                allenPlayer.seek(to: .zero)
                                allenPlayer.play()
                            } else {
                                allenPlayer.pause()
                            }
                        }
                    
                    Text(" Allen" + "\n" + "(green)")
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .fixedSize()
                        .padding(.leading, 10)
                        .isHidden(!bAllen)

                    
                    Spacer()
                    
                    Text(" Bob" + "\n" + "(red)")
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .fixedSize()
                        .padding(.trailing, 10)
                        .isHidden(!bBob)
                    
                    AVPlayerViewRepresented(player: bobPlayer)
                        .frame(width: 256.2, height: 326.2)
                        .padding(.trailing, 20)
                        .disabled(true)
                        .isHidden(!bBob)
                        .onAppear {
                            bobPlayer.isMuted = true
                            bobPlayer.pause()
                        }
                        .onChange(of: bBob) { _ in
                            if bBob {
                                bobPlayer.seek(to: .zero)
                                bobPlayer.play()
                            } else {
                                bobPlayer.pause()
                            }
                        }
                }
                .padding(.bottom, 70)
                .onChange(of: phase, perform: { _ in
                    bReady = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        bReady = true
                    }
                })
                
                // MARK: dialog -
                VStack {
                    HStack {
                        Image(nsImage: NSImage(named: "dialog")!)
                            .resizable()
                            .frame(maxWidth: 50, maxHeight: 50)
                            .offset(y: -50)
                            .padding(.trailing, 10)
                        Text(dialogStr.rawValue)
                            .font(.system(size: 15, weight: .regular, design: .monospaced))
                            .frame(minHeight: 80)
                            .offset(y: -50)
                    }
                    .padding(.bottom, 30)
                    
                    VStack {
                        Image(nsImage: NSImage(named: "click")!)
                            .renderingMode(.template)
                            .resizable()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .padding(.bottom, 10)
                        Text("Click any blank space to continue")
                            .fixedSize()
                    }
                    .opacity(bReady ? 1 : 0)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
            .onAppear {
                area = geo.frame(in: .global)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            // MARK: actions -
            withAnimation {
                // check if it's ready
                if bReady {
                    
                    switch phase {
                    
                    case .allenDiagram1:
                        dialogStr = .allenDiagram1
                        bAllen = true
                        
                    case .allenDiagram2:
                        dialogStr = .allenDiagram2
                        
                    case .bobDiagram:
                        dialogStr = .bobDiagram
                        bBob = true
                        
                    case .conclusion1:
                        dialogStr = .conclusion1
                        
                    case .conclusion2:
                        bAllen = false
                        bBob = false
                        dialogStr = .conclusion2
                        
                    case .exit:
                        currentPage = .preface
                    }
                    
                    // next phase
                    let phaseRaw = phase.rawValue
                    let lastPhase = TPPhase.exit.rawValue
                    phase = TPPhase(rawValue: phaseRaw < lastPhase ? phaseRaw + 1 : phaseRaw)!
                }
            }
        }
    }
}


enum TPPhase: Int {
    case allenDiagram1 = 0
    case allenDiagram2 = 1
    case bobDiagram = 2
    case conclusion1 = 3
    case conclusion2 = 4
    case exit = 5
}


enum TPDialogs: String {
    case preface = "As we explained earlier in the preface: When the spacecraft turns around, it must first slow down, reduce its speed to zero, and then accelerate back to Earth."
    case allenDiagram1 = "From Allen’s perspective, during the three years he has experienced: In the first year, Bob moved away from the earth at a certain speed of about 80% of the speed of light. In the second year, Bob decelerated and then accelerated under a constant external force to turn around. In the third year Bob returns to Earth at a certain speed at about 80% of the speed of light."
    case allenDiagram2 = "Bob's acceleration time accounts for 33.3% of the total time. In the period when the acceleration of Bob's spacecraft is 0, the operating speed of Bob's clock is about 60% of the operating speed of Allen's clock."
    case bobDiagram = "From Bob's point of view, in the two years he has experienced, the time with acceleration accounted for about 40% of the total time. In the period when the acceleration of his spacecraft is 0, the operating speed of Allen's clock is about 60% of the operating speed of bob's clock."
    case conclusion1 = "In the above two diagrams, the upward moving green and red line segments (and the light green and light red line segments left with their movement) represent the \"isochronous lines\" (both ends of the connection represent the same moment) of Allen and Bob respectively. Because Allen and Bob are in different reference systems, their understanding of \"simultaneity\" is also different."
    case conclusion2 = "That's all for our Twin Paradox! Seems easy, right? You can play it again if you want, or you can go on and experience the next game! :)"
}


struct AVPlayerViewRepresented: NSViewRepresentable {
    var player: AVPlayer
    
    func makeNSView(context: Context) -> some NSView {
        let controller = AVPlayerView()
        controller.player = player
        controller.controlsStyle = .none
        loopVideo(player: player)
        
        return controller
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {}
    
    func loopVideo(player plr: AVPlayer) {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: plr.currentItem, queue: nil) { notification in
            plr.seek(to: .zero)
            plr.play()
        }
    }
}
