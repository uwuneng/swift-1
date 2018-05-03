// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 1)
//===----------------------------------------------------------*- swift -*-===//
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
// simd.h overlays for Swift
//===----------------------------------------------------------------------===//

import Swift
import Darwin
@_exported import simd

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 27)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of two `Float`.  This corresponds to the C and
/// Obj-C type `vector_float2` and the C++ type `simd::float2`.
@_fixed_layout
@_alignment(8)
public struct float2 {

  public var _value: Builtin.Vec2xFPIEEE32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : Float {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec2xFPIEEE32_Int32(_value,
        (0 as Int32)._value)

      return Float(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec2xFPIEEE32_FPIEEE32_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : Float {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec2xFPIEEE32_Int32(_value,
        (1 as Int32)._value)

      return Float(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec2xFPIEEE32_FPIEEE32_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec2xFPIEEE32) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: Float, _ y: Float) {
    var v: Builtin.Vec2xFPIEEE32 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec2xFPIEEE32_FPIEEE32_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec2xFPIEEE32_FPIEEE32_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: Float, y: Float) {
    self.init(x, y)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: Float) {
    self.init(scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly two elements.
  public init(_ array: [Float]) {
  _precondition(array.count == 2,
                "float2 requires a two-element array")
    self.init(array[0], array[1])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> Float {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 2, "Vector index out of range")
      let elt = Builtin.extractelement_Vec2xFPIEEE32_Int32(_value,
        Int32(index)._value)
      return Float(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 2, "Vector index out of range")
      _value = Builtin.insertelement_Vec2xFPIEEE32_FPIEEE32_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension float2 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: float2, _ rhs: float2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension float2 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "float2(\(self[0]), \(self[1]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension float2 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly two
  ///   elements.
  public init(arrayLiteral elements: Float...) { self.init(elements) }
}

extension float2 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 2 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension float2 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func +(lhs: float2, rhs: float2) -> float2 {
    return float2(Builtin.fadd_Vec2xFPIEEE32(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func -(lhs: float2, rhs: float2) -> float2 {
    return float2(Builtin.fsub_Vec2xFPIEEE32(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: float2) -> float2 {
    return float2() - rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func *(lhs: float2, rhs: float2) -> float2 {
    return float2(Builtin.fmul_Vec2xFPIEEE32(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: Float, rhs: float2) -> float2 {
    return float2(lhs) * rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: float2, rhs: Float) -> float2 {
    return lhs * float2(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: float2, rhs: float2) -> float2 {
    return float2(Builtin.fdiv_Vec2xFPIEEE32(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: float2, rhs: Float) -> float2 {
    return lhs / float2(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 234)
  @_transparent
  public static func +=(lhs: inout float2, rhs: float2) -> Void {
    lhs = lhs + rhs
  }

  /// Subtract `rhs` from `lhs`.
  @_transparent
  public static func -=(lhs: inout float2, rhs: float2) -> Void {
    lhs = lhs - rhs
  }

  /// Multiply `lhs` by `rhs` (elementwise).
  @_transparent
  public static func *=(lhs: inout float2, rhs: float2) -> Void {
    lhs = lhs * rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout float2, rhs: float2) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 259)
  /// Scales `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout float2, rhs: Float) -> Void {
    lhs = lhs * rhs
  }

  /// Scales `lhs` by `1/rhs`.
  @_transparent
  public static func /=(lhs: inout float2, rhs: Float) -> Void {
    lhs = lhs / rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 332)
/// Elementwise absolute value of a vector.  The result is a vector of the same
/// length with all elements positive.
@_transparent
public func abs(_ x: float2) -> float2 {
  return simd_abs(x)
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: float2, _ y: float2) -> float2 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: float2, _ y: float2) -> float2 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: float2, _ scalar: Float) -> float2 {
  return min(vector, float2(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: float2, _ scalar: Float) -> float2 {
  return max(vector, float2(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: float2, min: float2, max: float2)
  -> float2 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: float2, min: Float, max: Float)
  -> float2 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: float2) -> Float {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: float2) -> Float {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: float2) -> Float {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 404)

/// Sign of a vector.  Each lane contains -1 if the corresponding lane of `x`
/// is less than zero, +1 if the corresponding lane of `x` is greater than
/// zero, and 0 otherwise.
@_transparent
public func sign(_ x: float2) -> float2 {
  return simd_sign(x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: float2, _ y: float2, t: float2) -> float2 {
  return x + t*(y-x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: float2, _ y: float2, t: Float) -> float2 {
  return x + t*(y-x)
}

/// Elementwise reciprocal.
@_transparent
public func recip(_ x: float2) -> float2 {
  return simd_recip(x)
}

/// Elementwise reciprocal square root.
@_transparent
public func rsqrt(_ x: float2) -> float2 {
  return simd_rsqrt(x)
}

/// Alternate name for minimum of two floating-point vectors.
@_transparent
public func fmin(_ x: float2, _ y: float2) -> float2 {
  return min(x, y)
}

/// Alternate name for maximum of two floating-point vectors.
@_transparent
public func fmax(_ x: float2, _ y: float2) -> float2 {
  return max(x, y)
}

/// Each element of the result is the smallest integral value greater than or
/// equal to the corresponding element of the input.
@_transparent
public func ceil(_ x: float2) -> float2 {
  return __tg_ceil(x)
}

/// Each element of the result is the largest integral value less than or equal
/// to the corresponding element of the input.
@_transparent
public func floor(_ x: float2) -> float2 {
  return __tg_floor(x)
}

/// Each element of the result is the closest integral value with magnitude
/// less than or equal to that of the corresponding element of the input.
@_transparent
public func trunc(_ x: float2) -> float2 {
  return __tg_trunc(x)
}

/// `x - floor(x)`, clamped to lie in the range [0,1).  Without this clamp step,
/// the result would be 1.0 when `x` is a very small negative number, which may
/// result in out-of-bounds table accesses in common usage.
@_transparent
public func fract(_ x: float2) -> float2 {
  return simd_fract(x)
}

/// 0.0 if `x < edge`, and 1.0 otherwise.
@_transparent
public func step(_ x: float2, edge: float2) -> float2 {
  return simd_step(edge, x)
}

/// 0.0 if `x < edge0`, 1.0 if `x > edge1`, and cubic interpolation between
/// 0 and 1 in the interval [edge0, edge1].
@_transparent
public func smoothstep(_ x: float2, edge0: float2, edge1: float2)
  -> float2 {
  return simd_smoothstep(edge0, edge1, x)
}

/// Dot product of `x` and `y`.
@_transparent
public func dot(_ x: float2, _ y: float2) -> Float {
  return reduce_add(x * y)
}

/// Projection of `x` onto `y`.
@_transparent
public func project(_ x: float2, _ y: float2) -> float2 {
  return simd_project(x, y)
}

/// Length of `x`, squared.  This is more efficient to compute than the length,
/// so you should use it if you only need to compare lengths to each other.
/// I.e. instead of writing:
///
///   if (length(x) < length(y)) { ... }
///
/// use:
///
///   if (length_squared(x) < length_squared(y)) { ... }
///
/// Doing it this way avoids one or two square roots, which is a fairly costly
/// operation.
@_transparent
public func length_squared(_ x: float2) -> Float {
  return dot(x, x)
}

/// Length (two-norm or "Euclidean norm") of `x`.
@_transparent
public func length(_ x: float2) -> Float {
  return sqrt(length_squared(x))
}

/// The one-norm (or "taxicab norm") of `x`.
@_transparent
public func norm_one(_ x: float2) -> Float {
  return reduce_add(abs(x))
}

/// The infinity-norm (or "sup norm") of `x`.
@_transparent
public func norm_inf(_ x: float2) -> Float {
  return reduce_max(abs(x))
}

/// Distance between `x` and `y`, squared.
@_transparent
public func distance_squared(_ x: float2, _ y: float2) -> Float {
  return length_squared(x - y)
}

/// Distance between `x` and `y`.
@_transparent
public func distance(_ x: float2, _ y: float2) -> Float {
  return length(x - y)
}

/// Unit vector pointing in the same direction as `x`.
@_transparent
public func normalize(_ x: float2) -> float2 {
  return simd_normalize(x)
}

/// `x` reflected through the hyperplane with unit normal vector `n`, passing
/// through the origin.  E.g. if `x` is [1,2,3] and `n` is [0,0,1], the result
/// is [1,2,-3].
@_transparent
public func reflect(_ x: float2, n: float2) -> float2 {
  return simd_reflect(x, n)
}

/// The refraction direction given unit incident vector `x`, unit surface
/// normal `n`, and index of refraction `eta`.  If the angle between the
/// incident vector and the surface is so small that total internal reflection
/// occurs, zero is returned.
@_transparent
public func refract(_ x: float2, n: float2, eta: Float)
  -> float2 {
  return simd_refract(x, n, eta)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of three `Float`.  This corresponds to the C and
/// Obj-C type `vector_float3` and the C++ type `simd::float3`.
@_fixed_layout
@_alignment(16)
public struct float3 {

  public var _value: Builtin.Vec3xFPIEEE32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : Float {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xFPIEEE32_Int32(_value,
        (0 as Int32)._value)

      return Float(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xFPIEEE32_FPIEEE32_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : Float {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xFPIEEE32_Int32(_value,
        (1 as Int32)._value)

      return Float(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xFPIEEE32_FPIEEE32_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var z : Float {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xFPIEEE32_Int32(_value,
        (2 as Int32)._value)

      return Float(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xFPIEEE32_FPIEEE32_Int32(_value,
        newValue._value,
        (2 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec3xFPIEEE32) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: Float, _ y: Float, _ z: Float) {
    var v: Builtin.Vec3xFPIEEE32 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xFPIEEE32_FPIEEE32_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xFPIEEE32_FPIEEE32_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xFPIEEE32_FPIEEE32_Int32(v,
      z._value,
      (2 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: Float, y: Float, z: Float) {
    self.init(x, y, z)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: Float) {
    self.init(scalar, scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly three elements.
  public init(_ array: [Float]) {
  _precondition(array.count == 3,
                "float3 requires a three-element array")
    self.init(array[0], array[1], array[2])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> Float {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 3, "Vector index out of range")
      let elt = Builtin.extractelement_Vec3xFPIEEE32_Int32(_value,
        Int32(index)._value)
      return Float(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 3, "Vector index out of range")
      _value = Builtin.insertelement_Vec3xFPIEEE32_FPIEEE32_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension float3 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: float3, _ rhs: float3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension float3 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "float3(\(self[0]), \(self[1]), \(self[2]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]), \(self[2]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension float3 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly three
  ///   elements.
  public init(arrayLiteral elements: Float...) { self.init(elements) }
}

extension float3 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 3 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension float3 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func +(lhs: float3, rhs: float3) -> float3 {
    return float3(Builtin.fadd_Vec3xFPIEEE32(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func -(lhs: float3, rhs: float3) -> float3 {
    return float3(Builtin.fsub_Vec3xFPIEEE32(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: float3) -> float3 {
    return float3() - rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func *(lhs: float3, rhs: float3) -> float3 {
    return float3(Builtin.fmul_Vec3xFPIEEE32(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: Float, rhs: float3) -> float3 {
    return float3(lhs) * rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: float3, rhs: Float) -> float3 {
    return lhs * float3(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: float3, rhs: float3) -> float3 {
    return float3(Builtin.fdiv_Vec3xFPIEEE32(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: float3, rhs: Float) -> float3 {
    return lhs / float3(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 234)
  @_transparent
  public static func +=(lhs: inout float3, rhs: float3) -> Void {
    lhs = lhs + rhs
  }

  /// Subtract `rhs` from `lhs`.
  @_transparent
  public static func -=(lhs: inout float3, rhs: float3) -> Void {
    lhs = lhs - rhs
  }

  /// Multiply `lhs` by `rhs` (elementwise).
  @_transparent
  public static func *=(lhs: inout float3, rhs: float3) -> Void {
    lhs = lhs * rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout float3, rhs: float3) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 259)
  /// Scales `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout float3, rhs: Float) -> Void {
    lhs = lhs * rhs
  }

  /// Scales `lhs` by `1/rhs`.
  @_transparent
  public static func /=(lhs: inout float3, rhs: Float) -> Void {
    lhs = lhs / rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 332)
/// Elementwise absolute value of a vector.  The result is a vector of the same
/// length with all elements positive.
@_transparent
public func abs(_ x: float3) -> float3 {
  return simd_abs(x)
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: float3, _ y: float3) -> float3 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: float3, _ y: float3) -> float3 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: float3, _ scalar: Float) -> float3 {
  return min(vector, float3(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: float3, _ scalar: Float) -> float3 {
  return max(vector, float3(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: float3, min: float3, max: float3)
  -> float3 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: float3, min: Float, max: Float)
  -> float3 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: float3) -> Float {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: float3) -> Float {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: float3) -> Float {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 404)

/// Sign of a vector.  Each lane contains -1 if the corresponding lane of `x`
/// is less than zero, +1 if the corresponding lane of `x` is greater than
/// zero, and 0 otherwise.
@_transparent
public func sign(_ x: float3) -> float3 {
  return simd_sign(x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: float3, _ y: float3, t: float3) -> float3 {
  return x + t*(y-x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: float3, _ y: float3, t: Float) -> float3 {
  return x + t*(y-x)
}

/// Elementwise reciprocal.
@_transparent
public func recip(_ x: float3) -> float3 {
  return simd_recip(x)
}

/// Elementwise reciprocal square root.
@_transparent
public func rsqrt(_ x: float3) -> float3 {
  return simd_rsqrt(x)
}

/// Alternate name for minimum of two floating-point vectors.
@_transparent
public func fmin(_ x: float3, _ y: float3) -> float3 {
  return min(x, y)
}

/// Alternate name for maximum of two floating-point vectors.
@_transparent
public func fmax(_ x: float3, _ y: float3) -> float3 {
  return max(x, y)
}

/// Each element of the result is the smallest integral value greater than or
/// equal to the corresponding element of the input.
@_transparent
public func ceil(_ x: float3) -> float3 {
  return __tg_ceil(x)
}

/// Each element of the result is the largest integral value less than or equal
/// to the corresponding element of the input.
@_transparent
public func floor(_ x: float3) -> float3 {
  return __tg_floor(x)
}

/// Each element of the result is the closest integral value with magnitude
/// less than or equal to that of the corresponding element of the input.
@_transparent
public func trunc(_ x: float3) -> float3 {
  return __tg_trunc(x)
}

/// `x - floor(x)`, clamped to lie in the range [0,1).  Without this clamp step,
/// the result would be 1.0 when `x` is a very small negative number, which may
/// result in out-of-bounds table accesses in common usage.
@_transparent
public func fract(_ x: float3) -> float3 {
  return simd_fract(x)
}

/// 0.0 if `x < edge`, and 1.0 otherwise.
@_transparent
public func step(_ x: float3, edge: float3) -> float3 {
  return simd_step(edge, x)
}

/// 0.0 if `x < edge0`, 1.0 if `x > edge1`, and cubic interpolation between
/// 0 and 1 in the interval [edge0, edge1].
@_transparent
public func smoothstep(_ x: float3, edge0: float3, edge1: float3)
  -> float3 {
  return simd_smoothstep(edge0, edge1, x)
}

/// Dot product of `x` and `y`.
@_transparent
public func dot(_ x: float3, _ y: float3) -> Float {
  return reduce_add(x * y)
}

/// Projection of `x` onto `y`.
@_transparent
public func project(_ x: float3, _ y: float3) -> float3 {
  return simd_project(x, y)
}

/// Length of `x`, squared.  This is more efficient to compute than the length,
/// so you should use it if you only need to compare lengths to each other.
/// I.e. instead of writing:
///
///   if (length(x) < length(y)) { ... }
///
/// use:
///
///   if (length_squared(x) < length_squared(y)) { ... }
///
/// Doing it this way avoids one or two square roots, which is a fairly costly
/// operation.
@_transparent
public func length_squared(_ x: float3) -> Float {
  return dot(x, x)
}

/// Length (two-norm or "Euclidean norm") of `x`.
@_transparent
public func length(_ x: float3) -> Float {
  return sqrt(length_squared(x))
}

/// The one-norm (or "taxicab norm") of `x`.
@_transparent
public func norm_one(_ x: float3) -> Float {
  return reduce_add(abs(x))
}

/// The infinity-norm (or "sup norm") of `x`.
@_transparent
public func norm_inf(_ x: float3) -> Float {
  return reduce_max(abs(x))
}

/// Distance between `x` and `y`, squared.
@_transparent
public func distance_squared(_ x: float3, _ y: float3) -> Float {
  return length_squared(x - y)
}

/// Distance between `x` and `y`.
@_transparent
public func distance(_ x: float3, _ y: float3) -> Float {
  return length(x - y)
}

/// Unit vector pointing in the same direction as `x`.
@_transparent
public func normalize(_ x: float3) -> float3 {
  return simd_normalize(x)
}

/// `x` reflected through the hyperplane with unit normal vector `n`, passing
/// through the origin.  E.g. if `x` is [1,2,3] and `n` is [0,0,1], the result
/// is [1,2,-3].
@_transparent
public func reflect(_ x: float3, n: float3) -> float3 {
  return simd_reflect(x, n)
}

/// The refraction direction given unit incident vector `x`, unit surface
/// normal `n`, and index of refraction `eta`.  If the angle between the
/// incident vector and the surface is so small that total internal reflection
/// occurs, zero is returned.
@_transparent
public func refract(_ x: float3, n: float3, eta: Float)
  -> float3 {
  return simd_refract(x, n, eta)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of four `Float`.  This corresponds to the C and
/// Obj-C type `vector_float4` and the C++ type `simd::float4`.
@_fixed_layout
@_alignment(16)
public struct float4 {

  public var _value: Builtin.Vec4xFPIEEE32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : Float {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xFPIEEE32_Int32(_value,
        (0 as Int32)._value)

      return Float(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xFPIEEE32_FPIEEE32_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : Float {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xFPIEEE32_Int32(_value,
        (1 as Int32)._value)

      return Float(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xFPIEEE32_FPIEEE32_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var z : Float {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xFPIEEE32_Int32(_value,
        (2 as Int32)._value)

      return Float(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xFPIEEE32_FPIEEE32_Int32(_value,
        newValue._value,
        (2 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var w : Float {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xFPIEEE32_Int32(_value,
        (3 as Int32)._value)

      return Float(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xFPIEEE32_FPIEEE32_Int32(_value,
        newValue._value,
        (3 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec4xFPIEEE32) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
    var v: Builtin.Vec4xFPIEEE32 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xFPIEEE32_FPIEEE32_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xFPIEEE32_FPIEEE32_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xFPIEEE32_FPIEEE32_Int32(v,
      z._value,
      (2 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xFPIEEE32_FPIEEE32_Int32(v,
      w._value,
      (3 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: Float, y: Float, z: Float, w: Float) {
    self.init(x, y, z, w)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: Float) {
    self.init(scalar, scalar, scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly four elements.
  public init(_ array: [Float]) {
  _precondition(array.count == 4,
                "float4 requires a four-element array")
    self.init(array[0], array[1], array[2], array[3])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> Float {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 4, "Vector index out of range")
      let elt = Builtin.extractelement_Vec4xFPIEEE32_Int32(_value,
        Int32(index)._value)
      return Float(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 4, "Vector index out of range")
      _value = Builtin.insertelement_Vec4xFPIEEE32_FPIEEE32_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension float4 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: float4, _ rhs: float4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension float4 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "float4(\(self[0]), \(self[1]), \(self[2]), \(self[3]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]), \(self[2]), \(self[3]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension float4 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly four
  ///   elements.
  public init(arrayLiteral elements: Float...) { self.init(elements) }
}

extension float4 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 4 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension float4 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func +(lhs: float4, rhs: float4) -> float4 {
    return float4(Builtin.fadd_Vec4xFPIEEE32(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func -(lhs: float4, rhs: float4) -> float4 {
    return float4(Builtin.fsub_Vec4xFPIEEE32(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: float4) -> float4 {
    return float4() - rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func *(lhs: float4, rhs: float4) -> float4 {
    return float4(Builtin.fmul_Vec4xFPIEEE32(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: Float, rhs: float4) -> float4 {
    return float4(lhs) * rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: float4, rhs: Float) -> float4 {
    return lhs * float4(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: float4, rhs: float4) -> float4 {
    return float4(Builtin.fdiv_Vec4xFPIEEE32(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: float4, rhs: Float) -> float4 {
    return lhs / float4(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 234)
  @_transparent
  public static func +=(lhs: inout float4, rhs: float4) -> Void {
    lhs = lhs + rhs
  }

  /// Subtract `rhs` from `lhs`.
  @_transparent
  public static func -=(lhs: inout float4, rhs: float4) -> Void {
    lhs = lhs - rhs
  }

  /// Multiply `lhs` by `rhs` (elementwise).
  @_transparent
  public static func *=(lhs: inout float4, rhs: float4) -> Void {
    lhs = lhs * rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout float4, rhs: float4) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 259)
  /// Scales `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout float4, rhs: Float) -> Void {
    lhs = lhs * rhs
  }

  /// Scales `lhs` by `1/rhs`.
  @_transparent
  public static func /=(lhs: inout float4, rhs: Float) -> Void {
    lhs = lhs / rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 332)
/// Elementwise absolute value of a vector.  The result is a vector of the same
/// length with all elements positive.
@_transparent
public func abs(_ x: float4) -> float4 {
  return simd_abs(x)
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: float4, _ y: float4) -> float4 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: float4, _ y: float4) -> float4 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: float4, _ scalar: Float) -> float4 {
  return min(vector, float4(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: float4, _ scalar: Float) -> float4 {
  return max(vector, float4(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: float4, min: float4, max: float4)
  -> float4 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: float4, min: Float, max: Float)
  -> float4 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: float4) -> Float {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: float4) -> Float {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: float4) -> Float {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 404)

/// Sign of a vector.  Each lane contains -1 if the corresponding lane of `x`
/// is less than zero, +1 if the corresponding lane of `x` is greater than
/// zero, and 0 otherwise.
@_transparent
public func sign(_ x: float4) -> float4 {
  return simd_sign(x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: float4, _ y: float4, t: float4) -> float4 {
  return x + t*(y-x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: float4, _ y: float4, t: Float) -> float4 {
  return x + t*(y-x)
}

/// Elementwise reciprocal.
@_transparent
public func recip(_ x: float4) -> float4 {
  return simd_recip(x)
}

/// Elementwise reciprocal square root.
@_transparent
public func rsqrt(_ x: float4) -> float4 {
  return simd_rsqrt(x)
}

/// Alternate name for minimum of two floating-point vectors.
@_transparent
public func fmin(_ x: float4, _ y: float4) -> float4 {
  return min(x, y)
}

/// Alternate name for maximum of two floating-point vectors.
@_transparent
public func fmax(_ x: float4, _ y: float4) -> float4 {
  return max(x, y)
}

/// Each element of the result is the smallest integral value greater than or
/// equal to the corresponding element of the input.
@_transparent
public func ceil(_ x: float4) -> float4 {
  return __tg_ceil(x)
}

/// Each element of the result is the largest integral value less than or equal
/// to the corresponding element of the input.
@_transparent
public func floor(_ x: float4) -> float4 {
  return __tg_floor(x)
}

/// Each element of the result is the closest integral value with magnitude
/// less than or equal to that of the corresponding element of the input.
@_transparent
public func trunc(_ x: float4) -> float4 {
  return __tg_trunc(x)
}

/// `x - floor(x)`, clamped to lie in the range [0,1).  Without this clamp step,
/// the result would be 1.0 when `x` is a very small negative number, which may
/// result in out-of-bounds table accesses in common usage.
@_transparent
public func fract(_ x: float4) -> float4 {
  return simd_fract(x)
}

/// 0.0 if `x < edge`, and 1.0 otherwise.
@_transparent
public func step(_ x: float4, edge: float4) -> float4 {
  return simd_step(edge, x)
}

/// 0.0 if `x < edge0`, 1.0 if `x > edge1`, and cubic interpolation between
/// 0 and 1 in the interval [edge0, edge1].
@_transparent
public func smoothstep(_ x: float4, edge0: float4, edge1: float4)
  -> float4 {
  return simd_smoothstep(edge0, edge1, x)
}

/// Dot product of `x` and `y`.
@_transparent
public func dot(_ x: float4, _ y: float4) -> Float {
  return reduce_add(x * y)
}

/// Projection of `x` onto `y`.
@_transparent
public func project(_ x: float4, _ y: float4) -> float4 {
  return simd_project(x, y)
}

/// Length of `x`, squared.  This is more efficient to compute than the length,
/// so you should use it if you only need to compare lengths to each other.
/// I.e. instead of writing:
///
///   if (length(x) < length(y)) { ... }
///
/// use:
///
///   if (length_squared(x) < length_squared(y)) { ... }
///
/// Doing it this way avoids one or two square roots, which is a fairly costly
/// operation.
@_transparent
public func length_squared(_ x: float4) -> Float {
  return dot(x, x)
}

/// Length (two-norm or "Euclidean norm") of `x`.
@_transparent
public func length(_ x: float4) -> Float {
  return sqrt(length_squared(x))
}

/// The one-norm (or "taxicab norm") of `x`.
@_transparent
public func norm_one(_ x: float4) -> Float {
  return reduce_add(abs(x))
}

/// The infinity-norm (or "sup norm") of `x`.
@_transparent
public func norm_inf(_ x: float4) -> Float {
  return reduce_max(abs(x))
}

/// Distance between `x` and `y`, squared.
@_transparent
public func distance_squared(_ x: float4, _ y: float4) -> Float {
  return length_squared(x - y)
}

/// Distance between `x` and `y`.
@_transparent
public func distance(_ x: float4, _ y: float4) -> Float {
  return length(x - y)
}

/// Unit vector pointing in the same direction as `x`.
@_transparent
public func normalize(_ x: float4) -> float4 {
  return simd_normalize(x)
}

/// `x` reflected through the hyperplane with unit normal vector `n`, passing
/// through the origin.  E.g. if `x` is [1,2,3] and `n` is [0,0,1], the result
/// is [1,2,-3].
@_transparent
public func reflect(_ x: float4, n: float4) -> float4 {
  return simd_reflect(x, n)
}

/// The refraction direction given unit incident vector `x`, unit surface
/// normal `n`, and index of refraction `eta`.  If the angle between the
/// incident vector and the surface is so small that total internal reflection
/// occurs, zero is returned.
@_transparent
public func refract(_ x: float4, n: float4, eta: Float)
  -> float4 {
  return simd_refract(x, n, eta)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 580)
//  Scalar versions of common operations:

/// Returns -1 if `x < 0`, +1 if `x > 0`, and 0 otherwise (`sign(NaN)` is 0).
@_transparent
public func sign(_ x: Float) -> Float {
  return simd_sign(x)
}

/// Reciprocal.
@_transparent
public func recip(_ x: Float) -> Float {
  return simd_recip(x)
}

/// Reciprocal square root.
@_transparent
public func rsqrt(_ x: Float) -> Float {
  return simd_rsqrt(x)
}

/// Returns 0.0 if `x < edge`, and 1.0 otherwise.
@_transparent
public func step(_ x: Float, edge: Float) -> Float {
  return simd_step(edge, x)
}

/// Interprets two two-dimensional vectors as three-dimensional vectors in the
/// xy-plane and computes their cross product, which lies along the z-axis.
@_transparent
public func cross(_ x: float2, _ y: float2)
  -> float3 {
  return simd_cross(x,y)
}

/// Cross-product of two three-dimensional vectors.  The resulting vector is
/// perpendicular to the plane determined by `x` and `y`, with length equal to
/// the oriented area of the parallelogram they determine.
@_transparent
public func cross(_ x: float3, _ y: float3)
  -> float3 {
  return simd_cross(x,y)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of two `Double`.  This corresponds to the C and
/// Obj-C type `vector_double2` and the C++ type `simd::double2`.
@_fixed_layout
@_alignment(16)
public struct double2 {

  public var _value: Builtin.Vec2xFPIEEE64

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : Double {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec2xFPIEEE64_Int32(_value,
        (0 as Int32)._value)

      return Double(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec2xFPIEEE64_FPIEEE64_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : Double {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec2xFPIEEE64_Int32(_value,
        (1 as Int32)._value)

      return Double(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec2xFPIEEE64_FPIEEE64_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec2xFPIEEE64) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: Double, _ y: Double) {
    var v: Builtin.Vec2xFPIEEE64 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec2xFPIEEE64_FPIEEE64_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec2xFPIEEE64_FPIEEE64_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: Double, y: Double) {
    self.init(x, y)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: Double) {
    self.init(scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly two elements.
  public init(_ array: [Double]) {
  _precondition(array.count == 2,
                "double2 requires a two-element array")
    self.init(array[0], array[1])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> Double {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 2, "Vector index out of range")
      let elt = Builtin.extractelement_Vec2xFPIEEE64_Int32(_value,
        Int32(index)._value)
      return Double(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 2, "Vector index out of range")
      _value = Builtin.insertelement_Vec2xFPIEEE64_FPIEEE64_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension double2 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: double2, _ rhs: double2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension double2 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "double2(\(self[0]), \(self[1]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension double2 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly two
  ///   elements.
  public init(arrayLiteral elements: Double...) { self.init(elements) }
}

extension double2 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 2 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension double2 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func +(lhs: double2, rhs: double2) -> double2 {
    return double2(Builtin.fadd_Vec2xFPIEEE64(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func -(lhs: double2, rhs: double2) -> double2 {
    return double2(Builtin.fsub_Vec2xFPIEEE64(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: double2) -> double2 {
    return double2() - rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func *(lhs: double2, rhs: double2) -> double2 {
    return double2(Builtin.fmul_Vec2xFPIEEE64(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: Double, rhs: double2) -> double2 {
    return double2(lhs) * rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: double2, rhs: Double) -> double2 {
    return lhs * double2(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: double2, rhs: double2) -> double2 {
    return double2(Builtin.fdiv_Vec2xFPIEEE64(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: double2, rhs: Double) -> double2 {
    return lhs / double2(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 234)
  @_transparent
  public static func +=(lhs: inout double2, rhs: double2) -> Void {
    lhs = lhs + rhs
  }

  /// Subtract `rhs` from `lhs`.
  @_transparent
  public static func -=(lhs: inout double2, rhs: double2) -> Void {
    lhs = lhs - rhs
  }

  /// Multiply `lhs` by `rhs` (elementwise).
  @_transparent
  public static func *=(lhs: inout double2, rhs: double2) -> Void {
    lhs = lhs * rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout double2, rhs: double2) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 259)
  /// Scales `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout double2, rhs: Double) -> Void {
    lhs = lhs * rhs
  }

  /// Scales `lhs` by `1/rhs`.
  @_transparent
  public static func /=(lhs: inout double2, rhs: Double) -> Void {
    lhs = lhs / rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 332)
/// Elementwise absolute value of a vector.  The result is a vector of the same
/// length with all elements positive.
@_transparent
public func abs(_ x: double2) -> double2 {
  return simd_abs(x)
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: double2, _ y: double2) -> double2 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: double2, _ y: double2) -> double2 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: double2, _ scalar: Double) -> double2 {
  return min(vector, double2(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: double2, _ scalar: Double) -> double2 {
  return max(vector, double2(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: double2, min: double2, max: double2)
  -> double2 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: double2, min: Double, max: Double)
  -> double2 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: double2) -> Double {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: double2) -> Double {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: double2) -> Double {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 404)

/// Sign of a vector.  Each lane contains -1 if the corresponding lane of `x`
/// is less than zero, +1 if the corresponding lane of `x` is greater than
/// zero, and 0 otherwise.
@_transparent
public func sign(_ x: double2) -> double2 {
  return simd_sign(x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: double2, _ y: double2, t: double2) -> double2 {
  return x + t*(y-x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: double2, _ y: double2, t: Double) -> double2 {
  return x + t*(y-x)
}

/// Elementwise reciprocal.
@_transparent
public func recip(_ x: double2) -> double2 {
  return simd_recip(x)
}

/// Elementwise reciprocal square root.
@_transparent
public func rsqrt(_ x: double2) -> double2 {
  return simd_rsqrt(x)
}

/// Alternate name for minimum of two floating-point vectors.
@_transparent
public func fmin(_ x: double2, _ y: double2) -> double2 {
  return min(x, y)
}

/// Alternate name for maximum of two floating-point vectors.
@_transparent
public func fmax(_ x: double2, _ y: double2) -> double2 {
  return max(x, y)
}

/// Each element of the result is the smallest integral value greater than or
/// equal to the corresponding element of the input.
@_transparent
public func ceil(_ x: double2) -> double2 {
  return __tg_ceil(x)
}

/// Each element of the result is the largest integral value less than or equal
/// to the corresponding element of the input.
@_transparent
public func floor(_ x: double2) -> double2 {
  return __tg_floor(x)
}

/// Each element of the result is the closest integral value with magnitude
/// less than or equal to that of the corresponding element of the input.
@_transparent
public func trunc(_ x: double2) -> double2 {
  return __tg_trunc(x)
}

/// `x - floor(x)`, clamped to lie in the range [0,1).  Without this clamp step,
/// the result would be 1.0 when `x` is a very small negative number, which may
/// result in out-of-bounds table accesses in common usage.
@_transparent
public func fract(_ x: double2) -> double2 {
  return simd_fract(x)
}

/// 0.0 if `x < edge`, and 1.0 otherwise.
@_transparent
public func step(_ x: double2, edge: double2) -> double2 {
  return simd_step(edge, x)
}

/// 0.0 if `x < edge0`, 1.0 if `x > edge1`, and cubic interpolation between
/// 0 and 1 in the interval [edge0, edge1].
@_transparent
public func smoothstep(_ x: double2, edge0: double2, edge1: double2)
  -> double2 {
  return simd_smoothstep(edge0, edge1, x)
}

/// Dot product of `x` and `y`.
@_transparent
public func dot(_ x: double2, _ y: double2) -> Double {
  return reduce_add(x * y)
}

/// Projection of `x` onto `y`.
@_transparent
public func project(_ x: double2, _ y: double2) -> double2 {
  return simd_project(x, y)
}

/// Length of `x`, squared.  This is more efficient to compute than the length,
/// so you should use it if you only need to compare lengths to each other.
/// I.e. instead of writing:
///
///   if (length(x) < length(y)) { ... }
///
/// use:
///
///   if (length_squared(x) < length_squared(y)) { ... }
///
/// Doing it this way avoids one or two square roots, which is a fairly costly
/// operation.
@_transparent
public func length_squared(_ x: double2) -> Double {
  return dot(x, x)
}

/// Length (two-norm or "Euclidean norm") of `x`.
@_transparent
public func length(_ x: double2) -> Double {
  return sqrt(length_squared(x))
}

/// The one-norm (or "taxicab norm") of `x`.
@_transparent
public func norm_one(_ x: double2) -> Double {
  return reduce_add(abs(x))
}

/// The infinity-norm (or "sup norm") of `x`.
@_transparent
public func norm_inf(_ x: double2) -> Double {
  return reduce_max(abs(x))
}

/// Distance between `x` and `y`, squared.
@_transparent
public func distance_squared(_ x: double2, _ y: double2) -> Double {
  return length_squared(x - y)
}

/// Distance between `x` and `y`.
@_transparent
public func distance(_ x: double2, _ y: double2) -> Double {
  return length(x - y)
}

/// Unit vector pointing in the same direction as `x`.
@_transparent
public func normalize(_ x: double2) -> double2 {
  return simd_normalize(x)
}

/// `x` reflected through the hyperplane with unit normal vector `n`, passing
/// through the origin.  E.g. if `x` is [1,2,3] and `n` is [0,0,1], the result
/// is [1,2,-3].
@_transparent
public func reflect(_ x: double2, n: double2) -> double2 {
  return simd_reflect(x, n)
}

/// The refraction direction given unit incident vector `x`, unit surface
/// normal `n`, and index of refraction `eta`.  If the angle between the
/// incident vector and the surface is so small that total internal reflection
/// occurs, zero is returned.
@_transparent
public func refract(_ x: double2, n: double2, eta: Double)
  -> double2 {
  return simd_refract(x, n, eta)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of three `Double`.  This corresponds to the C and
/// Obj-C type `vector_double3` and the C++ type `simd::double3`.
@_fixed_layout
@_alignment(32)
public struct double3 {

  public var _value: Builtin.Vec3xFPIEEE64

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : Double {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xFPIEEE64_Int32(_value,
        (0 as Int32)._value)

      return Double(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xFPIEEE64_FPIEEE64_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : Double {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xFPIEEE64_Int32(_value,
        (1 as Int32)._value)

      return Double(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xFPIEEE64_FPIEEE64_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var z : Double {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xFPIEEE64_Int32(_value,
        (2 as Int32)._value)

      return Double(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xFPIEEE64_FPIEEE64_Int32(_value,
        newValue._value,
        (2 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec3xFPIEEE64) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: Double, _ y: Double, _ z: Double) {
    var v: Builtin.Vec3xFPIEEE64 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xFPIEEE64_FPIEEE64_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xFPIEEE64_FPIEEE64_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xFPIEEE64_FPIEEE64_Int32(v,
      z._value,
      (2 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: Double, y: Double, z: Double) {
    self.init(x, y, z)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: Double) {
    self.init(scalar, scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly three elements.
  public init(_ array: [Double]) {
  _precondition(array.count == 3,
                "double3 requires a three-element array")
    self.init(array[0], array[1], array[2])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> Double {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 3, "Vector index out of range")
      let elt = Builtin.extractelement_Vec3xFPIEEE64_Int32(_value,
        Int32(index)._value)
      return Double(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 3, "Vector index out of range")
      _value = Builtin.insertelement_Vec3xFPIEEE64_FPIEEE64_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension double3 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: double3, _ rhs: double3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension double3 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "double3(\(self[0]), \(self[1]), \(self[2]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]), \(self[2]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension double3 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly three
  ///   elements.
  public init(arrayLiteral elements: Double...) { self.init(elements) }
}

extension double3 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 3 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension double3 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func +(lhs: double3, rhs: double3) -> double3 {
    return double3(Builtin.fadd_Vec3xFPIEEE64(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func -(lhs: double3, rhs: double3) -> double3 {
    return double3(Builtin.fsub_Vec3xFPIEEE64(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: double3) -> double3 {
    return double3() - rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func *(lhs: double3, rhs: double3) -> double3 {
    return double3(Builtin.fmul_Vec3xFPIEEE64(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: Double, rhs: double3) -> double3 {
    return double3(lhs) * rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: double3, rhs: Double) -> double3 {
    return lhs * double3(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: double3, rhs: double3) -> double3 {
    return double3(Builtin.fdiv_Vec3xFPIEEE64(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: double3, rhs: Double) -> double3 {
    return lhs / double3(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 234)
  @_transparent
  public static func +=(lhs: inout double3, rhs: double3) -> Void {
    lhs = lhs + rhs
  }

  /// Subtract `rhs` from `lhs`.
  @_transparent
  public static func -=(lhs: inout double3, rhs: double3) -> Void {
    lhs = lhs - rhs
  }

  /// Multiply `lhs` by `rhs` (elementwise).
  @_transparent
  public static func *=(lhs: inout double3, rhs: double3) -> Void {
    lhs = lhs * rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout double3, rhs: double3) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 259)
  /// Scales `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout double3, rhs: Double) -> Void {
    lhs = lhs * rhs
  }

  /// Scales `lhs` by `1/rhs`.
  @_transparent
  public static func /=(lhs: inout double3, rhs: Double) -> Void {
    lhs = lhs / rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 332)
/// Elementwise absolute value of a vector.  The result is a vector of the same
/// length with all elements positive.
@_transparent
public func abs(_ x: double3) -> double3 {
  return simd_abs(x)
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: double3, _ y: double3) -> double3 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: double3, _ y: double3) -> double3 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: double3, _ scalar: Double) -> double3 {
  return min(vector, double3(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: double3, _ scalar: Double) -> double3 {
  return max(vector, double3(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: double3, min: double3, max: double3)
  -> double3 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: double3, min: Double, max: Double)
  -> double3 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: double3) -> Double {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: double3) -> Double {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: double3) -> Double {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 404)

/// Sign of a vector.  Each lane contains -1 if the corresponding lane of `x`
/// is less than zero, +1 if the corresponding lane of `x` is greater than
/// zero, and 0 otherwise.
@_transparent
public func sign(_ x: double3) -> double3 {
  return simd_sign(x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: double3, _ y: double3, t: double3) -> double3 {
  return x + t*(y-x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: double3, _ y: double3, t: Double) -> double3 {
  return x + t*(y-x)
}

/// Elementwise reciprocal.
@_transparent
public func recip(_ x: double3) -> double3 {
  return simd_recip(x)
}

/// Elementwise reciprocal square root.
@_transparent
public func rsqrt(_ x: double3) -> double3 {
  return simd_rsqrt(x)
}

/// Alternate name for minimum of two floating-point vectors.
@_transparent
public func fmin(_ x: double3, _ y: double3) -> double3 {
  return min(x, y)
}

/// Alternate name for maximum of two floating-point vectors.
@_transparent
public func fmax(_ x: double3, _ y: double3) -> double3 {
  return max(x, y)
}

/// Each element of the result is the smallest integral value greater than or
/// equal to the corresponding element of the input.
@_transparent
public func ceil(_ x: double3) -> double3 {
  return __tg_ceil(x)
}

/// Each element of the result is the largest integral value less than or equal
/// to the corresponding element of the input.
@_transparent
public func floor(_ x: double3) -> double3 {
  return __tg_floor(x)
}

/// Each element of the result is the closest integral value with magnitude
/// less than or equal to that of the corresponding element of the input.
@_transparent
public func trunc(_ x: double3) -> double3 {
  return __tg_trunc(x)
}

/// `x - floor(x)`, clamped to lie in the range [0,1).  Without this clamp step,
/// the result would be 1.0 when `x` is a very small negative number, which may
/// result in out-of-bounds table accesses in common usage.
@_transparent
public func fract(_ x: double3) -> double3 {
  return simd_fract(x)
}

/// 0.0 if `x < edge`, and 1.0 otherwise.
@_transparent
public func step(_ x: double3, edge: double3) -> double3 {
  return simd_step(edge, x)
}

/// 0.0 if `x < edge0`, 1.0 if `x > edge1`, and cubic interpolation between
/// 0 and 1 in the interval [edge0, edge1].
@_transparent
public func smoothstep(_ x: double3, edge0: double3, edge1: double3)
  -> double3 {
  return simd_smoothstep(edge0, edge1, x)
}

/// Dot product of `x` and `y`.
@_transparent
public func dot(_ x: double3, _ y: double3) -> Double {
  return reduce_add(x * y)
}

/// Projection of `x` onto `y`.
@_transparent
public func project(_ x: double3, _ y: double3) -> double3 {
  return simd_project(x, y)
}

/// Length of `x`, squared.  This is more efficient to compute than the length,
/// so you should use it if you only need to compare lengths to each other.
/// I.e. instead of writing:
///
///   if (length(x) < length(y)) { ... }
///
/// use:
///
///   if (length_squared(x) < length_squared(y)) { ... }
///
/// Doing it this way avoids one or two square roots, which is a fairly costly
/// operation.
@_transparent
public func length_squared(_ x: double3) -> Double {
  return dot(x, x)
}

/// Length (two-norm or "Euclidean norm") of `x`.
@_transparent
public func length(_ x: double3) -> Double {
  return sqrt(length_squared(x))
}

/// The one-norm (or "taxicab norm") of `x`.
@_transparent
public func norm_one(_ x: double3) -> Double {
  return reduce_add(abs(x))
}

/// The infinity-norm (or "sup norm") of `x`.
@_transparent
public func norm_inf(_ x: double3) -> Double {
  return reduce_max(abs(x))
}

/// Distance between `x` and `y`, squared.
@_transparent
public func distance_squared(_ x: double3, _ y: double3) -> Double {
  return length_squared(x - y)
}

/// Distance between `x` and `y`.
@_transparent
public func distance(_ x: double3, _ y: double3) -> Double {
  return length(x - y)
}

/// Unit vector pointing in the same direction as `x`.
@_transparent
public func normalize(_ x: double3) -> double3 {
  return simd_normalize(x)
}

/// `x` reflected through the hyperplane with unit normal vector `n`, passing
/// through the origin.  E.g. if `x` is [1,2,3] and `n` is [0,0,1], the result
/// is [1,2,-3].
@_transparent
public func reflect(_ x: double3, n: double3) -> double3 {
  return simd_reflect(x, n)
}

/// The refraction direction given unit incident vector `x`, unit surface
/// normal `n`, and index of refraction `eta`.  If the angle between the
/// incident vector and the surface is so small that total internal reflection
/// occurs, zero is returned.
@_transparent
public func refract(_ x: double3, n: double3, eta: Double)
  -> double3 {
  return simd_refract(x, n, eta)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of four `Double`.  This corresponds to the C and
/// Obj-C type `vector_double4` and the C++ type `simd::double4`.
@_fixed_layout
@_alignment(32)
public struct double4 {

  public var _value: Builtin.Vec4xFPIEEE64

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : Double {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xFPIEEE64_Int32(_value,
        (0 as Int32)._value)

      return Double(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xFPIEEE64_FPIEEE64_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : Double {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xFPIEEE64_Int32(_value,
        (1 as Int32)._value)

      return Double(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xFPIEEE64_FPIEEE64_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var z : Double {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xFPIEEE64_Int32(_value,
        (2 as Int32)._value)

      return Double(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xFPIEEE64_FPIEEE64_Int32(_value,
        newValue._value,
        (2 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var w : Double {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xFPIEEE64_Int32(_value,
        (3 as Int32)._value)

      return Double(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xFPIEEE64_FPIEEE64_Int32(_value,
        newValue._value,
        (3 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec4xFPIEEE64) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: Double, _ y: Double, _ z: Double, _ w: Double) {
    var v: Builtin.Vec4xFPIEEE64 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xFPIEEE64_FPIEEE64_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xFPIEEE64_FPIEEE64_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xFPIEEE64_FPIEEE64_Int32(v,
      z._value,
      (2 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xFPIEEE64_FPIEEE64_Int32(v,
      w._value,
      (3 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: Double, y: Double, z: Double, w: Double) {
    self.init(x, y, z, w)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: Double) {
    self.init(scalar, scalar, scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly four elements.
  public init(_ array: [Double]) {
  _precondition(array.count == 4,
                "double4 requires a four-element array")
    self.init(array[0], array[1], array[2], array[3])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> Double {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 4, "Vector index out of range")
      let elt = Builtin.extractelement_Vec4xFPIEEE64_Int32(_value,
        Int32(index)._value)
      return Double(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 4, "Vector index out of range")
      _value = Builtin.insertelement_Vec4xFPIEEE64_FPIEEE64_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension double4 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: double4, _ rhs: double4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension double4 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "double4(\(self[0]), \(self[1]), \(self[2]), \(self[3]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]), \(self[2]), \(self[3]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension double4 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly four
  ///   elements.
  public init(arrayLiteral elements: Double...) { self.init(elements) }
}

extension double4 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 4 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension double4 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func +(lhs: double4, rhs: double4) -> double4 {
    return double4(Builtin.fadd_Vec4xFPIEEE64(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func -(lhs: double4, rhs: double4) -> double4 {
    return double4(Builtin.fsub_Vec4xFPIEEE64(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: double4) -> double4 {
    return double4() - rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func *(lhs: double4, rhs: double4) -> double4 {
    return double4(Builtin.fmul_Vec4xFPIEEE64(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: Double, rhs: double4) -> double4 {
    return double4(lhs) * rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func *(lhs: double4, rhs: Double) -> double4 {
    return lhs * double4(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: double4, rhs: double4) -> double4 {
    return double4(Builtin.fdiv_Vec4xFPIEEE64(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: double4, rhs: Double) -> double4 {
    return lhs / double4(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 234)
  @_transparent
  public static func +=(lhs: inout double4, rhs: double4) -> Void {
    lhs = lhs + rhs
  }

  /// Subtract `rhs` from `lhs`.
  @_transparent
  public static func -=(lhs: inout double4, rhs: double4) -> Void {
    lhs = lhs - rhs
  }

  /// Multiply `lhs` by `rhs` (elementwise).
  @_transparent
  public static func *=(lhs: inout double4, rhs: double4) -> Void {
    lhs = lhs * rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout double4, rhs: double4) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 259)
  /// Scales `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout double4, rhs: Double) -> Void {
    lhs = lhs * rhs
  }

  /// Scales `lhs` by `1/rhs`.
  @_transparent
  public static func /=(lhs: inout double4, rhs: Double) -> Void {
    lhs = lhs / rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 332)
/// Elementwise absolute value of a vector.  The result is a vector of the same
/// length with all elements positive.
@_transparent
public func abs(_ x: double4) -> double4 {
  return simd_abs(x)
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: double4, _ y: double4) -> double4 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: double4, _ y: double4) -> double4 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: double4, _ scalar: Double) -> double4 {
  return min(vector, double4(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: double4, _ scalar: Double) -> double4 {
  return max(vector, double4(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: double4, min: double4, max: double4)
  -> double4 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: double4, min: Double, max: Double)
  -> double4 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: double4) -> Double {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: double4) -> Double {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: double4) -> Double {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 404)

/// Sign of a vector.  Each lane contains -1 if the corresponding lane of `x`
/// is less than zero, +1 if the corresponding lane of `x` is greater than
/// zero, and 0 otherwise.
@_transparent
public func sign(_ x: double4) -> double4 {
  return simd_sign(x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: double4, _ y: double4, t: double4) -> double4 {
  return x + t*(y-x)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.
@_transparent
public func mix(_ x: double4, _ y: double4, t: Double) -> double4 {
  return x + t*(y-x)
}

/// Elementwise reciprocal.
@_transparent
public func recip(_ x: double4) -> double4 {
  return simd_recip(x)
}

/// Elementwise reciprocal square root.
@_transparent
public func rsqrt(_ x: double4) -> double4 {
  return simd_rsqrt(x)
}

/// Alternate name for minimum of two floating-point vectors.
@_transparent
public func fmin(_ x: double4, _ y: double4) -> double4 {
  return min(x, y)
}

/// Alternate name for maximum of two floating-point vectors.
@_transparent
public func fmax(_ x: double4, _ y: double4) -> double4 {
  return max(x, y)
}

/// Each element of the result is the smallest integral value greater than or
/// equal to the corresponding element of the input.
@_transparent
public func ceil(_ x: double4) -> double4 {
  return __tg_ceil(x)
}

/// Each element of the result is the largest integral value less than or equal
/// to the corresponding element of the input.
@_transparent
public func floor(_ x: double4) -> double4 {
  return __tg_floor(x)
}

/// Each element of the result is the closest integral value with magnitude
/// less than or equal to that of the corresponding element of the input.
@_transparent
public func trunc(_ x: double4) -> double4 {
  return __tg_trunc(x)
}

/// `x - floor(x)`, clamped to lie in the range [0,1).  Without this clamp step,
/// the result would be 1.0 when `x` is a very small negative number, which may
/// result in out-of-bounds table accesses in common usage.
@_transparent
public func fract(_ x: double4) -> double4 {
  return simd_fract(x)
}

/// 0.0 if `x < edge`, and 1.0 otherwise.
@_transparent
public func step(_ x: double4, edge: double4) -> double4 {
  return simd_step(edge, x)
}

/// 0.0 if `x < edge0`, 1.0 if `x > edge1`, and cubic interpolation between
/// 0 and 1 in the interval [edge0, edge1].
@_transparent
public func smoothstep(_ x: double4, edge0: double4, edge1: double4)
  -> double4 {
  return simd_smoothstep(edge0, edge1, x)
}

/// Dot product of `x` and `y`.
@_transparent
public func dot(_ x: double4, _ y: double4) -> Double {
  return reduce_add(x * y)
}

/// Projection of `x` onto `y`.
@_transparent
public func project(_ x: double4, _ y: double4) -> double4 {
  return simd_project(x, y)
}

/// Length of `x`, squared.  This is more efficient to compute than the length,
/// so you should use it if you only need to compare lengths to each other.
/// I.e. instead of writing:
///
///   if (length(x) < length(y)) { ... }
///
/// use:
///
///   if (length_squared(x) < length_squared(y)) { ... }
///
/// Doing it this way avoids one or two square roots, which is a fairly costly
/// operation.
@_transparent
public func length_squared(_ x: double4) -> Double {
  return dot(x, x)
}

/// Length (two-norm or "Euclidean norm") of `x`.
@_transparent
public func length(_ x: double4) -> Double {
  return sqrt(length_squared(x))
}

/// The one-norm (or "taxicab norm") of `x`.
@_transparent
public func norm_one(_ x: double4) -> Double {
  return reduce_add(abs(x))
}

/// The infinity-norm (or "sup norm") of `x`.
@_transparent
public func norm_inf(_ x: double4) -> Double {
  return reduce_max(abs(x))
}

/// Distance between `x` and `y`, squared.
@_transparent
public func distance_squared(_ x: double4, _ y: double4) -> Double {
  return length_squared(x - y)
}

/// Distance between `x` and `y`.
@_transparent
public func distance(_ x: double4, _ y: double4) -> Double {
  return length(x - y)
}

/// Unit vector pointing in the same direction as `x`.
@_transparent
public func normalize(_ x: double4) -> double4 {
  return simd_normalize(x)
}

/// `x` reflected through the hyperplane with unit normal vector `n`, passing
/// through the origin.  E.g. if `x` is [1,2,3] and `n` is [0,0,1], the result
/// is [1,2,-3].
@_transparent
public func reflect(_ x: double4, n: double4) -> double4 {
  return simd_reflect(x, n)
}

/// The refraction direction given unit incident vector `x`, unit surface
/// normal `n`, and index of refraction `eta`.  If the angle between the
/// incident vector and the surface is so small that total internal reflection
/// occurs, zero is returned.
@_transparent
public func refract(_ x: double4, n: double4, eta: Double)
  -> double4 {
  return simd_refract(x, n, eta)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 580)
//  Scalar versions of common operations:

/// Returns -1 if `x < 0`, +1 if `x > 0`, and 0 otherwise (`sign(NaN)` is 0).
@_transparent
public func sign(_ x: Double) -> Double {
  return simd_sign(x)
}

/// Reciprocal.
@_transparent
public func recip(_ x: Double) -> Double {
  return simd_recip(x)
}

/// Reciprocal square root.
@_transparent
public func rsqrt(_ x: Double) -> Double {
  return simd_rsqrt(x)
}

/// Returns 0.0 if `x < edge`, and 1.0 otherwise.
@_transparent
public func step(_ x: Double, edge: Double) -> Double {
  return simd_step(edge, x)
}

/// Interprets two two-dimensional vectors as three-dimensional vectors in the
/// xy-plane and computes their cross product, which lies along the z-axis.
@_transparent
public func cross(_ x: double2, _ y: double2)
  -> double3 {
  return simd_cross(x,y)
}

/// Cross-product of two three-dimensional vectors.  The resulting vector is
/// perpendicular to the plane determined by `x` and `y`, with length equal to
/// the oriented area of the parallelogram they determine.
@_transparent
public func cross(_ x: double3, _ y: double3)
  -> double3 {
  return simd_cross(x,y)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of two `Int32`.  This corresponds to the C and
/// Obj-C type `vector_int2` and the C++ type `simd::int2`.
@_fixed_layout
@_alignment(8)
public struct int2 {

  public var _value: Builtin.Vec2xInt32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : Int32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec2xInt32_Int32(_value,
        (0 as Int32)._value)

      return Int32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec2xInt32_Int32_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : Int32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec2xInt32_Int32(_value,
        (1 as Int32)._value)

      return Int32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec2xInt32_Int32_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec2xInt32) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: Int32, _ y: Int32) {
    var v: Builtin.Vec2xInt32 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec2xInt32_Int32_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec2xInt32_Int32_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: Int32, y: Int32) {
    self.init(x, y)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: Int32) {
    self.init(scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly two elements.
  public init(_ array: [Int32]) {
  _precondition(array.count == 2,
                "int2 requires a two-element array")
    self.init(array[0], array[1])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> Int32 {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 2, "Vector index out of range")
      let elt = Builtin.extractelement_Vec2xInt32_Int32(_value,
        Int32(index)._value)
      return Int32(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 2, "Vector index out of range")
      _value = Builtin.insertelement_Vec2xInt32_Int32_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension int2 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: int2, _ rhs: int2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension int2 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "int2(\(self[0]), \(self[1]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension int2 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly two
  ///   elements.
  public init(arrayLiteral elements: Int32...) { self.init(elements) }
}

extension int2 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 2 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension int2 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func &+(lhs: int2, rhs: int2) -> int2 {
    return int2(Builtin.add_Vec2xInt32(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func &-(lhs: int2, rhs: int2) -> int2 {
    return int2(Builtin.sub_Vec2xInt32(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: int2) -> int2 {
    return int2() &- rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func &*(lhs: int2, rhs: int2) -> int2 {
    return int2(Builtin.mul_Vec2xInt32(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: Int32, rhs: int2) -> int2 {
    return int2(lhs) &* rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: int2, rhs: Int32) -> int2 {
    return lhs &* int2(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: int2, rhs: int2) -> int2 {
    return int2(Builtin.sdiv_Vec2xInt32(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: int2, rhs: Int32) -> int2 {
    return lhs / int2(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout int2, rhs: int2) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 271)
  // Integer vector types only support wrapping arithmetic. Make the non-
  // wrapping operators unavailable so that fixits guide users to the
  // unchecked operations.

  @available(*, unavailable, renamed: "&+",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func +(x: int2, y: int2) -> int2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&-",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func -(x: int2, y: int2) -> int2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: int2, y: int2) -> int2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: int2, y: Int32) -> int2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: Int32, y: int2) -> int2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &+ y' instead")
  public static func +=(x: inout int2, y: int2) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &- y' instead")
  public static func -=(x: inout int2, y: int2) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout int2, y: int2) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout int2, y: Int32) {
    fatalError("Unavailable function cannot be called")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 332)
/// Elementwise absolute value of a vector.  The result is a vector of the same
/// length with all elements positive.
@_transparent
public func abs(_ x: int2) -> int2 {
  return simd_abs(x)
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: int2, _ y: int2) -> int2 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: int2, _ y: int2) -> int2 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: int2, _ scalar: Int32) -> int2 {
  return min(vector, int2(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: int2, _ scalar: Int32) -> int2 {
  return max(vector, int2(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: int2, min: int2, max: int2)
  -> int2 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: int2, min: Int32, max: Int32)
  -> int2 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: int2) -> Int32 {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: int2) -> Int32 {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: int2) -> Int32 {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of three `Int32`.  This corresponds to the C and
/// Obj-C type `vector_int3` and the C++ type `simd::int3`.
@_fixed_layout
@_alignment(16)
public struct int3 {

  public var _value: Builtin.Vec3xInt32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : Int32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xInt32_Int32(_value,
        (0 as Int32)._value)

      return Int32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xInt32_Int32_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : Int32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xInt32_Int32(_value,
        (1 as Int32)._value)

      return Int32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xInt32_Int32_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var z : Int32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xInt32_Int32(_value,
        (2 as Int32)._value)

      return Int32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xInt32_Int32_Int32(_value,
        newValue._value,
        (2 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec3xInt32) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: Int32, _ y: Int32, _ z: Int32) {
    var v: Builtin.Vec3xInt32 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xInt32_Int32_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xInt32_Int32_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xInt32_Int32_Int32(v,
      z._value,
      (2 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: Int32, y: Int32, z: Int32) {
    self.init(x, y, z)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: Int32) {
    self.init(scalar, scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly three elements.
  public init(_ array: [Int32]) {
  _precondition(array.count == 3,
                "int3 requires a three-element array")
    self.init(array[0], array[1], array[2])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> Int32 {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 3, "Vector index out of range")
      let elt = Builtin.extractelement_Vec3xInt32_Int32(_value,
        Int32(index)._value)
      return Int32(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 3, "Vector index out of range")
      _value = Builtin.insertelement_Vec3xInt32_Int32_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension int3 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: int3, _ rhs: int3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension int3 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "int3(\(self[0]), \(self[1]), \(self[2]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]), \(self[2]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension int3 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly three
  ///   elements.
  public init(arrayLiteral elements: Int32...) { self.init(elements) }
}

extension int3 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 3 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension int3 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func &+(lhs: int3, rhs: int3) -> int3 {
    return int3(Builtin.add_Vec3xInt32(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func &-(lhs: int3, rhs: int3) -> int3 {
    return int3(Builtin.sub_Vec3xInt32(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: int3) -> int3 {
    return int3() &- rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func &*(lhs: int3, rhs: int3) -> int3 {
    return int3(Builtin.mul_Vec3xInt32(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: Int32, rhs: int3) -> int3 {
    return int3(lhs) &* rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: int3, rhs: Int32) -> int3 {
    return lhs &* int3(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: int3, rhs: int3) -> int3 {
    return int3(Builtin.sdiv_Vec3xInt32(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: int3, rhs: Int32) -> int3 {
    return lhs / int3(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout int3, rhs: int3) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 271)
  // Integer vector types only support wrapping arithmetic. Make the non-
  // wrapping operators unavailable so that fixits guide users to the
  // unchecked operations.

  @available(*, unavailable, renamed: "&+",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func +(x: int3, y: int3) -> int3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&-",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func -(x: int3, y: int3) -> int3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: int3, y: int3) -> int3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: int3, y: Int32) -> int3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: Int32, y: int3) -> int3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &+ y' instead")
  public static func +=(x: inout int3, y: int3) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &- y' instead")
  public static func -=(x: inout int3, y: int3) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout int3, y: int3) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout int3, y: Int32) {
    fatalError("Unavailable function cannot be called")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 332)
/// Elementwise absolute value of a vector.  The result is a vector of the same
/// length with all elements positive.
@_transparent
public func abs(_ x: int3) -> int3 {
  return simd_abs(x)
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: int3, _ y: int3) -> int3 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: int3, _ y: int3) -> int3 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: int3, _ scalar: Int32) -> int3 {
  return min(vector, int3(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: int3, _ scalar: Int32) -> int3 {
  return max(vector, int3(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: int3, min: int3, max: int3)
  -> int3 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: int3, min: Int32, max: Int32)
  -> int3 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: int3) -> Int32 {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: int3) -> Int32 {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: int3) -> Int32 {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of four `Int32`.  This corresponds to the C and
/// Obj-C type `vector_int4` and the C++ type `simd::int4`.
@_fixed_layout
@_alignment(16)
public struct int4 {

  public var _value: Builtin.Vec4xInt32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : Int32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        (0 as Int32)._value)

      return Int32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : Int32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        (1 as Int32)._value)

      return Int32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var z : Int32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        (2 as Int32)._value)

      return Int32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        newValue._value,
        (2 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var w : Int32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        (3 as Int32)._value)

      return Int32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        newValue._value,
        (3 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec4xInt32) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: Int32, _ y: Int32, _ z: Int32, _ w: Int32) {
    var v: Builtin.Vec4xInt32 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xInt32_Int32_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xInt32_Int32_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xInt32_Int32_Int32(v,
      z._value,
      (2 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xInt32_Int32_Int32(v,
      w._value,
      (3 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: Int32, y: Int32, z: Int32, w: Int32) {
    self.init(x, y, z, w)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: Int32) {
    self.init(scalar, scalar, scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly four elements.
  public init(_ array: [Int32]) {
  _precondition(array.count == 4,
                "int4 requires a four-element array")
    self.init(array[0], array[1], array[2], array[3])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> Int32 {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 4, "Vector index out of range")
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        Int32(index)._value)
      return Int32(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 4, "Vector index out of range")
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension int4 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: int4, _ rhs: int4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension int4 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "int4(\(self[0]), \(self[1]), \(self[2]), \(self[3]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]), \(self[2]), \(self[3]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension int4 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly four
  ///   elements.
  public init(arrayLiteral elements: Int32...) { self.init(elements) }
}

extension int4 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 4 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension int4 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func &+(lhs: int4, rhs: int4) -> int4 {
    return int4(Builtin.add_Vec4xInt32(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func &-(lhs: int4, rhs: int4) -> int4 {
    return int4(Builtin.sub_Vec4xInt32(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: int4) -> int4 {
    return int4() &- rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func &*(lhs: int4, rhs: int4) -> int4 {
    return int4(Builtin.mul_Vec4xInt32(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: Int32, rhs: int4) -> int4 {
    return int4(lhs) &* rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: int4, rhs: Int32) -> int4 {
    return lhs &* int4(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: int4, rhs: int4) -> int4 {
    return int4(Builtin.sdiv_Vec4xInt32(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: int4, rhs: Int32) -> int4 {
    return lhs / int4(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout int4, rhs: int4) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 271)
  // Integer vector types only support wrapping arithmetic. Make the non-
  // wrapping operators unavailable so that fixits guide users to the
  // unchecked operations.

  @available(*, unavailable, renamed: "&+",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func +(x: int4, y: int4) -> int4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&-",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func -(x: int4, y: int4) -> int4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: int4, y: int4) -> int4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: int4, y: Int32) -> int4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: Int32, y: int4) -> int4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &+ y' instead")
  public static func +=(x: inout int4, y: int4) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &- y' instead")
  public static func -=(x: inout int4, y: int4) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout int4, y: int4) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout int4, y: Int32) {
    fatalError("Unavailable function cannot be called")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 332)
/// Elementwise absolute value of a vector.  The result is a vector of the same
/// length with all elements positive.
@_transparent
public func abs(_ x: int4) -> int4 {
  return simd_abs(x)
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: int4, _ y: int4) -> int4 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: int4, _ y: int4) -> int4 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: int4, _ scalar: Int32) -> int4 {
  return min(vector, int4(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: int4, _ scalar: Int32) -> int4 {
  return max(vector, int4(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: int4, min: int4, max: int4)
  -> int4 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: int4, min: Int32, max: Int32)
  -> int4 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: int4) -> Int32 {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: int4) -> Int32 {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: int4) -> Int32 {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of two `UInt32`.  This corresponds to the C and
/// Obj-C type `vector_uint2` and the C++ type `simd::uint2`.
@_fixed_layout
@_alignment(8)
public struct uint2 {

  public var _value: Builtin.Vec2xInt32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : UInt32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec2xInt32_Int32(_value,
        (0 as Int32)._value)

      return UInt32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec2xInt32_Int32_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : UInt32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec2xInt32_Int32(_value,
        (1 as Int32)._value)

      return UInt32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec2xInt32_Int32_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec2xInt32) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: UInt32, _ y: UInt32) {
    var v: Builtin.Vec2xInt32 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec2xInt32_Int32_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec2xInt32_Int32_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: UInt32, y: UInt32) {
    self.init(x, y)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: UInt32) {
    self.init(scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly two elements.
  public init(_ array: [UInt32]) {
  _precondition(array.count == 2,
                "uint2 requires a two-element array")
    self.init(array[0], array[1])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> UInt32 {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 2, "Vector index out of range")
      let elt = Builtin.extractelement_Vec2xInt32_Int32(_value,
        Int32(index)._value)
      return UInt32(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 2, "Vector index out of range")
      _value = Builtin.insertelement_Vec2xInt32_Int32_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension uint2 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: uint2, _ rhs: uint2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension uint2 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "uint2(\(self[0]), \(self[1]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension uint2 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly two
  ///   elements.
  public init(arrayLiteral elements: UInt32...) { self.init(elements) }
}

extension uint2 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 2 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension uint2 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func &+(lhs: uint2, rhs: uint2) -> uint2 {
    return uint2(Builtin.add_Vec2xInt32(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func &-(lhs: uint2, rhs: uint2) -> uint2 {
    return uint2(Builtin.sub_Vec2xInt32(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: uint2) -> uint2 {
    return uint2() &- rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func &*(lhs: uint2, rhs: uint2) -> uint2 {
    return uint2(Builtin.mul_Vec2xInt32(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: UInt32, rhs: uint2) -> uint2 {
    return uint2(lhs) &* rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: uint2, rhs: UInt32) -> uint2 {
    return lhs &* uint2(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: uint2, rhs: uint2) -> uint2 {
    return uint2(Builtin.udiv_Vec2xInt32(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: uint2, rhs: UInt32) -> uint2 {
    return lhs / uint2(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout uint2, rhs: uint2) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 271)
  // Integer vector types only support wrapping arithmetic. Make the non-
  // wrapping operators unavailable so that fixits guide users to the
  // unchecked operations.

  @available(*, unavailable, renamed: "&+",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func +(x: uint2, y: uint2) -> uint2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&-",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func -(x: uint2, y: uint2) -> uint2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: uint2, y: uint2) -> uint2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: uint2, y: UInt32) -> uint2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: UInt32, y: uint2) -> uint2 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &+ y' instead")
  public static func +=(x: inout uint2, y: uint2) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &- y' instead")
  public static func -=(x: inout uint2, y: uint2) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout uint2, y: uint2) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout uint2, y: UInt32) {
    fatalError("Unavailable function cannot be called")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: uint2, _ y: uint2) -> uint2 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: uint2, _ y: uint2) -> uint2 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: uint2, _ scalar: UInt32) -> uint2 {
  return min(vector, uint2(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: uint2, _ scalar: UInt32) -> uint2 {
  return max(vector, uint2(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: uint2, min: uint2, max: uint2)
  -> uint2 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: uint2, min: UInt32, max: UInt32)
  -> uint2 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: uint2) -> UInt32 {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: uint2) -> UInt32 {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: uint2) -> UInt32 {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of three `UInt32`.  This corresponds to the C and
/// Obj-C type `vector_uint3` and the C++ type `simd::uint3`.
@_fixed_layout
@_alignment(16)
public struct uint3 {

  public var _value: Builtin.Vec3xInt32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : UInt32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xInt32_Int32(_value,
        (0 as Int32)._value)

      return UInt32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xInt32_Int32_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : UInt32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xInt32_Int32(_value,
        (1 as Int32)._value)

      return UInt32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xInt32_Int32_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var z : UInt32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec3xInt32_Int32(_value,
        (2 as Int32)._value)

      return UInt32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec3xInt32_Int32_Int32(_value,
        newValue._value,
        (2 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec3xInt32) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: UInt32, _ y: UInt32, _ z: UInt32) {
    var v: Builtin.Vec3xInt32 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xInt32_Int32_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xInt32_Int32_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec3xInt32_Int32_Int32(v,
      z._value,
      (2 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: UInt32, y: UInt32, z: UInt32) {
    self.init(x, y, z)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: UInt32) {
    self.init(scalar, scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly three elements.
  public init(_ array: [UInt32]) {
  _precondition(array.count == 3,
                "uint3 requires a three-element array")
    self.init(array[0], array[1], array[2])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> UInt32 {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 3, "Vector index out of range")
      let elt = Builtin.extractelement_Vec3xInt32_Int32(_value,
        Int32(index)._value)
      return UInt32(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 3, "Vector index out of range")
      _value = Builtin.insertelement_Vec3xInt32_Int32_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension uint3 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: uint3, _ rhs: uint3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension uint3 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "uint3(\(self[0]), \(self[1]), \(self[2]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]), \(self[2]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension uint3 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly three
  ///   elements.
  public init(arrayLiteral elements: UInt32...) { self.init(elements) }
}

extension uint3 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 3 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension uint3 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func &+(lhs: uint3, rhs: uint3) -> uint3 {
    return uint3(Builtin.add_Vec3xInt32(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func &-(lhs: uint3, rhs: uint3) -> uint3 {
    return uint3(Builtin.sub_Vec3xInt32(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: uint3) -> uint3 {
    return uint3() &- rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func &*(lhs: uint3, rhs: uint3) -> uint3 {
    return uint3(Builtin.mul_Vec3xInt32(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: UInt32, rhs: uint3) -> uint3 {
    return uint3(lhs) &* rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: uint3, rhs: UInt32) -> uint3 {
    return lhs &* uint3(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: uint3, rhs: uint3) -> uint3 {
    return uint3(Builtin.udiv_Vec3xInt32(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: uint3, rhs: UInt32) -> uint3 {
    return lhs / uint3(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout uint3, rhs: uint3) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 271)
  // Integer vector types only support wrapping arithmetic. Make the non-
  // wrapping operators unavailable so that fixits guide users to the
  // unchecked operations.

  @available(*, unavailable, renamed: "&+",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func +(x: uint3, y: uint3) -> uint3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&-",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func -(x: uint3, y: uint3) -> uint3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: uint3, y: uint3) -> uint3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: uint3, y: UInt32) -> uint3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: UInt32, y: uint3) -> uint3 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &+ y' instead")
  public static func +=(x: inout uint3, y: uint3) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &- y' instead")
  public static func -=(x: inout uint3, y: uint3) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout uint3, y: uint3) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout uint3, y: UInt32) {
    fatalError("Unavailable function cannot be called")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: uint3, _ y: uint3) -> uint3 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: uint3, _ y: uint3) -> uint3 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: uint3, _ scalar: UInt32) -> uint3 {
  return min(vector, uint3(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: uint3, _ scalar: UInt32) -> uint3 {
  return max(vector, uint3(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: uint3, min: uint3, max: uint3)
  -> uint3 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: uint3, min: UInt32, max: UInt32)
  -> uint3 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: uint3) -> UInt32 {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: uint3) -> UInt32 {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: uint3) -> UInt32 {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 38)


/// A vector of four `UInt32`.  This corresponds to the C and
/// Obj-C type `vector_uint4` and the C++ type `simd::uint4`.
@_fixed_layout
@_alignment(16)
public struct uint4 {

  public var _value: Builtin.Vec4xInt32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var x : UInt32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        (0 as Int32)._value)

      return UInt32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        newValue._value,
        (0 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var y : UInt32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        (1 as Int32)._value)

      return UInt32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        newValue._value,
        (1 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var z : UInt32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        (2 as Int32)._value)

      return UInt32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        newValue._value,
        (2 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 49)
  public var w : UInt32 {
    @_transparent
    get {
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        (3 as Int32)._value)

      return UInt32(elt)
    }
    @_transparent
    set {
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        newValue._value,
        (3 as Int32)._value)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 65)

  /// Initialize to the zero vector.
  @_transparent
  public init() { self.init(0) }

  @_transparent
  public init(_ _value: Builtin.Vec4xInt32) {
    self._value = _value
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(_ x: UInt32, _ y: UInt32, _ z: UInt32, _ w: UInt32) {
    var v: Builtin.Vec4xInt32 = Builtin.zeroInitializer()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xInt32_Int32_Int32(v,
      x._value,
      (0 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xInt32_Int32_Int32(v,
      y._value,
      (1 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xInt32_Int32_Int32(v,
      z._value,
      (2 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 80)
    v = Builtin.insertelement_Vec4xInt32_Int32_Int32(v,
      w._value,
      (3 as Int32)._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 84)
    _value = v
  }

  /// Initialize a vector with the specified elements.
  @_transparent
  public init(x: UInt32, y: UInt32, z: UInt32, w: UInt32) {
    self.init(x, y, z, w)
  }

  /// Initialize to a vector with all elements equal to `scalar`.
  @_transparent
  public init(_ scalar: UInt32) {
    self.init(scalar, scalar, scalar, scalar)
  }

  /// Initialize to a vector with elements taken from `array`.
  ///
  /// - Precondition: `array` must have exactly four elements.
  public init(_ array: [UInt32]) {
  _precondition(array.count == 4,
                "uint4 requires a four-element array")
    self.init(array[0], array[1], array[2], array[3])
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 108)
  }

  /// Access individual elements of the vector via subscript.
  public subscript(index: Int) -> UInt32 {
    @_transparent
    get {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 4, "Vector index out of range")
      let elt = Builtin.extractelement_Vec4xInt32_Int32(_value,
        Int32(index)._value)
      return UInt32(elt)
    }
    @_transparent
    set(value) {
      _precondition(index >= 0, "Vector index out of range")
      _precondition(index < 4, "Vector index out of range")
      _value = Builtin.insertelement_Vec4xInt32_Int32_Int32(_value,
        value._value,
        Int32(index)._value)
    }
  }
}

extension uint4 : Equatable {
  /// True iff every element of lhs is equal to the corresponding element of
  /// rhs.
  @_transparent
  public static func ==(_ lhs: uint4, _ rhs: uint4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension uint4 : CustomDebugStringConvertible {
  /// Debug string representation
  public var debugDescription: String {
    return "uint4(\(self[0]), \(self[1]), \(self[2]), \(self[3]))"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 146)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 149)
  /// Helper for matrix debug representations
  internal var _descriptionAsArray: String {
    get {
      return "[\(self[0]), \(self[1]), \(self[2]), \(self[3]))]"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 155)
    }
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 158)
}

extension uint4 : ExpressibleByArrayLiteral {
  /// Initialize using `arrayLiteral`.
  ///
  /// - Precondition: the array literal must exactly four
  ///   elements.
  public init(arrayLiteral elements: UInt32...) { self.init(elements) }
}

extension uint4 : Collection {
  @_transparent
  public var startIndex: Int { return 0 }

  @_transparent
  public var endIndex: Int { return 4 }

  @_transparent
  public func index(after i: Int) -> Int { return i + 1 }
}

extension uint4 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 183)
  /// Vector (elementwise) sum of `lhs` and `rhs`.
  @_transparent
  public static func &+(lhs: uint4, rhs: uint4) -> uint4 {
    return uint4(Builtin.add_Vec4xInt32(lhs._value, rhs._value))
  }

  /// Vector (elementwise) difference of `lhs` and `rhs`.
  @_transparent
  public static func &-(lhs: uint4, rhs: uint4) -> uint4 {
    return uint4(Builtin.sub_Vec4xInt32(lhs._value, rhs._value))
  }

  /// Negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: uint4) -> uint4 {
    return uint4() &- rhs
  }

  /// Elementwise product of `lhs` and `rhs` (A.k.a. the Hadamard or Schur
  /// vector product).
  @_transparent
  public static func &*(lhs: uint4, rhs: uint4) -> uint4 {
    return uint4(Builtin.mul_Vec4xInt32(lhs._value, rhs._value))
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: UInt32, rhs: uint4) -> uint4 {
    return uint4(lhs) &* rhs
  }

  /// Scalar-Vector product.
  @_transparent
  public static func &*(lhs: uint4, rhs: UInt32) -> uint4 {
    return lhs &* uint4(rhs)
  }

  /// Elementwise quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: uint4, rhs: uint4) -> uint4 {
    return uint4(Builtin.udiv_Vec4xInt32(lhs._value, rhs._value))
  }

  /// Divide vector by scalar.
  @_transparent
  public static func /(lhs: uint4, rhs: UInt32) -> uint4 {
    return lhs / uint4(rhs)
  }

  /// Add `rhs` to `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 251)

  /// Divide `lhs` by `rhs` (elementwise).
  @_transparent
  public static func /=(lhs: inout uint4, rhs: uint4) -> Void {
    lhs = lhs / rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 271)
  // Integer vector types only support wrapping arithmetic. Make the non-
  // wrapping operators unavailable so that fixits guide users to the
  // unchecked operations.

  @available(*, unavailable, renamed: "&+",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func +(x: uint4, y: uint4) -> uint4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&-",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func -(x: uint4, y: uint4) -> uint4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: uint4, y: uint4) -> uint4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: uint4, y: UInt32) -> uint4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable, renamed: "&*",
             message: "integer vector types do not support checked arithmetic; use the wrapping operations instead")
  public static func *(x: UInt32, y: uint4) -> uint4 {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &+ y' instead")
  public static func +=(x: inout uint4, y: uint4) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &- y' instead")
  public static func -=(x: inout uint4, y: uint4) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout uint4, y: uint4) {
    fatalError("Unavailable function cannot be called")
  }

  @available(*, unavailable,
             message: "integer vector types do not support checked arithmetic; use the wrapping operation 'x = x &* y' instead")
  public static func *=(x: inout uint4, y: UInt32) {
    fatalError("Unavailable function cannot be called")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 329)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 339)

/// Elementwise minimum of two vectors.  Each component of the result is the
/// smaller of the corresponding component of the inputs.
@_transparent
public func min(_ x: uint4, _ y: uint4) -> uint4 {
  return simd_min(x, y)
}

/// Elementwise maximum of two vectors.  Each component of the result is the
/// larger of the corresponding component of the inputs.
@_transparent
public func max(_ x: uint4, _ y: uint4) -> uint4 {
  return simd_max(x, y)
}

/// Vector-scalar minimum.  Each component of the result is the minimum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func min(_ vector: uint4, _ scalar: UInt32) -> uint4 {
  return min(vector, uint4(scalar))
}

/// Vector-scalar maximum.  Each component of the result is the maximum of the
/// corresponding element of the input vector and the scalar.
@_transparent
public func max(_ vector: uint4, _ scalar: UInt32) -> uint4 {
  return max(vector, uint4(scalar))
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.
@_transparent
public func clamp(_ x: uint4, min: uint4, max: uint4)
  -> uint4 {
  return simd.min(simd.max(x, min), max)
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.
@_transparent
public func clamp(_ x: uint4, min: UInt32, max: UInt32)
  -> uint4 {
  return simd.min(simd.max(x, min), max)
}

/// Sum of the elements of the vector.
@_transparent
public func reduce_add(_ x: uint4) -> UInt32 {
  return simd_reduce_add(x)
}

/// Minimum element of the vector.
@_transparent
public func reduce_min(_ x: uint4) -> UInt32 {
  return simd_reduce_min(x)
}

/// Maximum element of the vector.
@_transparent
public func reduce_max(_ x: uint4) -> UInt32 {
  return simd_reduce_max(x)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 625)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias float2x2 = simd_float2x2

extension simd_float2x2 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Float) {
    self.init(diagonal: float2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: float2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [float2]) {
    _precondition(columns.count == 2, "Requires array of 2 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [float2]) {
    _precondition(rows.count == 2, "Requires array of 2 vectors")
    self = float2x2(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: float2, _ col1: float2) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_float2x2) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_float2x2 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> float2 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Float {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_float2x2 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_float2x2([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_float2x2 : Equatable {
  @_transparent
  public static func ==(lhs: simd_float2x2, rhs: simd_float2x2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_float2x2 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: float2x2 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 742)
  /// Inverse of the matrix if it exists, otherwise the contents of the
  /// resulting matrix are undefined.
  @available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
  @_transparent
  public var inverse: simd_float2x2 {
    return simd_inverse(self)
  }

  /// Determinant of the matrix.
  @_transparent
  public var determinant: Float {
    return simd_determinant(self)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_float2x2, rhs: simd_float2x2) -> simd_float2x2 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_float2x2) -> simd_float2x2 {
    return simd_float2x2() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_float2x2, rhs: simd_float2x2) -> simd_float2x2 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_float2x2, rhs: simd_float2x2) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_float2x2, rhs: simd_float2x2) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Float, rhs: simd_float2x2) -> simd_float2x2 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_float2x2, rhs: Float) -> simd_float2x2 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_float2x2, rhs: Float) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `FloatNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Float3x2 * Float3` to get a `Float2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_float2x2, rhs: float2) -> float2 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: float2, rhs: simd_float2x2) -> float2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float2x2, rhs: float2x2) -> float2x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float2x2, rhs: float3x2) -> float3x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float2x2, rhs: float4x2) -> float4x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_float2x2, rhs: float2x2) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 842)
@available(swift, deprecated: 4, renamed: "simd_float2x2(diagonal:)")
public func matrix_from_diagonal(_ d: float2) -> simd_float2x2 {
  return simd_float2x2(diagonal: d)
}

@available(swift, deprecated: 4, message: "Use the .inverse property instead.")
@available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
public func matrix_invert(_ x: simd_float2x2) -> simd_float2x2 {
  return x.inverse
}

@available(swift, deprecated: 4, message: "Use the .determinant property instead.")
public func matrix_determinant(_ x: simd_float2x2) -> Float {
  return x.determinant
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_float2x2")
public func matrix_from_columns(_ col0: float2, _ col1: float2) -> simd_float2x2 {
  return simd_float2x2(col0, col1)
}

public func matrix_from_rows(_ row0: float2, _ row1: float2) -> simd_float2x2 {
  return float2x2(row0, row1).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_float2x2) -> float2x2 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_float2x2, _ rhs: simd_float2x2) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias float3x2 = simd_float3x2

extension simd_float3x2 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Float) {
    self.init(diagonal: float2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: float2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [float2]) {
    _precondition(columns.count == 3, "Requires array of 3 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [float3]) {
    _precondition(rows.count == 2, "Requires array of 2 vectors")
    self = float2x3(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: float2, _ col1: float2, _ col2: float2) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_float3x2) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_float3x2 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> float2 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Float {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_float3x2 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_float3x2([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_float3x2 : Equatable {
  @_transparent
  public static func ==(lhs: simd_float3x2, rhs: simd_float3x2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_float3x2 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: float2x3 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_float3x2, rhs: simd_float3x2) -> simd_float3x2 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_float3x2) -> simd_float3x2 {
    return simd_float3x2() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_float3x2, rhs: simd_float3x2) -> simd_float3x2 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_float3x2, rhs: simd_float3x2) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_float3x2, rhs: simd_float3x2) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Float, rhs: simd_float3x2) -> simd_float3x2 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_float3x2, rhs: Float) -> simd_float3x2 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_float3x2, rhs: Float) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `FloatNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Float3x2 * Float3` to get a `Float2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_float3x2, rhs: float3) -> float2 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: float2, rhs: simd_float3x2) -> float3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float3x2, rhs: float2x3) -> float2x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float3x2, rhs: float3x3) -> float3x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float3x2, rhs: float4x3) -> float4x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_float3x2, rhs: float3x3) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_float3x2")
public func matrix_from_columns(_ col0: float2, _ col1: float2, _ col2: float2) -> simd_float3x2 {
  return simd_float3x2(col0, col1, col2)
}

public func matrix_from_rows(_ row0: float3, _ row1: float3) -> simd_float3x2 {
  return float2x3(row0, row1).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_float3x2) -> float2x3 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_float3x2, _ rhs: simd_float3x2) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias float4x2 = simd_float4x2

extension simd_float4x2 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Float) {
    self.init(diagonal: float2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: float2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [float2]) {
    _precondition(columns.count == 4, "Requires array of 4 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.3 = columns[3]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [float4]) {
    _precondition(rows.count == 2, "Requires array of 2 vectors")
    self = float2x4(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: float2, _ col1: float2, _ col2: float2, _ col3: float2) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.3 = col3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_float4x2) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_float4x2 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> float2 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 3: return columns.3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 3: columns.3 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Float {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_float4x2 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_float4x2([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray), \(columns.3._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_float4x2 : Equatable {
  @_transparent
  public static func ==(lhs: simd_float4x2, rhs: simd_float4x2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_float4x2 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: float2x4 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_float4x2, rhs: simd_float4x2) -> simd_float4x2 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_float4x2) -> simd_float4x2 {
    return simd_float4x2() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_float4x2, rhs: simd_float4x2) -> simd_float4x2 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_float4x2, rhs: simd_float4x2) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_float4x2, rhs: simd_float4x2) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Float, rhs: simd_float4x2) -> simd_float4x2 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_float4x2, rhs: Float) -> simd_float4x2 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_float4x2, rhs: Float) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `FloatNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Float3x2 * Float3` to get a `Float2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_float4x2, rhs: float4) -> float2 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: float2, rhs: simd_float4x2) -> float4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float4x2, rhs: float2x4) -> float2x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float4x2, rhs: float3x4) -> float3x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float4x2, rhs: float4x4) -> float4x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_float4x2, rhs: float4x4) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_float4x2")
public func matrix_from_columns(_ col0: float2, _ col1: float2, _ col2: float2, _ col3: float2) -> simd_float4x2 {
  return simd_float4x2(col0, col1, col2, col3)
}

public func matrix_from_rows(_ row0: float4, _ row1: float4) -> simd_float4x2 {
  return float2x4(row0, row1).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_float4x2) -> float2x4 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_float4x2, _ rhs: simd_float4x2) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias float2x3 = simd_float2x3

extension simd_float2x3 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Float) {
    self.init(diagonal: float2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: float2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [float3]) {
    _precondition(columns.count == 2, "Requires array of 2 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [float2]) {
    _precondition(rows.count == 3, "Requires array of 3 vectors")
    self = float3x2(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: float3, _ col1: float3) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_float2x3) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_float2x3 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> float3 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Float {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_float2x3 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_float2x3([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_float2x3 : Equatable {
  @_transparent
  public static func ==(lhs: simd_float2x3, rhs: simd_float2x3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_float2x3 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: float3x2 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_float2x3, rhs: simd_float2x3) -> simd_float2x3 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_float2x3) -> simd_float2x3 {
    return simd_float2x3() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_float2x3, rhs: simd_float2x3) -> simd_float2x3 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_float2x3, rhs: simd_float2x3) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_float2x3, rhs: simd_float2x3) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Float, rhs: simd_float2x3) -> simd_float2x3 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_float2x3, rhs: Float) -> simd_float2x3 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_float2x3, rhs: Float) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `FloatNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Float3x2 * Float3` to get a `Float2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_float2x3, rhs: float2) -> float3 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: float3, rhs: simd_float2x3) -> float2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float2x3, rhs: float2x2) -> float2x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float2x3, rhs: float3x2) -> float3x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float2x3, rhs: float4x2) -> float4x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_float2x3, rhs: float2x2) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_float2x3")
public func matrix_from_columns(_ col0: float3, _ col1: float3) -> simd_float2x3 {
  return simd_float2x3(col0, col1)
}

public func matrix_from_rows(_ row0: float2, _ row1: float2, _ row2: float2) -> simd_float2x3 {
  return float3x2(row0, row1, row2).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_float2x3) -> float3x2 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_float2x3, _ rhs: simd_float2x3) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias float3x3 = simd_float3x3

extension simd_float3x3 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Float) {
    self.init(diagonal: float3(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: float3) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.2.z = diagonal.z
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [float3]) {
    _precondition(columns.count == 3, "Requires array of 3 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [float3]) {
    _precondition(rows.count == 3, "Requires array of 3 vectors")
    self = float3x3(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: float3, _ col1: float3, _ col2: float3) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_float3x3) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_float3x3 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> float3 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Float {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_float3x3 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_float3x3([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_float3x3 : Equatable {
  @_transparent
  public static func ==(lhs: simd_float3x3, rhs: simd_float3x3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_float3x3 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: float3x3 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 742)
  /// Inverse of the matrix if it exists, otherwise the contents of the
  /// resulting matrix are undefined.
  @available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
  @_transparent
  public var inverse: simd_float3x3 {
    return simd_inverse(self)
  }

  /// Determinant of the matrix.
  @_transparent
  public var determinant: Float {
    return simd_determinant(self)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_float3x3, rhs: simd_float3x3) -> simd_float3x3 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_float3x3) -> simd_float3x3 {
    return simd_float3x3() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_float3x3, rhs: simd_float3x3) -> simd_float3x3 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_float3x3, rhs: simd_float3x3) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_float3x3, rhs: simd_float3x3) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Float, rhs: simd_float3x3) -> simd_float3x3 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_float3x3, rhs: Float) -> simd_float3x3 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_float3x3, rhs: Float) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `FloatNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Float3x2 * Float3` to get a `Float2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_float3x3, rhs: float3) -> float3 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: float3, rhs: simd_float3x3) -> float3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float3x3, rhs: float2x3) -> float2x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float3x3, rhs: float3x3) -> float3x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float3x3, rhs: float4x3) -> float4x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_float3x3, rhs: float3x3) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 842)
@available(swift, deprecated: 4, renamed: "simd_float3x3(diagonal:)")
public func matrix_from_diagonal(_ d: float3) -> simd_float3x3 {
  return simd_float3x3(diagonal: d)
}

@available(swift, deprecated: 4, message: "Use the .inverse property instead.")
@available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
public func matrix_invert(_ x: simd_float3x3) -> simd_float3x3 {
  return x.inverse
}

@available(swift, deprecated: 4, message: "Use the .determinant property instead.")
public func matrix_determinant(_ x: simd_float3x3) -> Float {
  return x.determinant
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_float3x3")
public func matrix_from_columns(_ col0: float3, _ col1: float3, _ col2: float3) -> simd_float3x3 {
  return simd_float3x3(col0, col1, col2)
}

public func matrix_from_rows(_ row0: float3, _ row1: float3, _ row2: float3) -> simd_float3x3 {
  return float3x3(row0, row1, row2).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_float3x3) -> float3x3 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_float3x3, _ rhs: simd_float3x3) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias float4x3 = simd_float4x3

extension simd_float4x3 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Float) {
    self.init(diagonal: float3(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: float3) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.2.z = diagonal.z
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [float3]) {
    _precondition(columns.count == 4, "Requires array of 4 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.3 = columns[3]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [float4]) {
    _precondition(rows.count == 3, "Requires array of 3 vectors")
    self = float3x4(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: float3, _ col1: float3, _ col2: float3, _ col3: float3) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.3 = col3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_float4x3) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_float4x3 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> float3 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 3: return columns.3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 3: columns.3 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Float {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_float4x3 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_float4x3([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray), \(columns.3._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_float4x3 : Equatable {
  @_transparent
  public static func ==(lhs: simd_float4x3, rhs: simd_float4x3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_float4x3 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: float3x4 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_float4x3, rhs: simd_float4x3) -> simd_float4x3 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_float4x3) -> simd_float4x3 {
    return simd_float4x3() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_float4x3, rhs: simd_float4x3) -> simd_float4x3 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_float4x3, rhs: simd_float4x3) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_float4x3, rhs: simd_float4x3) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Float, rhs: simd_float4x3) -> simd_float4x3 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_float4x3, rhs: Float) -> simd_float4x3 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_float4x3, rhs: Float) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `FloatNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Float3x2 * Float3` to get a `Float2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_float4x3, rhs: float4) -> float3 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: float3, rhs: simd_float4x3) -> float4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float4x3, rhs: float2x4) -> float2x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float4x3, rhs: float3x4) -> float3x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float4x3, rhs: float4x4) -> float4x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_float4x3, rhs: float4x4) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_float4x3")
public func matrix_from_columns(_ col0: float3, _ col1: float3, _ col2: float3, _ col3: float3) -> simd_float4x3 {
  return simd_float4x3(col0, col1, col2, col3)
}

public func matrix_from_rows(_ row0: float4, _ row1: float4, _ row2: float4) -> simd_float4x3 {
  return float3x4(row0, row1, row2).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_float4x3) -> float3x4 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_float4x3, _ rhs: simd_float4x3) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias float2x4 = simd_float2x4

extension simd_float2x4 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Float) {
    self.init(diagonal: float2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: float2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [float4]) {
    _precondition(columns.count == 2, "Requires array of 2 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [float2]) {
    _precondition(rows.count == 4, "Requires array of 4 vectors")
    self = float4x2(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: float4, _ col1: float4) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_float2x4) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_float2x4 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> float4 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Float {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_float2x4 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_float2x4([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_float2x4 : Equatable {
  @_transparent
  public static func ==(lhs: simd_float2x4, rhs: simd_float2x4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_float2x4 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: float4x2 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_float2x4, rhs: simd_float2x4) -> simd_float2x4 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_float2x4) -> simd_float2x4 {
    return simd_float2x4() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_float2x4, rhs: simd_float2x4) -> simd_float2x4 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_float2x4, rhs: simd_float2x4) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_float2x4, rhs: simd_float2x4) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Float, rhs: simd_float2x4) -> simd_float2x4 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_float2x4, rhs: Float) -> simd_float2x4 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_float2x4, rhs: Float) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `FloatNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Float3x2 * Float3` to get a `Float2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_float2x4, rhs: float2) -> float4 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: float4, rhs: simd_float2x4) -> float2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float2x4, rhs: float2x2) -> float2x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float2x4, rhs: float3x2) -> float3x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float2x4, rhs: float4x2) -> float4x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_float2x4, rhs: float2x2) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_float2x4")
public func matrix_from_columns(_ col0: float4, _ col1: float4) -> simd_float2x4 {
  return simd_float2x4(col0, col1)
}

public func matrix_from_rows(_ row0: float2, _ row1: float2, _ row2: float2, _ row3: float2) -> simd_float2x4 {
  return float4x2(row0, row1, row2, row3).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_float2x4) -> float4x2 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_float2x4, _ rhs: simd_float2x4) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias float3x4 = simd_float3x4

extension simd_float3x4 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Float) {
    self.init(diagonal: float3(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: float3) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.2.z = diagonal.z
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [float4]) {
    _precondition(columns.count == 3, "Requires array of 3 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [float3]) {
    _precondition(rows.count == 4, "Requires array of 4 vectors")
    self = float4x3(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: float4, _ col1: float4, _ col2: float4) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_float3x4) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_float3x4 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> float4 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Float {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_float3x4 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_float3x4([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_float3x4 : Equatable {
  @_transparent
  public static func ==(lhs: simd_float3x4, rhs: simd_float3x4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_float3x4 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: float4x3 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_float3x4, rhs: simd_float3x4) -> simd_float3x4 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_float3x4) -> simd_float3x4 {
    return simd_float3x4() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_float3x4, rhs: simd_float3x4) -> simd_float3x4 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_float3x4, rhs: simd_float3x4) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_float3x4, rhs: simd_float3x4) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Float, rhs: simd_float3x4) -> simd_float3x4 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_float3x4, rhs: Float) -> simd_float3x4 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_float3x4, rhs: Float) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `FloatNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Float3x2 * Float3` to get a `Float2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_float3x4, rhs: float3) -> float4 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: float4, rhs: simd_float3x4) -> float3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float3x4, rhs: float2x3) -> float2x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float3x4, rhs: float3x3) -> float3x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float3x4, rhs: float4x3) -> float4x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_float3x4, rhs: float3x3) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_float3x4")
public func matrix_from_columns(_ col0: float4, _ col1: float4, _ col2: float4) -> simd_float3x4 {
  return simd_float3x4(col0, col1, col2)
}

public func matrix_from_rows(_ row0: float3, _ row1: float3, _ row2: float3, _ row3: float3) -> simd_float3x4 {
  return float4x3(row0, row1, row2, row3).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_float3x4) -> float4x3 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_float3x4, _ rhs: simd_float3x4) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias float4x4 = simd_float4x4

extension simd_float4x4 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Float) {
    self.init(diagonal: float4(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: float4) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.2.z = diagonal.z
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.3.w = diagonal.w
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [float4]) {
    _precondition(columns.count == 4, "Requires array of 4 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.3 = columns[3]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [float4]) {
    _precondition(rows.count == 4, "Requires array of 4 vectors")
    self = float4x4(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: float4, _ col1: float4, _ col2: float4, _ col3: float4) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.3 = col3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_float4x4) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_float4x4 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> float4 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 3: return columns.3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 3: columns.3 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Float {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_float4x4 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_float4x4([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray), \(columns.3._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_float4x4 : Equatable {
  @_transparent
  public static func ==(lhs: simd_float4x4, rhs: simd_float4x4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_float4x4 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: float4x4 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 742)
  /// Inverse of the matrix if it exists, otherwise the contents of the
  /// resulting matrix are undefined.
  @available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
  @_transparent
  public var inverse: simd_float4x4 {
    return simd_inverse(self)
  }

  /// Determinant of the matrix.
  @_transparent
  public var determinant: Float {
    return simd_determinant(self)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_float4x4, rhs: simd_float4x4) -> simd_float4x4 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_float4x4) -> simd_float4x4 {
    return simd_float4x4() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_float4x4, rhs: simd_float4x4) -> simd_float4x4 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_float4x4, rhs: simd_float4x4) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_float4x4, rhs: simd_float4x4) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Float, rhs: simd_float4x4) -> simd_float4x4 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_float4x4, rhs: Float) -> simd_float4x4 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_float4x4, rhs: Float) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `FloatNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Float3x2 * Float3` to get a `Float2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_float4x4, rhs: float4) -> float4 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: float4, rhs: simd_float4x4) -> float4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float4x4, rhs: float2x4) -> float2x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float4x4, rhs: float3x4) -> float3x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_float4x4, rhs: float4x4) -> float4x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_float4x4, rhs: float4x4) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 842)
@available(swift, deprecated: 4, renamed: "simd_float4x4(diagonal:)")
public func matrix_from_diagonal(_ d: float4) -> simd_float4x4 {
  return simd_float4x4(diagonal: d)
}

@available(swift, deprecated: 4, message: "Use the .inverse property instead.")
@available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
public func matrix_invert(_ x: simd_float4x4) -> simd_float4x4 {
  return x.inverse
}

@available(swift, deprecated: 4, message: "Use the .determinant property instead.")
public func matrix_determinant(_ x: simd_float4x4) -> Float {
  return x.determinant
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_float4x4")
public func matrix_from_columns(_ col0: float4, _ col1: float4, _ col2: float4, _ col3: float4) -> simd_float4x4 {
  return simd_float4x4(col0, col1, col2, col3)
}

public func matrix_from_rows(_ row0: float4, _ row1: float4, _ row2: float4, _ row3: float4) -> simd_float4x4 {
  return float4x4(row0, row1, row2, row3).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_float4x4) -> float4x4 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_float4x4, _ rhs: simd_float4x4) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias double2x2 = simd_double2x2

extension simd_double2x2 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Double) {
    self.init(diagonal: double2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: double2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [double2]) {
    _precondition(columns.count == 2, "Requires array of 2 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [double2]) {
    _precondition(rows.count == 2, "Requires array of 2 vectors")
    self = double2x2(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: double2, _ col1: double2) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_double2x2) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_double2x2 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> double2 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Double {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_double2x2 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_double2x2([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_double2x2 : Equatable {
  @_transparent
  public static func ==(lhs: simd_double2x2, rhs: simd_double2x2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_double2x2 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: double2x2 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 742)
  /// Inverse of the matrix if it exists, otherwise the contents of the
  /// resulting matrix are undefined.
  @available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
  @_transparent
  public var inverse: simd_double2x2 {
    return simd_inverse(self)
  }

  /// Determinant of the matrix.
  @_transparent
  public var determinant: Double {
    return simd_determinant(self)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_double2x2, rhs: simd_double2x2) -> simd_double2x2 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_double2x2) -> simd_double2x2 {
    return simd_double2x2() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_double2x2, rhs: simd_double2x2) -> simd_double2x2 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_double2x2, rhs: simd_double2x2) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_double2x2, rhs: simd_double2x2) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Double, rhs: simd_double2x2) -> simd_double2x2 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_double2x2, rhs: Double) -> simd_double2x2 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_double2x2, rhs: Double) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `DoubleNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Double3x2 * Double3` to get a `Double2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_double2x2, rhs: double2) -> double2 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: double2, rhs: simd_double2x2) -> double2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double2x2, rhs: double2x2) -> double2x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double2x2, rhs: double3x2) -> double3x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double2x2, rhs: double4x2) -> double4x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_double2x2, rhs: double2x2) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 842)
@available(swift, deprecated: 4, renamed: "simd_double2x2(diagonal:)")
public func matrix_from_diagonal(_ d: double2) -> simd_double2x2 {
  return simd_double2x2(diagonal: d)
}

@available(swift, deprecated: 4, message: "Use the .inverse property instead.")
@available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
public func matrix_invert(_ x: simd_double2x2) -> simd_double2x2 {
  return x.inverse
}

@available(swift, deprecated: 4, message: "Use the .determinant property instead.")
public func matrix_determinant(_ x: simd_double2x2) -> Double {
  return x.determinant
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_double2x2")
public func matrix_from_columns(_ col0: double2, _ col1: double2) -> simd_double2x2 {
  return simd_double2x2(col0, col1)
}

public func matrix_from_rows(_ row0: double2, _ row1: double2) -> simd_double2x2 {
  return double2x2(row0, row1).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_double2x2) -> double2x2 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_double2x2, _ rhs: simd_double2x2) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias double3x2 = simd_double3x2

extension simd_double3x2 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Double) {
    self.init(diagonal: double2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: double2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [double2]) {
    _precondition(columns.count == 3, "Requires array of 3 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [double3]) {
    _precondition(rows.count == 2, "Requires array of 2 vectors")
    self = double2x3(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: double2, _ col1: double2, _ col2: double2) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_double3x2) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_double3x2 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> double2 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Double {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_double3x2 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_double3x2([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_double3x2 : Equatable {
  @_transparent
  public static func ==(lhs: simd_double3x2, rhs: simd_double3x2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_double3x2 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: double2x3 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_double3x2, rhs: simd_double3x2) -> simd_double3x2 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_double3x2) -> simd_double3x2 {
    return simd_double3x2() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_double3x2, rhs: simd_double3x2) -> simd_double3x2 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_double3x2, rhs: simd_double3x2) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_double3x2, rhs: simd_double3x2) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Double, rhs: simd_double3x2) -> simd_double3x2 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_double3x2, rhs: Double) -> simd_double3x2 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_double3x2, rhs: Double) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `DoubleNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Double3x2 * Double3` to get a `Double2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_double3x2, rhs: double3) -> double2 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: double2, rhs: simd_double3x2) -> double3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double3x2, rhs: double2x3) -> double2x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double3x2, rhs: double3x3) -> double3x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double3x2, rhs: double4x3) -> double4x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_double3x2, rhs: double3x3) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_double3x2")
public func matrix_from_columns(_ col0: double2, _ col1: double2, _ col2: double2) -> simd_double3x2 {
  return simd_double3x2(col0, col1, col2)
}

public func matrix_from_rows(_ row0: double3, _ row1: double3) -> simd_double3x2 {
  return double2x3(row0, row1).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_double3x2) -> double2x3 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_double3x2, _ rhs: simd_double3x2) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias double4x2 = simd_double4x2

extension simd_double4x2 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Double) {
    self.init(diagonal: double2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: double2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [double2]) {
    _precondition(columns.count == 4, "Requires array of 4 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.3 = columns[3]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [double4]) {
    _precondition(rows.count == 2, "Requires array of 2 vectors")
    self = double2x4(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: double2, _ col1: double2, _ col2: double2, _ col3: double2) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.3 = col3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_double4x2) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_double4x2 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> double2 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 3: return columns.3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 3: columns.3 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Double {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_double4x2 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_double4x2([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray), \(columns.3._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_double4x2 : Equatable {
  @_transparent
  public static func ==(lhs: simd_double4x2, rhs: simd_double4x2) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_double4x2 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: double2x4 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_double4x2, rhs: simd_double4x2) -> simd_double4x2 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_double4x2) -> simd_double4x2 {
    return simd_double4x2() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_double4x2, rhs: simd_double4x2) -> simd_double4x2 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_double4x2, rhs: simd_double4x2) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_double4x2, rhs: simd_double4x2) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Double, rhs: simd_double4x2) -> simd_double4x2 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_double4x2, rhs: Double) -> simd_double4x2 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_double4x2, rhs: Double) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `DoubleNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Double3x2 * Double3` to get a `Double2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_double4x2, rhs: double4) -> double2 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: double2, rhs: simd_double4x2) -> double4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double4x2, rhs: double2x4) -> double2x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double4x2, rhs: double3x4) -> double3x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double4x2, rhs: double4x4) -> double4x2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_double4x2, rhs: double4x4) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_double4x2")
public func matrix_from_columns(_ col0: double2, _ col1: double2, _ col2: double2, _ col3: double2) -> simd_double4x2 {
  return simd_double4x2(col0, col1, col2, col3)
}

public func matrix_from_rows(_ row0: double4, _ row1: double4) -> simd_double4x2 {
  return double2x4(row0, row1).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_double4x2) -> double2x4 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_double4x2, _ rhs: simd_double4x2) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias double2x3 = simd_double2x3

extension simd_double2x3 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Double) {
    self.init(diagonal: double2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: double2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [double3]) {
    _precondition(columns.count == 2, "Requires array of 2 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [double2]) {
    _precondition(rows.count == 3, "Requires array of 3 vectors")
    self = double3x2(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: double3, _ col1: double3) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_double2x3) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_double2x3 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> double3 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Double {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_double2x3 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_double2x3([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_double2x3 : Equatable {
  @_transparent
  public static func ==(lhs: simd_double2x3, rhs: simd_double2x3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_double2x3 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: double3x2 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_double2x3, rhs: simd_double2x3) -> simd_double2x3 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_double2x3) -> simd_double2x3 {
    return simd_double2x3() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_double2x3, rhs: simd_double2x3) -> simd_double2x3 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_double2x3, rhs: simd_double2x3) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_double2x3, rhs: simd_double2x3) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Double, rhs: simd_double2x3) -> simd_double2x3 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_double2x3, rhs: Double) -> simd_double2x3 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_double2x3, rhs: Double) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `DoubleNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Double3x2 * Double3` to get a `Double2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_double2x3, rhs: double2) -> double3 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: double3, rhs: simd_double2x3) -> double2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double2x3, rhs: double2x2) -> double2x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double2x3, rhs: double3x2) -> double3x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double2x3, rhs: double4x2) -> double4x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_double2x3, rhs: double2x2) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_double2x3")
public func matrix_from_columns(_ col0: double3, _ col1: double3) -> simd_double2x3 {
  return simd_double2x3(col0, col1)
}

public func matrix_from_rows(_ row0: double2, _ row1: double2, _ row2: double2) -> simd_double2x3 {
  return double3x2(row0, row1, row2).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_double2x3) -> double3x2 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_double2x3, _ rhs: simd_double2x3) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias double3x3 = simd_double3x3

extension simd_double3x3 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Double) {
    self.init(diagonal: double3(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: double3) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.2.z = diagonal.z
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [double3]) {
    _precondition(columns.count == 3, "Requires array of 3 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [double3]) {
    _precondition(rows.count == 3, "Requires array of 3 vectors")
    self = double3x3(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: double3, _ col1: double3, _ col2: double3) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_double3x3) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_double3x3 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> double3 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Double {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_double3x3 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_double3x3([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_double3x3 : Equatable {
  @_transparent
  public static func ==(lhs: simd_double3x3, rhs: simd_double3x3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_double3x3 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: double3x3 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 742)
  /// Inverse of the matrix if it exists, otherwise the contents of the
  /// resulting matrix are undefined.
  @available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
  @_transparent
  public var inverse: simd_double3x3 {
    return simd_inverse(self)
  }

  /// Determinant of the matrix.
  @_transparent
  public var determinant: Double {
    return simd_determinant(self)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_double3x3, rhs: simd_double3x3) -> simd_double3x3 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_double3x3) -> simd_double3x3 {
    return simd_double3x3() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_double3x3, rhs: simd_double3x3) -> simd_double3x3 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_double3x3, rhs: simd_double3x3) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_double3x3, rhs: simd_double3x3) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Double, rhs: simd_double3x3) -> simd_double3x3 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_double3x3, rhs: Double) -> simd_double3x3 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_double3x3, rhs: Double) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `DoubleNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Double3x2 * Double3` to get a `Double2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_double3x3, rhs: double3) -> double3 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: double3, rhs: simd_double3x3) -> double3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double3x3, rhs: double2x3) -> double2x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double3x3, rhs: double3x3) -> double3x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double3x3, rhs: double4x3) -> double4x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_double3x3, rhs: double3x3) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 842)
@available(swift, deprecated: 4, renamed: "simd_double3x3(diagonal:)")
public func matrix_from_diagonal(_ d: double3) -> simd_double3x3 {
  return simd_double3x3(diagonal: d)
}

@available(swift, deprecated: 4, message: "Use the .inverse property instead.")
@available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
public func matrix_invert(_ x: simd_double3x3) -> simd_double3x3 {
  return x.inverse
}

@available(swift, deprecated: 4, message: "Use the .determinant property instead.")
public func matrix_determinant(_ x: simd_double3x3) -> Double {
  return x.determinant
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_double3x3")
public func matrix_from_columns(_ col0: double3, _ col1: double3, _ col2: double3) -> simd_double3x3 {
  return simd_double3x3(col0, col1, col2)
}

public func matrix_from_rows(_ row0: double3, _ row1: double3, _ row2: double3) -> simd_double3x3 {
  return double3x3(row0, row1, row2).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_double3x3) -> double3x3 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_double3x3, _ rhs: simd_double3x3) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias double4x3 = simd_double4x3

extension simd_double4x3 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Double) {
    self.init(diagonal: double3(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: double3) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.2.z = diagonal.z
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [double3]) {
    _precondition(columns.count == 4, "Requires array of 4 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.3 = columns[3]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [double4]) {
    _precondition(rows.count == 3, "Requires array of 3 vectors")
    self = double3x4(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: double3, _ col1: double3, _ col2: double3, _ col3: double3) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.3 = col3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_double4x3) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_double4x3 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> double3 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 3: return columns.3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 3: columns.3 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Double {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_double4x3 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_double4x3([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray), \(columns.3._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_double4x3 : Equatable {
  @_transparent
  public static func ==(lhs: simd_double4x3, rhs: simd_double4x3) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_double4x3 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: double3x4 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_double4x3, rhs: simd_double4x3) -> simd_double4x3 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_double4x3) -> simd_double4x3 {
    return simd_double4x3() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_double4x3, rhs: simd_double4x3) -> simd_double4x3 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_double4x3, rhs: simd_double4x3) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_double4x3, rhs: simd_double4x3) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Double, rhs: simd_double4x3) -> simd_double4x3 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_double4x3, rhs: Double) -> simd_double4x3 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_double4x3, rhs: Double) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `DoubleNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Double3x2 * Double3` to get a `Double2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_double4x3, rhs: double4) -> double3 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: double3, rhs: simd_double4x3) -> double4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double4x3, rhs: double2x4) -> double2x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double4x3, rhs: double3x4) -> double3x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double4x3, rhs: double4x4) -> double4x3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_double4x3, rhs: double4x4) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_double4x3")
public func matrix_from_columns(_ col0: double3, _ col1: double3, _ col2: double3, _ col3: double3) -> simd_double4x3 {
  return simd_double4x3(col0, col1, col2, col3)
}

public func matrix_from_rows(_ row0: double4, _ row1: double4, _ row2: double4) -> simd_double4x3 {
  return double3x4(row0, row1, row2).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_double4x3) -> double3x4 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_double4x3, _ rhs: simd_double4x3) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias double2x4 = simd_double2x4

extension simd_double2x4 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Double) {
    self.init(diagonal: double2(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: double2) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [double4]) {
    _precondition(columns.count == 2, "Requires array of 2 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [double2]) {
    _precondition(rows.count == 4, "Requires array of 4 vectors")
    self = double4x2(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: double4, _ col1: double4) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_double2x4) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_double2x4 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> double4 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Double {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_double2x4 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_double2x4([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_double2x4 : Equatable {
  @_transparent
  public static func ==(lhs: simd_double2x4, rhs: simd_double2x4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_double2x4 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: double4x2 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_double2x4, rhs: simd_double2x4) -> simd_double2x4 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_double2x4) -> simd_double2x4 {
    return simd_double2x4() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_double2x4, rhs: simd_double2x4) -> simd_double2x4 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_double2x4, rhs: simd_double2x4) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_double2x4, rhs: simd_double2x4) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Double, rhs: simd_double2x4) -> simd_double2x4 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_double2x4, rhs: Double) -> simd_double2x4 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_double2x4, rhs: Double) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `DoubleNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Double3x2 * Double3` to get a `Double2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_double2x4, rhs: double2) -> double4 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: double4, rhs: simd_double2x4) -> double2 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double2x4, rhs: double2x2) -> double2x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double2x4, rhs: double3x2) -> double3x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double2x4, rhs: double4x2) -> double4x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_double2x4, rhs: double2x2) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_double2x4")
public func matrix_from_columns(_ col0: double4, _ col1: double4) -> simd_double2x4 {
  return simd_double2x4(col0, col1)
}

public func matrix_from_rows(_ row0: double2, _ row1: double2, _ row2: double2, _ row3: double2) -> simd_double2x4 {
  return double4x2(row0, row1, row2, row3).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_double2x4) -> double4x2 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_double2x4, _ rhs: simd_double2x4) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias double3x4 = simd_double3x4

extension simd_double3x4 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Double) {
    self.init(diagonal: double3(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: double3) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.2.z = diagonal.z
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [double4]) {
    _precondition(columns.count == 3, "Requires array of 3 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [double3]) {
    _precondition(rows.count == 4, "Requires array of 4 vectors")
    self = double4x3(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: double4, _ col1: double4, _ col2: double4) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_double3x4) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_double3x4 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> double4 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Double {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_double3x4 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_double3x4([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_double3x4 : Equatable {
  @_transparent
  public static func ==(lhs: simd_double3x4, rhs: simd_double3x4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_double3x4 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: double4x3 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_double3x4, rhs: simd_double3x4) -> simd_double3x4 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_double3x4) -> simd_double3x4 {
    return simd_double3x4() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_double3x4, rhs: simd_double3x4) -> simd_double3x4 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_double3x4, rhs: simd_double3x4) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_double3x4, rhs: simd_double3x4) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Double, rhs: simd_double3x4) -> simd_double3x4 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_double3x4, rhs: Double) -> simd_double3x4 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_double3x4, rhs: Double) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `DoubleNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Double3x2 * Double3` to get a `Double2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_double3x4, rhs: double3) -> double4 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: double4, rhs: simd_double3x4) -> double3 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double3x4, rhs: double2x3) -> double2x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double3x4, rhs: double3x3) -> double3x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double3x4, rhs: double4x3) -> double4x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_double3x4, rhs: double3x3) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_double3x4")
public func matrix_from_columns(_ col0: double4, _ col1: double4, _ col2: double4) -> simd_double3x4 {
  return simd_double3x4(col0, col1, col2)
}

public func matrix_from_rows(_ row0: double3, _ row1: double3, _ row2: double3, _ row3: double3) -> simd_double3x4 {
  return double4x3(row0, row1, row2, row3).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_double3x4) -> double4x3 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_double3x4, _ rhs: simd_double3x4) -> Bool {
  return lhs == rhs
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 635)

public typealias double4x4 = simd_double4x4

extension simd_double4x4 {

  /// Initialize matrix to have `scalar` on main diagonal, zeros elsewhere.
  public init(_ scalar: Double) {
    self.init(diagonal: double4(scalar))
  }

  /// Initialize matrix to have specified `diagonal`, and zeros elsewhere.
  public init(diagonal: double4) {
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.0.x = diagonal.x
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.1.y = diagonal.y
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.2.z = diagonal.z
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 649)
    self.columns.3.w = diagonal.w
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 651)
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ columns: [double4]) {
    _precondition(columns.count == 4, "Requires array of 4 vectors")
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.0 = columns[0]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.1 = columns[1]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.2 = columns[2]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 658)
    self.columns.3 = columns[3]
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 660)
  }

  /// Initialize matrix to have specified `rows`.
  public init(rows: [double4]) {
    _precondition(rows.count == 4, "Requires array of 4 vectors")
    self = double4x4(rows).transpose
  }

  /// Initialize matrix to have specified `columns`.
  public init(_ col0: double4, _ col1: double4, _ col2: double4, _ col3: double4) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 671)
    self.init()
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.0 = col0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.1 = col1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.2 = col2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 673)
      self.columns.3 = col3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 675)
  }

  /// Initialize matrix from corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This conversion is no longer necessary; use `cmatrix` directly.")
  @_transparent
  public init(_ cmatrix: simd_double4x4) {
    self = cmatrix
  }

  /// Get the matrix as the corresponding C matrix type.
  @available(swift, deprecated: 4, message: "This property is no longer needed; use the matrix itself.")
  @_transparent
  public var cmatrix: simd_double4x4 {
    return self
  }

  /// Access to individual columns.
  public subscript(column: Int) -> double4 {
    get {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 0: return columns.0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 1: return columns.1
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 2: return columns.2
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 696)
      case 3: return columns.3
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 698)
      default: _preconditionFailure("Column index out of range")
      }
    }
    set (value) {
      switch(column) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 0: columns.0 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 1: columns.1 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 2: columns.2 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 704)
      case 3: columns.3 = value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 706)
      default: _preconditionFailure("Column index out of range")
      }
    }
  }

  /// Access to individual elements.
  public subscript(column: Int, row: Int) -> Double {
    get { return self[column][row] }
    set (value) { self[column][row] = value }
  }
}

extension simd_double4x4 : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_double4x4([\(columns.0._descriptionAsArray), \(columns.1._descriptionAsArray), \(columns.2._descriptionAsArray), \(columns.3._descriptionAsArray)])"
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 723)
  }
}

extension simd_double4x4 : Equatable {
  @_transparent
  public static func ==(lhs: simd_double4x4, rhs: simd_double4x4) -> Bool {
    return simd_equal(lhs, rhs)
  }
}

extension simd_double4x4 {

  /// Transpose of the matrix.
  @_transparent
  public var transpose: double4x4 {
    return simd_transpose(self)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 742)
  /// Inverse of the matrix if it exists, otherwise the contents of the
  /// resulting matrix are undefined.
  @available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
  @_transparent
  public var inverse: simd_double4x4 {
    return simd_inverse(self)
  }

  /// Determinant of the matrix.
  @_transparent
  public var determinant: Double {
    return simd_determinant(self)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 756)

  /// Sum of two matrices.
  @_transparent
  public static func +(lhs: simd_double4x4, rhs: simd_double4x4) -> simd_double4x4 {
    return simd_add(lhs, rhs)
  }

  /// Negation of a matrix.
  @_transparent
  public static prefix func -(rhs: simd_double4x4) -> simd_double4x4 {
    return simd_double4x4() - rhs
  }

  /// Difference of two matrices.
  @_transparent
  public static func -(lhs: simd_double4x4, rhs: simd_double4x4) -> simd_double4x4 {
    return simd_sub(lhs, rhs)
  }

  @_transparent
  public static func +=(lhs: inout simd_double4x4, rhs: simd_double4x4) -> Void {
    lhs = lhs + rhs
  }

  @_transparent
  public static func -=(lhs: inout simd_double4x4, rhs: simd_double4x4) -> Void {
    lhs = lhs - rhs
  }

  /// Scalar-Matrix multiplication.
  @_transparent
  public static func *(lhs: Double, rhs: simd_double4x4) -> simd_double4x4 {
    return simd_mul(lhs, rhs)
  }

  /// Matrix-Scalar multiplication.
  @_transparent
  public static func *(lhs: simd_double4x4, rhs: Double) -> simd_double4x4 {
    return rhs*lhs
  }

  @_transparent
  public static func *=(lhs: inout simd_double4x4, rhs: Double) -> Void {
    lhs = lhs*rhs
  }

  /// Matrix-Vector multiplication.  Keep in mind that matrix types are named
  /// `DoubleNxM` where `N` is the number of *columns* and `M` is the number of
  /// *rows*, so we multiply a `Double3x2 * Double3` to get a `Double2`, for
  /// example.
  @_transparent
  public static func *(lhs: simd_double4x4, rhs: double4) -> double4 {
    return simd_mul(lhs, rhs)
  }

  /// Vector-Matrix multiplication.
  @_transparent
  public static func *(lhs: double4, rhs: simd_double4x4) -> double4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double4x4, rhs: double2x4) -> double2x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double4x4, rhs: double3x4) -> double3x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 818)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 822)
  @_transparent
  public static func *(lhs: simd_double4x4, rhs: double4x4) -> double4x4 {
    return simd_mul(lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 828)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 830)
  /// Matrix multiplication (the "usual" matrix product, not the elementwise
  /// product).
  @_transparent
  public static func *=(lhs: inout simd_double4x4, rhs: double4x4) -> Void {
    lhs = lhs*rhs
  }
}

// Make old-style C free functions with the `matrix_` prefix available but
// deprecated in Swift 4.

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 842)
@available(swift, deprecated: 4, renamed: "simd_double4x4(diagonal:)")
public func matrix_from_diagonal(_ d: double4) -> simd_double4x4 {
  return simd_double4x4(diagonal: d)
}

@available(swift, deprecated: 4, message: "Use the .inverse property instead.")
@available(macOS 10.10, iOS 8.0, tvOS 10.0, watchOS 3.0, *)
public func matrix_invert(_ x: simd_double4x4) -> simd_double4x4 {
  return x.inverse
}

@available(swift, deprecated: 4, message: "Use the .determinant property instead.")
public func matrix_determinant(_ x: simd_double4x4) -> Double {
  return x.determinant
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/simd.swift.gyb", line: 859)
@available(swift, deprecated: 4, renamed: "simd_double4x4")
public func matrix_from_columns(_ col0: double4, _ col1: double4, _ col2: double4, _ col3: double4) -> simd_double4x4 {
  return simd_double4x4(col0, col1, col2, col3)
}

public func matrix_from_rows(_ row0: double4, _ row1: double4, _ row2: double4, _ row3: double4) -> simd_double4x4 {
  return double4x4(row0, row1, row2, row3).transpose
}

@available(swift, deprecated: 4, message: "Use the .transpose property instead.")
public func matrix_transpose(_ x: simd_double4x4) -> double4x4 {
  return x.transpose
}

@available(swift, deprecated: 4, renamed: "==")
public func matrix_equal(_ lhs: simd_double4x4, _ rhs: simd_double4x4) -> Bool {
  return lhs == rhs
}

