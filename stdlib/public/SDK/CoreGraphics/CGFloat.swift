// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 1)
//===--- CGFloat.swift.gyb ------------------------------------*- swift -*-===//
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

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 21)

@_exported import CoreGraphics
import Darwin

@_fixed_layout
public struct CGFloat {
#if arch(i386) || arch(arm)
  /// The native type used to store the CGFloat, which is Float on
  /// 32-bit architectures and Double on 64-bit architectures.
  public typealias NativeType = Float
#elseif arch(x86_64) || arch(arm64)
  /// The native type used to store the CGFloat, which is Float on
  /// 32-bit architectures and Double on 64-bit architectures.
  public typealias NativeType = Double
#endif

  @_transparent public init() {
    self.native = 0.0
  }

  @_transparent public init(_ value: Float) {
    self.native = NativeType(value)
  }

  @_transparent public init(_ value: Double) {
    self.native = NativeType(value)
  }

#if !os(Windows) && (arch(i386) || arch(x86_64))
  @_transparent public init(_ value: Float80) {
    self.native = NativeType(value)
  }
#endif

  @_transparent public init(_ value: CGFloat) {
    self.native = value.native
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: UInt8) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: Int8) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: UInt16) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: Int16) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: UInt32) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: Int32) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: UInt64) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: Int64) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: UInt) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 60)
  @_transparent public init(_ value: Int) {
    self.native = NativeType(value)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 65)

  /// The native value.
  public var native: NativeType
}

extension CGFloat : SignedNumeric {
  // FIXME(integers): implement properly
  public init?<T : BinaryInteger>(exactly source: T) {
    fatalError()
  }

  @_transparent
  public var magnitude: CGFloat {
    return CGFloat(Swift.abs(native))
  }

}

extension CGFloat : BinaryFloatingPoint {

  public typealias RawSignificand = UInt
  public typealias Exponent = Int

  @_transparent
  public static var exponentBitCount: Int {
    return NativeType.exponentBitCount
  }

  @_transparent
  public static var significandBitCount: Int {
    return NativeType.significandBitCount
  }

  //  Conversions to/from integer encoding.  These are not part of the
  //  BinaryFloatingPoint prototype because there's no guarantee that an
  //  integer type of the same size actually exists (e.g. Float80).
  @_transparent
  public var bitPattern: UInt {
    return UInt(native.bitPattern)
  }

  @_transparent
  public init(bitPattern: UInt) {
    native = NativeType(bitPattern: UInt64(bitPattern))
  }

  @_transparent
  public var sign: FloatingPointSign {
    return native.sign
  }

  @_transparent
  public var exponentBitPattern: UInt {
    return native.exponentBitPattern
  }

  @_transparent
  public var significandBitPattern: UInt {
    return UInt(native.significandBitPattern)
  }

  @_transparent
  public init(sign: FloatingPointSign,
              exponentBitPattern: UInt,
              significandBitPattern: UInt) {
    native = NativeType(sign: sign,
      exponentBitPattern: exponentBitPattern,
      significandBitPattern: NativeType.RawSignificand(significandBitPattern))
  }

  @_transparent
  public init(nan payload: RawSignificand, signaling: Bool) {
    native = NativeType(nan: NativeType.RawSignificand(payload),
                        signaling: signaling)
  }

  @_transparent
  public static var infinity: CGFloat {
    return CGFloat(NativeType.infinity)
  }

  @_transparent
  public static var nan: CGFloat {
    return CGFloat(NativeType.nan)
  }

  @_transparent
  public static var signalingNaN: CGFloat {
    return CGFloat(NativeType.signalingNaN)
  }

  @available(*, unavailable, renamed: "nan")
  public static var quietNaN: CGFloat {
    fatalError("unavailable")
  }

  @_transparent
  public static var greatestFiniteMagnitude: CGFloat {
    return CGFloat(NativeType.greatestFiniteMagnitude)
  }

  @_transparent
  public static var pi: CGFloat {
    return CGFloat(NativeType.pi)
  }

  @_transparent
  public var ulp: CGFloat {
    return CGFloat(native.ulp)
  }

  @_transparent
  public static var leastNormalMagnitude: CGFloat {
    return CGFloat(NativeType.leastNormalMagnitude)
  }

  @_transparent
  public static var leastNonzeroMagnitude: CGFloat {
    return CGFloat(NativeType.leastNonzeroMagnitude)
  }

  @_transparent
  public var exponent: Int {
    return native.exponent
  }

  @_transparent
  public var significand: CGFloat {
    return CGFloat(native.significand)
  }

  @_transparent
  public init(sign: FloatingPointSign, exponent: Int, significand: CGFloat) {
    native = NativeType(sign: sign,
      exponent: exponent, significand: significand.native)
  }

  @_transparent
  public mutating func round(_ rule: FloatingPointRoundingRule) {
    native.round(rule)
  }

  @_transparent
  public var nextUp: CGFloat {
    return CGFloat(native.nextUp)
  }

  public mutating func negate() {
    native.negate()
  }

  @_transparent
  public static func +=(_ lhs: inout CGFloat, _ rhs: CGFloat) {
    lhs.native += rhs.native
  }

  @_transparent
  public static func -=(_ lhs: inout CGFloat, _ rhs: CGFloat) {
    lhs.native -= rhs.native
  }

  @_transparent
  public static func *=(_ lhs: inout CGFloat, _ rhs: CGFloat) {
    lhs.native *= rhs.native
  }

  @_transparent
  public static func /=(_ lhs: inout CGFloat, _ rhs: CGFloat) {
    lhs.native /= rhs.native
  }

  @_transparent
  public mutating func formTruncatingRemainder(dividingBy other: CGFloat) {
    native.formTruncatingRemainder(dividingBy: other.native)
  }

  @_transparent
  public mutating func formRemainder(dividingBy other: CGFloat) {
    native.formRemainder(dividingBy: other.native)
  }

  @_transparent
  public mutating func formSquareRoot( ) {
    native.formSquareRoot( )
  }

  @_transparent
  public mutating func addProduct(_ lhs: CGFloat, _ rhs: CGFloat) {
    native.addProduct(lhs.native, rhs.native)
  }

  @_transparent
  public func isEqual(to other: CGFloat) -> Bool {
    return self.native.isEqual(to: other.native)
  }

  @_transparent
  public func isLess(than other: CGFloat) -> Bool {
    return self.native.isLess(than: other.native)
  }

  @_transparent
  public func isLessThanOrEqualTo(_ other: CGFloat) -> Bool {
    return self.native.isLessThanOrEqualTo(other.native)
  }

  @_transparent
  public var isNormal:  Bool {
    return native.isNormal
  }

  @_transparent
  public var isFinite:  Bool {
    return native.isFinite
  }

  public var isZero:  Bool {
    return native.isZero
  }

  public var isSubnormal:  Bool {
    return native.isSubnormal
  }

  public var isInfinite:  Bool {
    return native.isInfinite
  }

  public var isNaN:  Bool {
    return native.isNaN
  }

  public var isSignalingNaN: Bool {
    return native.isSignalingNaN
  }

  @available(*, unavailable, renamed: "isSignalingNaN")
  public var isSignaling: Bool {
    fatalError("unavailable")
  }

  public var isCanonical: Bool {
    return true
  }

  public var floatingPointClass: FloatingPointClassification {
    return native.floatingPointClass
  }

  public var binade: CGFloat {
    return CGFloat(native.binade)
  }

  public var significandWidth: Int {
    return native.significandWidth
  }

  /// Create an instance initialized to `value`.
  @_transparent
  public init(floatLiteral value: NativeType) {
    native = value
  }

  /// Create an instance initialized to `value`.
  @_transparent
  public init(integerLiteral value: Int) {
    native = NativeType(value)
  }
}

extension CGFloat {
  @available(*, unavailable, renamed: "leastNormalMagnitude")
  public static var min: CGFloat {
    fatalError("unavailable")
  }

  @available(*, unavailable, renamed: "greatestFiniteMagnitude")
  public static var max: CGFloat {
    fatalError("unavailable")
  }

  @available(swift, deprecated: 3.1, obsoleted: 4.0, message: "Please use the `abs(_:)` free function")
  @_transparent
  public static func abs(_ x: CGFloat) -> CGFloat {
    return x.magnitude
  }
}

@available(*, unavailable, renamed: "CGFloat.leastNormalMagnitude")
public var CGFLOAT_MIN: CGFloat {
  fatalError("unavailable")
}

@available(*, unavailable, renamed: "CGFloat.greatestFiniteMagnitude")
public var CGFLOAT_MAX: CGFloat {
  fatalError("unavailable")
}

extension CGFloat : CustomReflectable {
  /// Returns a mirror that reflects `self`.
  public var customMirror: Mirror {
    return Mirror(reflecting: native)
  }
}

extension CGFloat : CustomStringConvertible {
  /// A textual representation of `self`.
  @_transparent
  public var description: String {
    return native.description
  }
}

extension CGFloat : Hashable {
  /// The hash value.
  ///
  /// **Axiom:** `x == y` implies `x.hashValue == y.hashValue`
  ///
  /// - Note: the hash value is not guaranteed to be stable across
  ///   different invocations of the same program.  Do not persist the
  ///   hash value across program runs.
  @_transparent
  public var hashValue: Int {
    return native.hashValue
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension UInt8 {
  @_transparent
  public init(_ value: CGFloat) {
    self = UInt8(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension Int8 {
  @_transparent
  public init(_ value: CGFloat) {
    self = Int8(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension UInt16 {
  @_transparent
  public init(_ value: CGFloat) {
    self = UInt16(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension Int16 {
  @_transparent
  public init(_ value: CGFloat) {
    self = Int16(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension UInt32 {
  @_transparent
  public init(_ value: CGFloat) {
    self = UInt32(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension Int32 {
  @_transparent
  public init(_ value: CGFloat) {
    self = Int32(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension UInt64 {
  @_transparent
  public init(_ value: CGFloat) {
    self = UInt64(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension Int64 {
  @_transparent
  public init(_ value: CGFloat) {
    self = Int64(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension UInt {
  @_transparent
  public init(_ value: CGFloat) {
    self = UInt(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 393)

extension Int {
  @_transparent
  public init(_ value: CGFloat) {
    self = Int(value.native)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 402)


extension Double {
  @_transparent
  public init(_ value: CGFloat) {
    self = Double(value.native)
  }
}

extension Float {
  @_transparent
  public init(_ value: CGFloat) {
    self = Float(value.native)
  }
}

//===----------------------------------------------------------------------===//
// Standard Operator Table
//===----------------------------------------------------------------------===//

//  TODO: These should not be necessary, since they're already provided by
//  <T: FloatingPoint>, but in practice they are currently needed to
//  disambiguate overloads.  We should find a way to remove them, either by
//  tweaking the overload resolution rules, or by removing the other
//  definitions in the standard lib, or both.

extension CGFloat {
  @_transparent
  public static func +(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

  @_transparent
  public static func -(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

  @_transparent
  public static func *(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

  @_transparent
  public static func /(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }
}

//===----------------------------------------------------------------------===//
// Strideable Conformance
//===----------------------------------------------------------------------===//

extension CGFloat : Strideable {
  /// Returns a stride `x` such that `self.advanced(by: x)` approximates
  /// `other`.
  ///
  /// - Complexity: O(1).
  @_transparent
  public func distance(to other: CGFloat) -> CGFloat {
    return CGFloat(other.native - self.native)
  }

  /// Returns a `Self` `x` such that `self.distance(to: x)` approximates
  /// `n`.
  ///
  /// - Complexity: O(1).
  @_transparent
  public func advanced(by amount: CGFloat) -> CGFloat {
    return CGFloat(self.native + amount.native)
  }
}

//===----------------------------------------------------------------------===//
// Deprecated operators
//===----------------------------------------------------------------------===//

@_transparent
@available(*, unavailable, message: "Use truncatingRemainder instead")
public func %(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
  fatalError("% is not available.")
}

@_transparent
@available(*, unavailable, message: "Use formTruncatingRemainder instead")
public func %=(lhs: inout CGFloat, rhs: CGFloat) {
  fatalError("%= is not available.")
}

//===----------------------------------------------------------------------===//
// tgmath
//===----------------------------------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 516)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func acos(_ x: CGFloat) -> CGFloat {
  return CGFloat(acos(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func asin(_ x: CGFloat) -> CGFloat {
  return CGFloat(asin(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func atan(_ x: CGFloat) -> CGFloat {
  return CGFloat(atan(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func cos(_ x: CGFloat) -> CGFloat {
  return CGFloat(cos(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func sin(_ x: CGFloat) -> CGFloat {
  return CGFloat(sin(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func tan(_ x: CGFloat) -> CGFloat {
  return CGFloat(tan(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func acosh(_ x: CGFloat) -> CGFloat {
  return CGFloat(acosh(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func asinh(_ x: CGFloat) -> CGFloat {
  return CGFloat(asinh(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func atanh(_ x: CGFloat) -> CGFloat {
  return CGFloat(atanh(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func cosh(_ x: CGFloat) -> CGFloat {
  return CGFloat(cosh(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func sinh(_ x: CGFloat) -> CGFloat {
  return CGFloat(sinh(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func tanh(_ x: CGFloat) -> CGFloat {
  return CGFloat(tanh(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func exp(_ x: CGFloat) -> CGFloat {
  return CGFloat(exp(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func exp2(_ x: CGFloat) -> CGFloat {
  return CGFloat(exp2(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func expm1(_ x: CGFloat) -> CGFloat {
  return CGFloat(expm1(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func log(_ x: CGFloat) -> CGFloat {
  return CGFloat(log(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func log10(_ x: CGFloat) -> CGFloat {
  return CGFloat(log10(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func log1p(_ x: CGFloat) -> CGFloat {
  return CGFloat(log1p(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func log2(_ x: CGFloat) -> CGFloat {
  return CGFloat(log2(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func logb(_ x: CGFloat) -> CGFloat {
  return CGFloat(logb(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func cbrt(_ x: CGFloat) -> CGFloat {
  return CGFloat(cbrt(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func erf(_ x: CGFloat) -> CGFloat {
  return CGFloat(erf(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func erfc(_ x: CGFloat) -> CGFloat {
  return CGFloat(erfc(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func tgamma(_ x: CGFloat) -> CGFloat {
  return CGFloat(tgamma(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func nearbyint(_ x: CGFloat) -> CGFloat {
  return CGFloat(nearbyint(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 518)
@_transparent
public func rint(_ x: CGFloat) -> CGFloat {
  return CGFloat(rint(x.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 524)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 526)
@_transparent
public func atan2(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
  return CGFloat(atan2(lhs.native, rhs.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 526)
@_transparent
public func hypot(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
  return CGFloat(hypot(lhs.native, rhs.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 526)
@_transparent
public func pow(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
  return CGFloat(pow(lhs.native, rhs.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 526)
@_transparent
public func copysign(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
  return CGFloat(copysign(lhs.native, rhs.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 526)
@_transparent
public func nextafter(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
  return CGFloat(nextafter(lhs.native, rhs.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 526)
@_transparent
public func fdim(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
  return CGFloat(fdim(lhs.native, rhs.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 526)
@_transparent
public func fmax(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
  return CGFloat(fmax(lhs.native, rhs.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 526)
@_transparent
public func fmin(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
  return CGFloat(fmin(lhs.native, rhs.native))
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/CoreGraphics/CGFloat.swift.gyb", line: 532)

@_transparent
@available(*, unavailable, message: "use the floatingPointClass property.")
public func fpclassify(_ x: CGFloat) -> Int {
  fatalError("unavailable")
}

@available(*, unavailable, message: "use the isNormal property.")
public func isnormal(_ value: CGFloat) -> Bool { return value.isNormal }

@available(*, unavailable, message: "use the isFinite property.")
public func isfinite(_ value: CGFloat) -> Bool { return value.isFinite }

@available(*, unavailable, message: "use the isInfinite property.")
public func isinf(_ value: CGFloat) -> Bool { return value.isInfinite }

@available(*, unavailable, message: "use the isNaN property.")
public func isnan(_ value: CGFloat) -> Bool { return value.isNaN }

@available(*, unavailable, message: "use the sign property.")
public func signbit(_ value: CGFloat) -> Int { return value.sign.rawValue }

@available(swift, deprecated: 4.2, renamed: "scalbn")
@_transparent
public func ldexp(_ x: CGFloat, _ n: Int) -> CGFloat {
  return CGFloat(ldexp(x.native, n))
}

@available(swift, deprecated: 4.2, message: "use the exponent property.")
@_transparent
public func ilogb(_ x: CGFloat) -> Int {
  return Int(x.exponent)
}

@_transparent
public func lgamma(_ x: CGFloat) -> (CGFloat, Int) {
  let (value, sign) = lgamma(x.native)
  return (CGFloat(value), sign)
}

@_transparent
public func remquo(_ x: CGFloat, _ y: CGFloat) -> (CGFloat, Int) {
  let (rem, quo) = remquo(x.native, y.native)
  return (CGFloat(rem), quo)
}

@available(*, deprecated: 4.2, message:
           "use CGFloat(nan: CGFloat.RawSignificand) instead.")
@_transparent
public func nan(_ tag: String) -> CGFloat {
  return CGFloat(nan(tag) as CGFloat.NativeType)
}

@_transparent
public func j0(_ x: CGFloat) -> CGFloat {
  return CGFloat(j0(Double(x.native)))
}

@_transparent
public func j1(_ x: CGFloat) -> CGFloat {
  return CGFloat(j1(Double(x.native)))
}

@_transparent
public func jn(_ n: Int, _ x: CGFloat) -> CGFloat {
  return CGFloat(jn(n, Double(x.native)))
}

@_transparent
public func y0(_ x: CGFloat) -> CGFloat {
  return CGFloat(y0(Double(x.native)))
}

@_transparent
public func y1(_ x: CGFloat) -> CGFloat {
  return CGFloat(y1(Double(x.native)))
}

@_transparent
public func yn(_ n: Int, _ x: CGFloat) -> CGFloat {
  return CGFloat(yn(n, Double(x.native)))
}

extension CGFloat : _CVarArgPassedAsDouble, _CVarArgAligned {
  /// Transform `self` into a series of machine words that can be
  /// appropriately interpreted by C varargs
  @_transparent
  public var _cVarArgEncoding: [Int] {
    return native._cVarArgEncoding
  }

  /// Return the required alignment in bytes of
  /// the value returned by `_cVarArgEncoding`.
  @_transparent
  public var _cVarArgAlignment: Int {
    return native._cVarArgAlignment
  }
}

extension CGFloat : Codable {
  @_transparent
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    do {
      self.native = try container.decode(NativeType.self)
    } catch DecodingError.typeMismatch(let type, let context) {
      // We may have encoded as a different type on a different platform. A
      // strict fixed-format decoder may disallow a conversion, so let's try the
      // other type.
      do {
        if NativeType.self == Float.self {
          self.native = NativeType(try container.decode(Double.self))
        } else {
          self.native = NativeType(try container.decode(Float.self))
        }
      } catch {
        // Failed to decode as the other type, too. This is neither a Float nor
        // a Double. Throw the old error; we don't want to clobber the original
        // info.
        throw DecodingError.typeMismatch(type, context)
      }
    }
  }

  @_transparent
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(self.native)
  }
}
