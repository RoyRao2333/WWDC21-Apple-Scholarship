//
//  ITGamePage.swift
//  WWDC_raw
//
//  Created by Roy Rao on 2021/4/17.
//

import SwiftUI

struct ITGamePage: View {
    @Binding var currentPage: Chapter2GamePages
    @ObservedObject private var earthRoute = RouteVM()
    @ObservedObject private var spacecraftRoute = RouteVM()
    @State private var area = CGRect()
    @State private var phase: ITPhase = .showPlanets
    @State private var dialogStr: ITDialogs = .preface
    @State private var bReady: Bool = true
    @State private var bShow: Bool = false
    @State private var bOffset: Bool = false
    @State private var bPath1: Bool = false
    @State private var bPath2: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                // MARK: diagram -
                ZStack {
                    Image(nsImage: NSImage(named: "distant_planet")!)
                        .resizable()
                        .frame(maxWidth: 50, maxHeight: 50)
                        .position(x: area.minX + 100, y: area.minY + 150)
                        .offset(x: bOffset ? 250 : 0)
                        .isHidden(!bShow)
                    
                    Image(nsImage: NSImage(named: "earth")!)
                        .resizable()
                        .frame(maxWidth: 50, maxHeight: 50)
                        .position(x: area.maxX - 100, y: area.minY + 150)
                        .isHidden(!bShow)
                    
                    Image(nsImage: NSImage(named: "rocket")!)
                        .resizable()
                        .frame(maxWidth: 100, maxHeight: 50)
                        .position(x: area.maxX - 180, y: area.minY + 150)
                        .offset(x: bOffset ? -159 : 0)
                        .isHidden(!bShow)
                    
                    LineRouteView(
                        points: $earthRoute.points,
                        lastPoint: $earthRoute.lastPoint,
                        clr: .orange
                    )
                    .isHidden(!bPath1)
                    
                    Text("111.1 years")
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .fixedSize()
                        .position(x: area.midX, y: area.minY + 300)
                        .padding(.leading, 10)
                        .isHidden(!bPath1)
                    
                    LineRouteView(
                        points: $spacecraftRoute.points,
                        lastPoint: $spacecraftRoute.lastPoint,
                        clr: .purple
                    )
                    .isHidden(!bPath2)
                    
                    Text("48.4 years")
                        .font(.system(size: 13, weight: .regular, design: .monospaced))
                        .fixedSize()
                        .position(x: area.midX + 130, y: area.minY + 220)
                        .padding(.leading, 10)
                        .isHidden(!bPath2)
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
        .border(Color.green, width: 1)
        .onTapGesture {
            // MARK: actions -
            withAnimation {
                // check if it's ready
                if bReady {
                    
                    switch phase {
                        
                    case .showPlanets:
                        dialogStr = .showPlanets
                        bShow = true
                        earthRoute.points = [CGPoint(x: area.maxX - 100, y: area.minY + 300)]
                        spacecraftRoute.points = [CGPoint(x: area.maxX - 100, y: area.minY + 220)]
                        
                    case .forEarth:
                        dialogStr = .forEarth
                        earthRoute.points.append(CGPoint(x: area.maxX - 100, y: area.minY + 320))
                        earthRoute.points.append(CGPoint(x: area.minX + 100, y: area.minY + 320))
                        earthRoute.points.append(CGPoint(x: area.minX + 100, y: area.minY + 300))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            bPath1 = true
                        }
                        
                    case .forYou:
                        dialogStr = .forYou
                        bOffset = true
                        spacecraftRoute.points.append(CGPoint(x: area.maxX - 100, y: area.minY + 240))
                        spacecraftRoute.points.append(CGPoint(x: area.minX + 350, y: area.minY + 240))
                        spacecraftRoute.points.append(CGPoint(x: area.minX + 350, y: area.minY + 220))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            bPath2 = true
                        }
                        
                    case .end:
                        dialogStr = .end
                        bPath1 = false
                        bPath2 = false
                        bShow = false
                        
                    case .exit:
                        currentPage = .cal
                    }
                    
                    // next phase
                    let phaseRaw = phase.rawValue
                    let lastPhase = ITPhase.exit.rawValue
                    phase = ITPhase(rawValue: phaseRaw < lastPhase ? phaseRaw + 1 : phaseRaw)!
                }
            }
        }
    }
}


enum ITPhase: Int {
    case showPlanets = 0
    case forEarth = 1
    case forYou = 2
    case end = 3
    case exit = 4
}


enum ITDialogs: String {
    case preface = "Let's say you're an astronaut. One day, you're going to explore a distant planet. \"it's going to be a great journey\", you think, and then embark on the journey. :)"
    case showPlanets = "Now we can see our earth and a lovely planet. At the same time, you and your rocket are also ready to go. We assume that the planet is 100 light-years away from the earth, and your rocket travels at 90% of the speed of light."
    case forEarth = "People on earth expect you to take 111.1 years to reach that planet. "
    case forYou = "For you inside the spacecraft, however, the time will dilate and you will reach that planet in only 48.4 years."
    case end = "Wanna play with Time Dilation yourself? Let's try it out!"
}
