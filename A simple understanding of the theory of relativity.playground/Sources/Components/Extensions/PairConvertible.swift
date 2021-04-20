//
//  PairConvertible.swift
//
//  Created by Roy Rao on 2021/4/12.
//

import Cocoa

protocol PairConvertible {
        associatedtype X
        associatedtype Y
        init(_ pair: (X, Y))
}


struct PairStruct<X, Y>: Hashable, PairConvertible where X: Hashable, Y: Hashable {
        let x: X
        let y: Y
        
        init(_ pair: (X, Y)) {
                self.x = pair.0
                self.y = pair.1
        }
}


extension Dictionary where Key: PairConvertible {
    
        subscript (key: (Key.X, Key.Y)) -> Value? {
                get { return self[Key(key)] }
                set { self[Key(key)] = newValue }
        }
    
        subscript (key0: Key.X, key1: Key.Y) -> Value? {
                get { return self[Key((key0, key1))] }
                set { self[Key((key0, key1))] = newValue }
        }
}
