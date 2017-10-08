//
//  NSData+Int8.swift
//  SmartLock
//
//  Created by Pranay Jay Patel on 10/7/17.
//  Copyright © 2017 Hackathon2017. All rights reserved.
//

import Foundation

extension Data {
    static func dataWithValue(value: Int8) -> Data {
        var variableValue = value
        return Data(buffer: UnsafeBufferPointer(start: &variableValue, count: 1))
    }
    
    func int8Value() -> Int8 {
        return Int8(bitPattern: self[0])
    }
}
