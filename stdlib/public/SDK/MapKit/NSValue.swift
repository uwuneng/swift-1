// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/MapKit/NSValue.swift.gyb", line: 1)
@_exported import MapKit // Clang module
import Foundation

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/MapKit/NSValue.swift.gyb", line: 7)


extension MKCoordinateSpan: _ObjectiveCBridgeable {
  public func _bridgeToObjectiveC() -> NSValue {
    var myself = self
    return NSValue(bytes: &myself, objCType: _getObjCTypeEncoding(MKCoordinateSpan.self))
  }

  public static func _forceBridgeFromObjectiveC(_ source: NSValue,
                                                result: inout MKCoordinateSpan?) {
    precondition(strcmp(source.objCType,
                        _getObjCTypeEncoding(MKCoordinateSpan.self)) == 0,
                 "NSValue does not contain the right type to bridge to MKCoordinateSpan")
    result = MKCoordinateSpan()
    source.getValue(&result!)
  }

  public static func _conditionallyBridgeFromObjectiveC(_ source: NSValue,
                                                        result: inout MKCoordinateSpan?)
      -> Bool {
    if strcmp(source.objCType, _getObjCTypeEncoding(MKCoordinateSpan.self)) != 0 {
      result = nil
      return false
    }
    result = MKCoordinateSpan()
    source.getValue(&result!)
    return true
  }

  public static func _unconditionallyBridgeFromObjectiveC(_ source: NSValue?)
      -> MKCoordinateSpan {
    let unwrappedSource = source!
    precondition(strcmp(unwrappedSource.objCType,
                        _getObjCTypeEncoding(MKCoordinateSpan.self)) == 0,
                 "NSValue does not contain the right type to bridge to MKCoordinateSpan")
    var result = MKCoordinateSpan()
    unwrappedSource.getValue(&result)
    return result
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/MapKit/NSValue.swift.gyb", line: 8)

