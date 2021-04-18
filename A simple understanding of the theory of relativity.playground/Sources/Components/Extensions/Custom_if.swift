//
//  Custom_if.swift
//
//  Created by Roy Rao on 2021/4/12.
//

import SwiftUI

extension View {
    
   @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, ifTure: ((Self) -> Content)?, ifFalse: ((Self) -> Content)?) -> some View {
        if conditional {
            if ifTure != nil {
                ifTure!(self)
            } else {
                self
            }
        } else {
            if ifFalse != nil {
                ifFalse!(self)
            } else {
                self
            }
        }
    }
}
