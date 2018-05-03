// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/Quaternion.swift.gyb", line: 1)
//===----------------------------------------------------------*- swift -*-===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
// simd module overlays for Swift
//===----------------------------------------------------------------------===//

import Swift
import Darwin
@_exported import simd

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/Quaternion.swift.gyb", line: 25)

extension simd_quatf {

  /// Construct a quaternion from components.
  ///
  /// - Parameters:
  ///   - ix: The x-component of the imaginary (vector) part.
  ///   - iy: The y-component of the imaginary (vector) part.
  ///   - iz: The z-component of the imaginary (vector) part.
  ///   - r: The real (scalar) part.
  @_transparent
  public init(ix: Float, iy: Float, iz: Float, r: Float) {
    self.init(vector: float4(ix, iy, iz, r))
  }

  /// Construct a quaternion from real and imaginary parts.
  @_transparent
  public init(real: Float, imag: float3) {
    self.init(vector: simd_make_float4(imag, real))
  }

  /// A quaternion whose action is a rotation by `angle` radians about `axis`.
  ///
  /// - Parameters:
  ///   - angle: The angle to rotate by measured in radians.
  ///   - axis: The axis to rotate around.
  @_transparent
  public init(angle: Float, axis: float3) {
    self = simd_quaternion(angle, axis)
  }

  /// A quaternion whose action rotates the vector `from` onto the vector `to`.
  @_transparent
  public init(from: float3, to: float3) {
    self = simd_quaternion(from, to)
  }

  /// Construct a quaternion from `rotationMatrix`.
  @_transparent
  public init(_ rotationMatrix: simd_float3x3) {
    self = simd_quaternion(rotationMatrix)
  }

  /// Construct a quaternion from `rotationMatrix`.
  @_transparent
  public init(_ rotationMatrix: simd_float4x4) {
    self = simd_quaternion(rotationMatrix)
  }

  /// The real (scalar) part of `self`.
  public var real: Float {
    @_transparent
    get { return vector.w }
    @_transparent
    set { vector.w = newValue }
  }

  /// The imaginary (vector) part of `self`.
  public var imag: float3 {
    @_transparent
    get { return simd_make_float3(vector) }
    @_transparent
    set { vector = simd_make_float4(newValue, vector.w) }
  }

  /// The angle (in radians) by which `self`'s action rotates.
  @_transparent
  public var angle: Float {
    return simd_angle(self)
  }

  /// The normalized axis about which `self`'s action rotates.
  @_transparent
  public var axis: float3 {
    return simd_axis(self)
  }

  /// The conjugate of `self`.
  @_transparent
  public var conjugate: simd_quatf {
    return simd_conjugate(self)
  }

  /// The inverse of `self`.
  @_transparent
  public var inverse: simd_quatf {
    return simd_inverse(self)
  }

  /// The unit quaternion obtained by normalizing `self`.
  @_transparent
  public var normalized: simd_quatf {
    return simd_normalize(self)
  }

  /// The length of the quaternion interpreted as a 4d vector.
  @_transparent
  public var length: Float {
    return simd_length(self)
  }

  /// Applies the rotation represented by a unit quaternion to the vector and
  /// returns the result.
  @_transparent
  public func act(_ vector: float3) -> float3 {
    return simd_act(self, vector)
  }
}

extension simd_float3x3 {
  /// Construct a 3x3 matrix from `quaternion`.
  public init(_ quaternion: simd_quatf) {
    self = simd_matrix3x3(quaternion)
  }
}

extension simd_float4x4 {
  /// Construct a 4x4 matrix from `quaternion`.
  public init(_ quaternion: simd_quatf) {
    self = simd_matrix4x4(quaternion)
  }
}

extension simd_quatf : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_quatf(real: \(real), imag: \(imag))"
  }
}

extension simd_quatf : Equatable {
  @_transparent
  public static func ==(lhs: simd_quatf, rhs: simd_quatf) -> Bool {
    return lhs.vector == rhs.vector
  }
}

extension simd_quatf {
  /// The sum of `lhs` and `rhs`.
  @_transparent
  public static func +(lhs: simd_quatf, rhs: simd_quatf) -> simd_quatf {
    return simd_add(lhs, rhs)
  }

  /// Add `rhs` to `lhs`.
  @_transparent
  public static func +=(lhs: inout simd_quatf, rhs: simd_quatf) {
    lhs = lhs + rhs
  }

  /// The difference of `lhs` and `rhs`.
  @_transparent
  public static func -(lhs: simd_quatf, rhs: simd_quatf) -> simd_quatf {
    return simd_sub(lhs, rhs)
  }

  /// Subtract `rhs` from `lhs`.
  @_transparent
  public static func -=(lhs: inout simd_quatf, rhs: simd_quatf) {
    lhs = lhs - rhs
  }

  /// The negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: simd_quatf) -> simd_quatf {
    return simd_sub(simd_quatf(), rhs)
  }

  /// The product of `lhs` and `rhs`.
  @_transparent
  public static func *(lhs: simd_quatf, rhs: simd_quatf) -> simd_quatf {
    return simd_mul(lhs, rhs)
  }

  /// The product of `lhs` and `rhs`.
  @_transparent
  public static func *(lhs: Float, rhs: simd_quatf) -> simd_quatf {
    return simd_mul(lhs, rhs)
  }

  /// The product of `lhs` and `rhs`.
  @_transparent
  public static func *(lhs: simd_quatf, rhs: Float) -> simd_quatf {
    return simd_mul(lhs, rhs)
  }

  /// Multiply `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout simd_quatf, rhs: simd_quatf) {
    lhs = lhs * rhs
  }

  /// Multiply `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout simd_quatf, rhs: Float) {
    lhs = lhs * rhs
  }

  /// The quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: simd_quatf, rhs: simd_quatf) -> simd_quatf {
    return simd_mul(lhs, rhs.inverse)
  }

  /// The quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: simd_quatf, rhs: Float) -> simd_quatf {
    return simd_quatf(vector: lhs.vector/rhs)
  }

  /// Divide `lhs` by `rhs`.
  @_transparent
  public static func /=(lhs: inout simd_quatf, rhs: simd_quatf) {
    lhs = lhs / rhs
  }

  /// Divide `lhs` by `rhs`.
  @_transparent
  public static func /=(lhs: inout simd_quatf, rhs: Float) {
    lhs = lhs / rhs
  }
}

/// The dot product of the quaternions `p` and `q` interpreted as
/// four-dimensional vectors.
@_transparent
public func dot(_ lhs: simd_quatf, _ rhs: simd_quatf) -> Float {
  return simd_dot(lhs, rhs)
}

/// Logarithm of the quaternion `q`.
///
/// We can write a quaternion `q` in the form: `r(cos(t) + sin(t)v)` where
/// `r` is the length of `q`, `t` is an angle, and `v` is a unit 3-vector.
/// The logarithm of `q` is `log(r) + tv`, just like the logarithm of the
/// complex number `r*(cos(t) + i sin(t))` is `log(r) + it`.
public func log(_ q: simd_quatf) -> simd_quatf {
  return __tg_log(q)
}

/// Inverse function of `log`; the exponential map on quaternions.
@_transparent
public func exp(_ q: simd_quatf) -> simd_quatf {
  return __tg_exp(q)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/simd/Quaternion.swift.gyb", line: 25)

extension simd_quatd {

  /// Construct a quaternion from components.
  ///
  /// - Parameters:
  ///   - ix: The x-component of the imaginary (vector) part.
  ///   - iy: The y-component of the imaginary (vector) part.
  ///   - iz: The z-component of the imaginary (vector) part.
  ///   - r: The real (scalar) part.
  @_transparent
  public init(ix: Double, iy: Double, iz: Double, r: Double) {
    self.init(vector: double4(ix, iy, iz, r))
  }

  /// Construct a quaternion from real and imaginary parts.
  @_transparent
  public init(real: Double, imag: double3) {
    self.init(vector: simd_make_double4(imag, real))
  }

  /// A quaternion whose action is a rotation by `angle` radians about `axis`.
  ///
  /// - Parameters:
  ///   - angle: The angle to rotate by measured in radians.
  ///   - axis: The axis to rotate around.
  @_transparent
  public init(angle: Double, axis: double3) {
    self = simd_quaternion(angle, axis)
  }

  /// A quaternion whose action rotates the vector `from` onto the vector `to`.
  @_transparent
  public init(from: double3, to: double3) {
    self = simd_quaternion(from, to)
  }

  /// Construct a quaternion from `rotationMatrix`.
  @_transparent
  public init(_ rotationMatrix: simd_double3x3) {
    self = simd_quaternion(rotationMatrix)
  }

  /// Construct a quaternion from `rotationMatrix`.
  @_transparent
  public init(_ rotationMatrix: simd_double4x4) {
    self = simd_quaternion(rotationMatrix)
  }

  /// The real (scalar) part of `self`.
  public var real: Double {
    @_transparent
    get { return vector.w }
    @_transparent
    set { vector.w = newValue }
  }

  /// The imaginary (vector) part of `self`.
  public var imag: double3 {
    @_transparent
    get { return simd_make_double3(vector) }
    @_transparent
    set { vector = simd_make_double4(newValue, vector.w) }
  }

  /// The angle (in radians) by which `self`'s action rotates.
  @_transparent
  public var angle: Double {
    return simd_angle(self)
  }

  /// The normalized axis about which `self`'s action rotates.
  @_transparent
  public var axis: double3 {
    return simd_axis(self)
  }

  /// The conjugate of `self`.
  @_transparent
  public var conjugate: simd_quatd {
    return simd_conjugate(self)
  }

  /// The inverse of `self`.
  @_transparent
  public var inverse: simd_quatd {
    return simd_inverse(self)
  }

  /// The unit quaternion obtained by normalizing `self`.
  @_transparent
  public var normalized: simd_quatd {
    return simd_normalize(self)
  }

  /// The length of the quaternion interpreted as a 4d vector.
  @_transparent
  public var length: Double {
    return simd_length(self)
  }

  /// Applies the rotation represented by a unit quaternion to the vector and
  /// returns the result.
  @_transparent
  public func act(_ vector: double3) -> double3 {
    return simd_act(self, vector)
  }
}

extension simd_double3x3 {
  /// Construct a 3x3 matrix from `quaternion`.
  public init(_ quaternion: simd_quatd) {
    self = simd_matrix3x3(quaternion)
  }
}

extension simd_double4x4 {
  /// Construct a 4x4 matrix from `quaternion`.
  public init(_ quaternion: simd_quatd) {
    self = simd_matrix4x4(quaternion)
  }
}

extension simd_quatd : CustomDebugStringConvertible {
  public var debugDescription: String {
    return "simd_quatd(real: \(real), imag: \(imag))"
  }
}

extension simd_quatd : Equatable {
  @_transparent
  public static func ==(lhs: simd_quatd, rhs: simd_quatd) -> Bool {
    return lhs.vector == rhs.vector
  }
}

extension simd_quatd {
  /// The sum of `lhs` and `rhs`.
  @_transparent
  public static func +(lhs: simd_quatd, rhs: simd_quatd) -> simd_quatd {
    return simd_add(lhs, rhs)
  }

  /// Add `rhs` to `lhs`.
  @_transparent
  public static func +=(lhs: inout simd_quatd, rhs: simd_quatd) {
    lhs = lhs + rhs
  }

  /// The difference of `lhs` and `rhs`.
  @_transparent
  public static func -(lhs: simd_quatd, rhs: simd_quatd) -> simd_quatd {
    return simd_sub(lhs, rhs)
  }

  /// Subtract `rhs` from `lhs`.
  @_transparent
  public static func -=(lhs: inout simd_quatd, rhs: simd_quatd) {
    lhs = lhs - rhs
  }

  /// The negation of `rhs`.
  @_transparent
  public static prefix func -(rhs: simd_quatd) -> simd_quatd {
    return simd_sub(simd_quatd(), rhs)
  }

  /// The product of `lhs` and `rhs`.
  @_transparent
  public static func *(lhs: simd_quatd, rhs: simd_quatd) -> simd_quatd {
    return simd_mul(lhs, rhs)
  }

  /// The product of `lhs` and `rhs`.
  @_transparent
  public static func *(lhs: Double, rhs: simd_quatd) -> simd_quatd {
    return simd_mul(lhs, rhs)
  }

  /// The product of `lhs` and `rhs`.
  @_transparent
  public static func *(lhs: simd_quatd, rhs: Double) -> simd_quatd {
    return simd_mul(lhs, rhs)
  }

  /// Multiply `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout simd_quatd, rhs: simd_quatd) {
    lhs = lhs * rhs
  }

  /// Multiply `lhs` by `rhs`.
  @_transparent
  public static func *=(lhs: inout simd_quatd, rhs: Double) {
    lhs = lhs * rhs
  }

  /// The quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: simd_quatd, rhs: simd_quatd) -> simd_quatd {
    return simd_mul(lhs, rhs.inverse)
  }

  /// The quotient of `lhs` and `rhs`.
  @_transparent
  public static func /(lhs: simd_quatd, rhs: Double) -> simd_quatd {
    return simd_quatd(vector: lhs.vector/rhs)
  }

  /// Divide `lhs` by `rhs`.
  @_transparent
  public static func /=(lhs: inout simd_quatd, rhs: simd_quatd) {
    lhs = lhs / rhs
  }

  /// Divide `lhs` by `rhs`.
  @_transparent
  public static func /=(lhs: inout simd_quatd, rhs: Double) {
    lhs = lhs / rhs
  }
}

/// The dot product of the quaternions `p` and `q` interpreted as
/// four-dimensional vectors.
@_transparent
public func dot(_ lhs: simd_quatd, _ rhs: simd_quatd) -> Double {
  return simd_dot(lhs, rhs)
}

/// Logarithm of the quaternion `q`.
///
/// We can write a quaternion `q` in the form: `r(cos(t) + sin(t)v)` where
/// `r` is the length of `q`, `t` is an angle, and `v` is a unit 3-vector.
/// The logarithm of `q` is `log(r) + tv`, just like the logarithm of the
/// complex number `r*(cos(t) + i sin(t))` is `log(r) + it`.
public func log(_ q: simd_quatd) -> simd_quatd {
  return __tg_log(q)
}

/// Inverse function of `log`; the exponential map on quaternions.
@_transparent
public func exp(_ q: simd_quatd) -> simd_quatd {
  return __tg_exp(q)
}

