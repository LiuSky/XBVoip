//
//  Data+.swift
//  XBVoip
//
//  Created by xiaobin liu on 2019/1/23.
//  Copyright © 2019 Sky. All rights reserved.
//

import Foundation


// MARK: - Data
public extension Data {
    
    /// APNS Token 转换成String
    public var hexString: String {
        
        return self.withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: self.count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}
