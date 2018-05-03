// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/QuartzCore/NSValue.swift.gyb", line: 1)
//===--- NSValue.swift - Bridging things in NSValue -----------*- swift -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/QuartzCore/NSValue.swift.gyb", line: 16)

@_exported import QuartzCore // Clang module
import Foundation


extension CATransform3D: _ObjectiveCBridgeable {
  public func _bridgeToObjectiveC() -> NSValue {
    var myself = self
    return NSValue(bytes: &myself, objCType: _getObjCTypeEncoding(CATransform3D.self))
  }

  public static func _forceBridgeFromObjectiveC(_ source: NSValue,
                                                result: inout CATransform3D?) {
    precondition(strcmp(source.objCType,
                        _getObjCTypeEncoding(CATransform3D.self)) == 0,
                 "NSValue does not contain the right type to bridge to CATransform3D")
    result = CATransform3D()
    source.getValue(&result!)
  }

  public static func _conditionallyBridgeFromObjectiveC(_ source: NSValue,
                                                        result: inout CATransform3D?)
      -> Bool {
    if strcmp(source.objCType, _getObjCTypeEncoding(CATransform3D.self)) != 0 {
      result = nil
      return false
    }
    result = CATransform3D()
    source.getValue(&result!)
    return true
  }

  public static func _unconditionallyBridgeFromObjectiveC(_ source: NSValue?)
      -> CATransform3D {
    let unwrappedSource = source!
    precondition(strcmp(unwrappedSource.objCType,
                        _getObjCTypeEncoding(CATransform3D.self)) == 0,
                 "NSValue does not contain the right type to bridge to CATransform3D")
    var result = CATransform3D()
    unwrappedSource.getValue(&result)
    return result
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/QuartzCore/NSValue.swift.gyb", line: 20)


