//
//  LCGamePage.swift
//  WWDC_raw
//
//  Created by Roy Rao on 2021/4/10.
//

import SwiftUI

struct LCGamePage: View {
    @Binding var currentPage: Chapter1GamePages
    @ObservedObject private var x1Route = RouteVM()
    @ObservedObject private var x2Route = RouteVM()
    @State private var phase: LCPhase = .showSFrame
    @State private var dialogStr: LCDialogs = .intro
    @State private var area = CGRect()
    @State private var equation = NSImage(named: NSImage.bonjourName)!
    @State private var equationSize = CGSize(width: 120, height: 48)
    @State private var bReady: Bool = true
    @State private var bOffset: Bool = false
    @State private var bEquation: Bool = false
    @State private var bSFrame: Bool = false
    @State private var bSpFrame: Bool = false
    @State private var bX1: Bool = false
    @State private var bX2: Bool = false
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                // MARK: diagram -
                ZStack {
                    Image(nsImage: NSImage(named: "S_axis")!)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 500, height: 150)
                        .position(x: area.minX + 300, y: area.minY + 200)
                        .isHidden(!bSFrame)
                    
                    Image(nsImage: NSImage(named: "Sp_axis")!)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 300, height: 150)
                        .position(x: area.minX + 250, y: area.minY + 180)
                        .offset(x: bOffset ? 175 : 0)
                        .animation(.linear(duration: bEquation ? 0.25 : 2))
                        .isHidden(!bSpFrame)
                    
                    Image(nsImage: NSImage(named: "trailing_u")!)
                        .renderingMode(.template)
                        .resizable()
                        .frame(maxWidth: 50, maxHeight: 50)
                        .position(x: area.minX + 190, y: area.minY + 150)
                        .offset(x: bOffset ? 175 : 0)
                        .animation(.linear(duration: bEquation ? 0.25 : 2))
                        .isHidden(!bOffset)
                    
                    LineRouteView(points: $x1Route.points, lastPoint: $x1Route.lastPoint, clr: .pink)
                    LineRouteView(points: $x2Route.points, lastPoint: $x2Route.lastPoint, clr: .pink)
                    
                    HStack {
                        VStack {
                            Text("x₁")
                                .font(.system(size: 30, weight: .regular, design: .serif))
                                .italic()
                                .fixedSize()
                                .padding(.bottom, 10)
                                .padding(.leading, 10)
                                .isHidden(!bX1)
                            Text("(t₁)")
                                .font(.system(size: 20, weight: .regular, design: .serif))
                                .fixedSize()
                                .isHidden(!bX1)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("<-- uΔt -->")
                                .font(.system(size: 20, weight: .regular, design: .serif))
                                .italic()
                                .fixedSize()
                                .isHidden(
                                    !(phase.rawValue > LCPhase.spFrameConclusion1.rawValue && phase.rawValue <= LCPhase.end.rawValue)
                                )
                            Spacer()
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("x₂")
                                .font(.system(size: 30, weight: .regular, design: .serif))
                                .italic()
                                .fixedSize()
                                .padding(.bottom, 10)
                                .isHidden(!bX2)
                            Text("(t₁ + Δt)")
                                .font(.system(size: 20, weight: .regular, design: .serif))
                                .fixedSize()
                                .isHidden(!bX2)
                        }
                    }
                    .frame(width: 240, height: 50)
                    .position(x: area.minX + 390, y: area.minY + 310)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 50)
                .offset(y: bEquation ? -50 : 0)
                .onChange(of: phase, perform: { _ in
                    bReady = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        bReady = true
                    }
                })
                
                // MARK: equation -
                HStack {
                    Image(nsImage: equation)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: equationSize.width, height: equationSize.height)
                        .isHidden(!bEquation)
                }
                .position(x: area.minX + 390, y: area.minY + 130)
                .padding(.bottom, 10)
                
                Spacer()
                
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
                            .frame(minHeight: 50)
                            .offset(y: -50)
                    }
                    .padding(.bottom, 10)
                    
                    VStack {
                        Image(nsImage: NSImage(named: "click")!)
                            .renderingMode(.template)
                            .resizable()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .padding(.bottom, 10)
                        Text("Click any blank space to continue")
                            .fixedSize()
                    }
                    .isHidden(!bReady)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
            .onAppear {
                area = geo.frame(in: .global)
            }
        }
        .contentShape(Rectangle())
        .border(Color.green, width: 1)
        .onTapGesture {
            // MARK: actions -
            withAnimation {
                // check if it's ready
                if bReady {
                    
                    switch phase {
                        
                    case .showSFrame:
                        dialogStr = .showSFrame
                        bSFrame = true
                        x1Route.points = [CGPoint(x: area.minX + 290, y: area.minY + 250)]
                        x2Route.points = [CGPoint(x: area.minX + 465, y: area.minY + 250)]
                        
                    case .showSpFrame:
                        dialogStr = .showSpFrame
                        bSpFrame = true
                        
                    case .spNowMove:
                        dialogStr = .spNowMove
                        x1Route.points.append(CGPoint(x: area.minX + 290, y: area.minY + 270))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            bX1 = true
                        }
                        
                    case .offsetSpFrame:
                        dialogStr = .offsetSpFrame
                        bOffset = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            x2Route.points.append(CGPoint(x: area.minX + 465, y: area.minY + 270))
                            bX2 = true
                        }
                        
                    case .spFrameConclusion1:
                        dialogStr = .spFrameConclusion1
                        
                    case .spFrameConclusion2:
                        dialogStr = .spFrameConclusion2
                        
                    case .sFrameConclusion1:
                        dialogStr = .sFrameConclusion1
                        
                    case .sFrameConclusion2:
                        dialogStr = .sFrameConclusion2
                        equation = NSImage(named: "dtprime")!
                        bEquation = true
                        
                    case .sFrameConclusion3:
                        dialogStr = .sFrameConclusion3
                        equationSize = CGSize(width: 510, height: 80)
                        equation = NSImage(named: "dtEquation")!
                        
                    case .sFrameConclusion4:
                        dialogStr = .sFrameConclusion4
                        equationSize = CGSize(width: 230, height: 80)
                        equation = NSImage(named: "LC_Equation_game")!
                        
                    case .sFrameConclusion5:
                        dialogStr = .sFrameConclusion5
                        equationSize = CGSize(width: 260, height: 80)
                        equation = NSImage(named: "SimplifiedEquation2")!
                        
                    case .end:
                        dialogStr = .end
                        bX1 = false
                        bX2 = false
                        bOffset = false
                        bEquation = false
                        bSFrame = false
                        bSpFrame = false
                        x1Route.points.removeAll()
                        x2Route.points.removeAll()
                        
                    case .exit:
                        currentPage = .preface
                    }
                    
                    // next phase
                    let phaseRaw = phase.rawValue
                    let lastPhase = LCPhase.exit.rawValue
                    phase = LCPhase(rawValue: phaseRaw < lastPhase ? phaseRaw + 1 : phaseRaw)!
                }
            }
        }
    }
}


enum LCPhase: Int {
    case showSFrame = 1
    case showSpFrame = 2
    case spNowMove = 3
    case offsetSpFrame = 4
    case spFrameConclusion1 = 5
    case spFrameConclusion2 = 6
    case sFrameConclusion1 = 7
    case sFrameConclusion2 = 8
    case sFrameConclusion3 = 9
    case sFrameConclusion4 = 10
    case sFrameConclusion5 = 11
    case end = 12
    case exit = 13
}


enum LCDialogs: String {
    case intro = "Welcome to this little game of Length Contraction. Please be sure you've finished the previous game of Time Dilation first! :)"
    case showSFrame = "We assume that there are two different reference systems. First we have frame [S] with an [x] axis as its length axis."
    case showSpFrame = "Now we have frame [S'] with an [x'] axis as its length axis. And there's a long rod [A'B'] fixed on the [x'] axis, and its proper length (the length of the object in its rest frame) is measured to be [L'] in the frame [S']. Imagine frame [S'] is now moving to the right while frame [S] is at still."
    case spNowMove = "In order to find out the length [L] (the length observed by an observer in motion relative to the object) of the long rod in frame [S], we assume that at a certain time [t₁] in frame [S], [B'] passes through [x₁]."
    case offsetSpFrame = "Then after [t₁ + Δt], [A'] passes through [x₁]. Since the moving speed of the long rod is [u], the position of the end [B'] at this moment is at [x₂] (x₂ = x₁ + uΔt)."
    case spFrameConclusion1 = "According to the length measurement above, length [L] of the long rod in frame [S] should be [uΔt] (L = x₂ － x₁ = uΔt)."
    case spFrameConclusion2 = "[Δt] is the time interval between the two events of the end [B'] and the end [A'] passing through [x₁] in succession. Since [x₁] is a fixed point in frame [S], [Δt] is the proper time (the fixed time measured by a clock that co-located with the event) between these two events."
    case sFrameConclusion1 = "From the aspect of frame [S'], the long rod is stationary and frame [S] moves to the left, and [x₁] passes through end [B'] and end [A'] in succession."
    case sFrameConclusion2 = "Since the length of the long rod is [L'], the time interval [Δt'] that between [x₁] passes through [B'] and [A'] in frame [S'] is measured as [Δt' = L' / u]."
    case sFrameConclusion3 = "According to the Time Dilation formula we have proved in the previous game, we can get the equation above and substituting the former formula into this one."
    case sFrameConclusion4 = "Since we've already know [L = uΔt] and we can get [Δt = L / u], then we can merge the two formulas and have our Length Contraction formula in sight!"
    case sFrameConclusion5 = "As the moving speed of the long rod is much slower than the speed of light, we let [α = 1 / γ]. Then we can easily see above that the length in motion [L] is relatively shorter than when is stationary [L']."
    case end = "In this game we roughly proved Length Contraction. As of now, you should have a general understanding of Time Dilation and Length Contraction, right? Now you can go to the next chapter and learn something new about Twin Paradox. Or you still wanna play this game again? It's up to you!"
}
