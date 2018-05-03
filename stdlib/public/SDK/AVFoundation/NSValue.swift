// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/AVFoundation/NSValue.swift.gyb", line: 1)
@_exported import AVFoundation // Clang module
import CoreMedia
import Foundation

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/AVFoundation/NSValue.swift.gyb", line: 9)

// Bridge CoreMedia structs to NSValue.
// AVFoundation provides internal NSValue subclasses for these structures that
// are incompatible with the NSConcreteValue subclasses you get using
// -[NSValue valueWithBytes:objCType:].


extension CMTime: _ObjectiveCBridgeable {
  public func _bridgeToObjectiveC() -> NSValue {
    return { NSValue(time: $0) }(self)
  }

  public static func _forceBridgeFromObjectiveC(_ source: NSValue,
                                                result: inout CMTime?) {
    precondition(strcmp(source.objCType,
                        _getObjCTypeEncoding(CMTime.self)) == 0,
                 "NSValue does not contain the right type to bridge to CMTime")
    result = { $0.timeValue }(source)
  }

  public static func _conditionallyBridgeFromObjectiveC(_ source: NSValue,
                                                        result: inout CMTime?)
      -> Bool {
    if strcmp(source.objCType, _getObjCTypeEncoding(CMTime.self)) != 0 {
      result = nil
      return false
    }
    result = { $0.timeValue }(source)
    return true
  }

  public static func _unconditionallyBridgeFromObjectiveC(_ source: NSValue?)
      -> CMTime {
    let unwrappedSource = source!
    precondition(strcmp(unwrappedSource.objCType,
                        _getObjCTypeEncoding(CMTime.self)) == 0,
                 "NSValue does not contain the right type to bridge to CMTime")
    return { $0.timeValue }(unwrappedSource)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/AVFoundation/NSValue.swift.gyb", line: 19)


extension CMTimeRange: _ObjectiveCBridgeable {
  public func _bridgeToObjectiveC() -> NSValue {
    return { NSValue(timeRange: $0) }(self)
  }

  public static func _forceBridgeFromObjectiveC(_ source: NSValue,
                                                result: inout CMTimeRange?) {
    precondition(strcmp(source.objCType,
                        _getObjCTypeEncoding(CMTimeRange.self)) == 0,
                 "NSValue does not contain the right type to bridge to CMTimeRange")
    result = { $0.timeRangeValue }(source)
  }

  public static func _conditionallyBridgeFromObjectiveC(_ source: NSValue,
                                                        result: inout CMTimeRange?)
      -> Bool {
    if strcmp(source.objCType, _getObjCTypeEncoding(CMTimeRange.self)) != 0 {
      result = nil
      return false
    }
    result = { $0.timeRangeValue }(source)
    return true
  }

  public static func _unconditionallyBridgeFromObjectiveC(_ source: NSValue?)
      -> CMTimeRange {
    let unwrappedSource = source!
    precondition(strcmp(unwrappedSource.objCType,
                        _getObjCTypeEncoding(CMTimeRange.self)) == 0,
                 "NSValue does not contain the right type to bridge to CMTimeRange")
    return { $0.timeRangeValue }(unwrappedSource)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/AVFoundation/NSValue.swift.gyb", line: 24)


extension CMTimeMapping: _ObjectiveCBridgeable {
  public func _bridgeToObjectiveC() -> NSValue {
    return { NSValue(timeMapping: $0) }(self)
  }

  public static func _forceBridgeFromObjectiveC(_ source: NSValue,
                                                result: inout CMTimeMapping?) {
    precondition(strcmp(source.objCType,
                        _getObjCTypeEncoding(CMTimeMapping.self)) == 0,
                 "NSValue does not contain the right type to bridge to CMTimeMapping")
    result = { $0.timeMappingValue }(source)
  }

  public static func _conditionallyBridgeFromObjectiveC(_ source: NSValue,
                                                        result: inout CMTimeMapping?)
      -> Bool {
    if strcmp(source.objCType, _getObjCTypeEncoding(CMTimeMapping.self)) != 0 {
      result = nil
      return false
    }
    result = { $0.timeMappingValue }(source)
    return true
  }

  public static func _unconditionallyBridgeFromObjectiveC(_ source: NSValue?)
      -> CMTimeMapping {
    let unwrappedSource = source!
    precondition(strcmp(unwrappedSource.objCType,
                        _getObjCTypeEncoding(CMTimeMapping.self)) == 0,
                 "NSValue does not contain the right type to bridge to CMTimeMapping")
    return { $0.timeMappingValue }(unwrappedSource)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/AVFoundation/NSValue.swift.gyb", line: 29)

