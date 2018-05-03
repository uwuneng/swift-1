// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreLocation/NSValue.swift.gyb", line: 1)
@_exported import CoreLocation
import Foundation

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreLocation/NSValue.swift.gyb", line: 7)


extension CLLocationCoordinate2D: _ObjectiveCBridgeable {
  public func _bridgeToObjectiveC() -> NSValue {
    var myself = self
    return NSValue(bytes: &myself, objCType: _getObjCTypeEncoding(CLLocationCoordinate2D.self))
  }

  public static func _forceBridgeFromObjectiveC(_ source: NSValue,
                                                result: inout CLLocationCoordinate2D?) {
    precondition(strcmp(source.objCType,
                        _getObjCTypeEncoding(CLLocationCoordinate2D.self)) == 0,
                 "NSValue does not contain the right type to bridge to CLLocationCoordinate2D")
    result = CLLocationCoordinate2D()
    source.getValue(&result!)
  }

  public static func _conditionallyBridgeFromObjectiveC(_ source: NSValue,
                                                        result: inout CLLocationCoordinate2D?)
      -> Bool {
    if strcmp(source.objCType, _getObjCTypeEncoding(CLLocationCoordinate2D.self)) != 0 {
      result = nil
      return false
    }
    result = CLLocationCoordinate2D()
    source.getValue(&result!)
    return true
  }

  public static func _unconditionallyBridgeFromObjectiveC(_ source: NSValue?)
      -> CLLocationCoordinate2D {
    let unwrappedSource = source!
    precondition(strcmp(unwrappedSource.objCType,
                        _getObjCTypeEncoding(CLLocationCoordinate2D.self)) == 0,
                 "NSValue does not contain the right type to bridge to CLLocationCoordinate2D")
    var result = CLLocationCoordinate2D()
    unwrappedSource.getValue(&result)
    return result
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreLocation/NSValue.swift.gyb", line: 8)

