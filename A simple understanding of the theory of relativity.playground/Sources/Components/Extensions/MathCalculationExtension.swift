//
//  MathCalculationExtension.swift
//
//  Created by Roy Rao on 2020/2/11.
//  Copyright © 2020 RoyRao. All rights reserved.
//

import Cocoa

extension Double {
    
    //Rounds the double to decimal places value
    public func roundTo(places:Int) -> Double {
        
        let divisor = pow(10.0, Double(places))

        return (self * divisor).rounded() / divisor

    }

}
