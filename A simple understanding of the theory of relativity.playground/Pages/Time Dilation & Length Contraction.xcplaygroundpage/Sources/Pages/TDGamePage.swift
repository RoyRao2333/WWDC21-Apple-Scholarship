//
//  TDGamePage.swift
//  WWDC_raw
//
//  Created by Roy Rao on 2021/4/10.
//

import SwiftUI

struct TDGamePage: View {
    @Binding var currentPage: Chapter1GamePages
    @ObservedObject private var vm = RouteVM()
    @State private var phase: TDPhase = .preface
    @State private var area = CGRect()
    @State private var pct: CGFloat = .zero
    @State private var dialogStr: TDDialogs = .intro
    @State private var equationAbove = NSImage(named: NSImage.bonjourName)!
    @State private var equationBelow = NSImage(named: NSImage.bonjourName)!
    @State private var bReady: Bool = true
    @State private var bRectPresented: Bool = false
    @State private var bOffset: Bool = false
    @State private var bExpressions: Bool = false
    @State private var bEquation: Bool = false
    @State private var bSimplified: Bool = false
    
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                // MARK: diagram -
                ZStack {
                    CustomRectangle(
                        frm: CGRect(
                            x: area.minX + 100,
                            y: area.minY + 100,
                            width: 100,
                            height: 150
                        )
                    )
                    .stroke(
                        Color.orange,
                        style: StrokeStyle(
                            lineWidth: 4,
                            lineCap: .square,
                            lineJoin: .bevel
                        )
                    )
                    .isHidden(!bRectPresented)
                    .offset(x: bOffset ? 250 : 0)
                    .animation(.linear(duration: 1))
                    
                    // draw lines
                    LineRouteView(points: $vm.points, lastPoint: $vm.lastPoint, clr: .blue)
                    
                    // expressions
                    Text("ct'")
                        .font(.system(size: 20))
                        .italic()
                        .fixedSize()
                        .position(x: area.minX + 125, y: area.minY + 170)
                        .isHidden(!bExpressions)
                    Text("ct")
                        .font(.system(size: 20))
                        .italic()
                        .fixedSize()
                        .position(x: area.minX + 280, y: area.minY + 200)
                        .isHidden(!bExpressions)
                    Text("vt")
                        .font(.system(size: 20))
                        .italic()
                        .fixedSize()
                        .position(x: area.minX + 240, y: area.minY + 80)
                        .isHidden(!bExpressions)
                }
                .padding(.bottom, 50)
                .onChange(of: phase, perform: { _ in
                    bReady = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        bReady = true
                    }
                })
                
                // MARK: equation -
                HStack {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Image(nsImage: equationAbove)
                            .renderingMode(.template)
                            .resizable()
                            .frame(maxWidth: bSimplified ? 250 : 300, maxHeight: bSimplified ? 100 : 80)
                            .padding(.bottom, 10)
                            .isHidden(!bEquation)
                        Image(nsImage: NSImage(named: "down")!)
                            .resizable()
                            .frame(maxWidth: 50, maxHeight: 50)
                            .padding(.bottom, 10)
                            .padding(.trailing, bEquation ? 80 : 120)
                            .isHidden(!bEquation)
                        Image(nsImage: equationBelow)
                            .renderingMode(.template)
                            .resizable()
                            .frame(maxWidth: 200, maxHeight: bSimplified ? 60 : 100)
                            .padding(.trailing, bSimplified ? 0 : 50)
                            .isHidden(!bEquation)
                    }
                }
                .frame(height: 270)
                .offset(y: -100)
                .padding(.trailing, bSimplified ? 100 : 20)
                .padding(.bottom, 10)
                
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
                            .offset(y: -50)
                            .frame(minHeight: 100)
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
                .padding(.horizontal, 10)
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
                    
                    case .preface:
                        vm.points = [CGPoint(x: area.minX + 150, y: area.minY + 250)]
                        dialogStr = .preface
                        
                    case .showCabin:
                        bRectPresented = true
                        dialogStr = .showCabin
                        
                    case .drawingLine1:
                        vm.points.append(CGPoint(x: area.minX + 150, y: area.minY + 100))
                        dialogStr = .drawingLine1
                        
                    case .drawingLine2:
                        bOffset = true
                        vm.points.append(CGPoint(x: area.minX + 150, y: area.minY + 250))
                        vm.points.append(CGPoint(x: area.minX + 400, y: area.minY + 100))
                        dialogStr = .drawingLine2
                        
                    case .drawingLine3:
                        bRectPresented = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            vm.points.append(CGPoint(x: area.minX + 150, y: area.minY + 100))
                            dialogStr = .drawingLine3
                        }
                        
                    case .showExpressions:
                        bExpressions = true
                        dialogStr = .showExpressions
                        
                    case .showEquation:
                        dialogStr = .showEquation
                        equationAbove = NSImage(named: "Pythagorean_Theorem")!
                        equationBelow = NSImage(named: "TD_Equation")!
                        bEquation = true
                        
                    case .simplifyEquation:
                        dialogStr = .simplifyEquation
                        bSimplified = true
                        equationAbove = NSImage(named: "Lorentz_factor")!
                        equationBelow = NSImage(named: "SimplifiedEquation")!
                        
                    case .conclusion:
                        dialogStr = .conclusion
                        
                    case .end:
                        dialogStr = .end
                        vm.points.removeAll()
                        bEquation = false
                        bExpressions = false
                        
                    case .exit:
                        currentPage = .preface
                    }
                    
                    // next phase
                    let phaseRaw = phase.rawValue
                    let lastPhase = TDPhase.exit.rawValue
                    phase = TDPhase(rawValue: phaseRaw < lastPhase ? phaseRaw + 1 : phaseRaw)!
                }
            }
        }
    }
}


enum TDPhase: Int {
    case preface = 0
    case showCabin = 1
    case drawingLine1 = 2
    case drawingLine2 = 3
    case drawingLine3 = 4
    case showExpressions = 5
    case showEquation = 6
    case simplifyEquation = 7
    case conclusion = 8
    case end = 9
    case exit = 10
}


enum TDDialogs: String {
    case intro = "Welcome to this little game of Time Dilation. Please go on and hope you'll enjoy it! :)"
    case preface = "Let's assume that your girlfriend is a stewardess and you gave her a watch that exactly the same as yours."
    case showCabin = "One day your girlfriend is on duty on an plane, and we assume that you can clearly see the situation on the plane with your naked eyes."
    case drawingLine1 = "There is a laser beam on the plane emit from the floor to the top of the cabin, This is what your girlfriend sees, that is, the beam emitted straight up."
    case drawingLine2 = "However, in your eyes, the beam is not straight upwards, but as the plane moves laterally, it is slanted toward the top of the cabin."
    case drawingLine3 = "Then during this period of time, the motion of the plane and the beam can just form a right triangle. Let's assume that the time you see is [t], the time your girlfriend sees is [t'], and the speed of light is [c]."
    case showExpressions = "In your opinion, the distance traveled by this beam is [c] times [t]. In your girlfriend’s eyes, however, the distance traveled by this beam is [c] times [t’]. Naturally, if the speed of the plane is [v], then the distance the plane travels is [v] times [t]."
    case showEquation = "As time goes by, the elapsed time for you and your girlfriend are [Δt] and [Δt']. We can now easily figure out the relationship between them using Pythagorean Theorem and get the formula of Time Dilation."
    case simplifyEquation = "After we simplify the equation, things are now getting easier. Remember the Lorentz factor I mentioned in the preface earlier? We use [γ] to represent it, and we'll get [t = γt']."
    case conclusion = "As the speed of the plane is much slower than the speed of light, we can get [γ > 1] and then [t > t']. This is why we say the clock in motion runs relatively slowly."
    case end = "The above is the explanation and partial proof of Time Dilation in this game. Don't you find it very interesting? Now you can go back to the menu and learn about Length Contraction. Or still confused? You can play this game again to deepen your understanding of Time Dilation!"
}
