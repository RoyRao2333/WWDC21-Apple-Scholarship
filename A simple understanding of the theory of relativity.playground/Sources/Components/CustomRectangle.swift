//
//  CustomRectangle.swift
//
//  Created by Roy Rao on 2021/4/12.
//

import SwiftUI

public struct CustomRectangle: Shape {
    var frm: CGRect
    
    public init(frm: CGRect) {
        self.frm = frm
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: frm.origin)
            path.addLine(to: CGPoint(x: frm.origin.x, y: frm.maxY))
            path.addLine(to: CGPoint(x: frm.maxX, y: frm.maxY))
            path.addLine(to: CGPoint(x: frm.maxX, y: frm.origin.y))
            path.addLine(to: frm.origin)
        }
    }
}
