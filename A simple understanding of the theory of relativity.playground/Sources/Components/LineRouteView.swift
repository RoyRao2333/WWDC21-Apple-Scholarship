//
//  LineRouteView.swift
//
//  Created by Roy Rao on 2021/4/11.
//

import SwiftUI


// Route shape animating head point
struct Route: Shape {
    var points: [CGPoint]
    var head: CGPoint

    // make route animatable head position only
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(head.x, head.y) }
        set {
            head.x = newValue.first
            head.y = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            guard points.count > 1 else { return }
            path.move(to: points.first!)
            _ = points.dropFirst().dropLast().map { path.addLine(to: $0) }
            path.addLine(to: head)
        }
    }
}


// Route view model holding all points and notifying when last one changed
public class RouteVM: ObservableObject {
    @Published public var lastPoint = CGPoint.zero
    
    public init() {}
    
    public var points = [CGPoint.zero] {
        didSet {
            lastPoint = points.last ?? CGPoint.zero
        }
    }
}


public struct LineRouteView: View {
    @Binding var points: [CGPoint]
    @Binding var lastPoint: CGPoint
    var clr: Color
    
    public init(points: Binding<[CGPoint]>, lastPoint: Binding<CGPoint>, clr: Color) {
        self._points = points
        self._lastPoint = lastPoint
        self.clr = clr
    }

    public var body: some View {
        GeometryReader { geo in
            ZStack {
                // draw route when head changed
                Route(points: points, head: lastPoint)
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 3,
                            lineCap: .round,
                            lineJoin: .miter,
                            miterLimit: 0,
                            dash: [],
                            dashPhase: 0
                        )
                    )
                    .foregroundColor(clr)
                    .animation(.linear(duration: 1))
            }
        }
    }
}
