// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1)
//===--- Integers.swift.gyb -----------------------------------*- swift -*-===//
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
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 68)

// FIXME(integers): remove these two aliases
/// The largest native signed integer type.
@available(swift, obsoleted: 4.0, renamed: "Int64")
public typealias IntMax = Int64
/// The largest native unsigned integer type.
@available(swift, obsoleted: 4.0, renamed: "UInt64")
public typealias UIntMax = UInt64

//===----------------------------------------------------------------------===//
//===--- Bits for the Stdlib ----------------------------------------------===//
//===----------------------------------------------------------------------===//

// FIXME(integers): This should go in the stdlib separately, probably.
extension ExpressibleByIntegerLiteral
  where Self : _ExpressibleByBuiltinIntegerLiteral {
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(integerLiteral value: Self) {
    self = value
  }
}

//===----------------------------------------------------------------------===//
//===--- Operator Documentation -------------------------------------------===//
//===----------------------------------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1035)

//===----------------------------------------------------------------------===//
//===--- Numeric ----------------------------------------------------------===//
//===----------------------------------------------------------------------===//

/// Declares methods backing binary arithmetic operators--such as `+`, `-` and
/// `*`--and their mutating counterparts.
///
/// The `Numeric` protocol provides a suitable basis for arithmetic on
/// scalar values, such as integers and floating-point numbers. You can write
/// generic methods that operate on any numeric type in the standard library
/// by using the `Numeric` protocol as a generic constraint.
///
/// The following example declares a method that calculates the total of any
/// sequence with `Numeric` elements.
///
///     extension Sequence where Element: Numeric {
///         func sum() -> Element {
///             return reduce(0, +)
///         }
///     }
///
/// The `sum()` method is now available on any sequence or collection with
/// numeric values, whether it is an array of `Double` or a countable range of
/// `Int`.
///
///     let arraySum = [1.1, 2.2, 3.3, 4.4, 5.5].sum()
///     // arraySum == 16.5
///
///     let rangeSum = (1..<10).sum()
///     // rangeSum == 45
///
/// Conforming to the Numeric Protocol
/// =====================================
///
/// To add `Numeric` protocol conformance to your own custom type, implement
/// the required mutating methods. Extensions to `Numeric` provide default
/// implementations for the protocol's nonmutating methods based on the
/// mutating variants.
public protocol Numeric : Equatable, ExpressibleByIntegerLiteral {
  /// Creates a new instance from the given integer, if it can be represented
  /// exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `100`, while the attempt to initialize the
  /// constant `y` from `1_000` fails because the `Int8` type can represent
  /// `127` at maximum:
  ///
  ///     let x = Int8(exactly: 100)
  ///     // x == Optional(100)
  ///     let y = Int8(exactly: 1_000)
  ///     // y == nil
  ///
  /// - Parameter source: A value to convert to this type.
  init?<T : BinaryInteger>(exactly source: T)

  /// A type that can represent the absolute value of any possible value of the
  /// conforming type.
  associatedtype Magnitude : Comparable, Numeric

  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  var magnitude: Magnitude { get }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1114)
  // defaulted using an in-place counterpart, but can be used as an
  // optimization hook
  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1116)

  static func +(_ lhs: Self, _ rhs: Self) -> Self

  // implementation hook
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1120)

  static func +=(_ lhs: inout Self, rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1114)
  // defaulted using an in-place counterpart, but can be used as an
  // optimization hook
  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1116)

  static func -(_ lhs: Self, _ rhs: Self) -> Self

  // implementation hook
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1120)

  static func -=(_ lhs: inout Self, rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1114)
  // defaulted using an in-place counterpart, but can be used as an
  // optimization hook
  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1116)

  static func *(_ lhs: Self, _ rhs: Self) -> Self

  // implementation hook
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1120)

  static func *=(_ lhs: inout Self, rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1123)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1150)

/// A type that can represent both positive and negative values.
///
/// The `SignedNumeric` protocol extends the operations defined by the
/// `Numeric` protocol to include a value's additive inverse.
///
/// Conforming to the SignedNumeric Protocol
/// ===========================================
///
/// Because the `SignedNumeric` protocol provides default implementations of
/// both of its required methods, you don't need to do anything beyond
/// declaring conformance to the protocol and ensuring that the values of your
/// type support negation. To customize your type's implementation, provide
/// your own mutating `negate()` method.
public protocol SignedNumeric : Numeric {
  /// Returns the additive inverse of the specified value.
  ///
  /// The negation operator (prefix `-`) returns the additive inverse of its
  /// argument.
  ///
  ///     let x = 21
  ///     let y = -x
  ///     // y == -21
  ///
  /// The resulting value must be representable in the same type as the
  /// argument. In particular, negating a signed, fixed-width integer type's
  /// minimum results in a value that cannot be represented.
  ///
  ///     let z = -Int8.min
  ///     // Overflow error
  ///
  /// - Returns: The additive inverse of this value.
  static prefix func - (_ operand: Self) -> Self

  /// Replaces this value with its additive inverse.
  ///
  /// The following example uses the `negate()` method to negate the value of
  /// an integer `x`:
  ///
  ///     var x = 21
  ///     x.negate()
  ///     // x == -21
  mutating func negate()
}

extension SignedNumeric {
  /// Returns the additive inverse of the specified value.
  ///
  /// The negation operator (prefix `-`) returns the additive inverse of its
  /// argument.
  ///
  ///     let x = 21
  ///     let y = -x
  ///     // y == -21
  ///
  /// The resulting value must be representable in the same type as the
  /// argument. In particular, negating a signed, fixed-width integer type's
  /// minimum results in a value that cannot be represented.
  ///
  ///     let z = -Int8.min
  ///     // Overflow error
  ///
  /// - Returns: The additive inverse of the argument.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static prefix func - (_ operand: Self) -> Self {
    var result = operand
    result.negate()
    return result
  }

  /// Replaces this value with its additive inverse.
  ///
  /// The following example uses the `negate()` method to negate the value of
  /// an integer `x`:
  ///
  ///     var x = 21
  ///     x.negate()
  ///     // x == -21
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public mutating func negate() {
    self = 0 - self
  }
}


/// Returns the absolute value of the given number.
///
/// - Parameter x: A signed number.
/// - Returns: The absolute value of `x`.
@inlinable // FIXME(sil-serialize-all)
@_transparent
public func abs<T : SignedNumeric>(_ x: T) -> T
  where T.Magnitude == T {
  return x.magnitude
}

/// Returns the absolute value of the given number.
///
/// The absolute value of `x` must be representable in the same type. In
/// particular, the absolute value of a signed, fixed-width integer type's
/// minimum cannot be represented.
///
///     let x = Int8.min
///     // x == -128
///     let y = abs(x)
///     // Overflow error
///
/// - Parameter x: A signed number.
/// - Returns: The absolute value of `x`.
@inlinable // FIXME(sil-serialize-all)
public func abs<T : SignedNumeric & Comparable>(_ x: T) -> T {
  return x < 0 ? -x : x
}

extension Numeric {
  /// Returns the given number unchanged.
  ///
  /// You can use the unary plus operator (`+`) to provide symmetry in your
  /// code for positive numbers when also using the unary minus operator.
  ///
  ///     let x = -21
  ///     let y = +21
  ///     // x == -21
  ///     // y == 21
  ///
  /// - Returns: The given argument without any changes.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static prefix func + (x: Self) -> Self {
    return x
  }
}

//===----------------------------------------------------------------------===//
//===--- BinaryInteger ----------------------------------------------------===//
//===----------------------------------------------------------------------===//

/// An integer type with a binary representation.
///
/// The `BinaryInteger` protocol is the basis for all the integer types
/// provided by the standard library. All of the standard library's integer
/// types, such as `Int` and `UInt32`, conform to `BinaryInteger`.
///
/// Converting Between Numeric Types
/// ================================
///
/// You can create new instances of a type that conforms to the `BinaryInteger`
/// protocol from a floating-point number or another binary integer of any
/// type. The `BinaryInteger` protocol provides initializers for four
/// different kinds of conversion.
///
/// Range-Checked Conversion
/// ------------------------
///
/// You use the default `init(_:)` initializer to create a new instance when
/// you're sure that the value passed is representable in the new type. For
/// example, an instance of `Int16` can represent the value `500`, so the
/// first conversion in the code sample below succeeds. That same value is too
/// large to represent as an `Int8` instance, so the second conversion fails,
/// triggering a runtime error.
///
///     let x: Int = 500
///     let y = Int16(x)
///     // y == 500
///
///     let z = Int8(x)
///     // Error: Not enough bits to represent...
///
/// When you create a binary integer from a floating-point value using the
/// default initializer, the value is rounded toward zero before the range is
/// checked. In the following example, the value `127.75` is rounded to `127`,
/// which is representable by the `Int8` type.  `128.25` is rounded to `128`,
/// which is not representable as an `Int8` instance, triggering a runtime
/// error.
///
///     let e = Int8(127.75)
///     // e == 127
///
///     let f = Int8(128.25)
///     // Error: Double value cannot be converted...
///
///
/// Exact Conversion
/// ----------------
///
/// Use the `init?(exactly:)` initializer to create a new instance after
/// checking whether the passed value is representable. Instead of trapping on
/// out-of-range values, using the failable `exact` initializer results in
/// `nil`.
///
///     let x = Int16(exactly: 500)
///     // x == Optional(500)
///
///     let y = Int8(exactly: 500)
///     // y == nil
///
/// When converting floating-point values, the `init?(exact:)` initializer
/// checks both that the passed value has no fractional part and that the
/// value is representable in the resulting type.
///
///     let e = Int8(exactly: 23.0)       // integral value, representable
///     // e == Optional(23)
///
///     let f = Int8(exactly: 23.75)      // fractional value, representable
///     // f == nil
///
///     let g = Int8(exactly: 500.0)      // integral value, nonrepresentable
///     // g == nil
///
/// Clamping Conversion
/// -------------------
///
/// Use the `init(clamping:)` initializer to create a new instance of a binary
/// integer type where out-of-range values are clamped to the representable
/// range of the type. For a type `T`, the resulting value is in the range
/// `T.min...T.max`.
///
///     let x = Int16(clamping: 500)
///     // x == 500
///
///     let y = Int8(clamping: 500)
///     // y == 127
///
///     let z = UInt8(clamping: -500)
///     // z == 0
///
/// Bit Pattern Conversion
/// ----------------------
///
/// Use the `init(truncatingIfNeeded:)` initializer to create a new instance
/// with the same bit pattern as the passed value, extending or truncating the
/// value's representation as necessary. Note that the value may not be
/// preserved, particularly when converting between signed to unsigned integer
/// types or when the destination type has a smaller bit width than the source
/// type. The following example shows how extending and truncating work for
/// nonnegative integers:
///
///     let q: Int16 = 850
///     // q == 0b00000011_01010010
///
///     let r = Int8(truncatingIfNeeded: q)      // truncate 'q' to fit in 8 bits
///     // r == 82
///     //   == 0b01010010
///
///     let s = Int16(truncatingIfNeeded: r)     // extend 'r' to fill 16 bits
///     // s == 82
///     //   == 0b00000000_01010010
///
/// Any padding is performed by *sign-extending* the passed value. When
/// nonnegative integers are extended, the result is padded with zeroes. When
/// negative integers are extended, the result is padded with ones. This
/// example shows several extending conversions of a negative value---note
/// that negative values are sign-extended even when converting to an unsigned
/// type.
///
///     let t: Int8 = -100
///     // t == -100
///     // t's binary representation == 0b10011100
///
///     let u = UInt8(truncatingIfNeeded: t)
///     // u == 156
///     // u's binary representation == 0b10011100
///
///     let v = Int16(truncatingIfNeeded: t)
///     // v == -100
///     // v's binary representation == 0b11111111_10011100
///
///     let w = UInt16(truncatingIfNeeded: t)
///     // w == 65436
///     // w's binary representation == 0b11111111_10011100
///
///
/// Comparing Across Integer Types
/// ==============================
///
/// You can use relational operators, such as the less-than and equal-to
/// operators (`<` and `==`), to compare instances of different binary integer
/// types. The following example compares instances of the `Int`, `UInt`, and
/// `UInt8` types:
///
///     let x: Int = -23
///     let y: UInt = 1_000
///     let z: UInt8 = 23
///
///     if x < y {
///         print("\(x) is less than \(y).")
///     }
///     // Prints "-23 is less than 1000."
///
///     if z > x {
///         print("\(z) is greater than \(x).")
///     }
///     // Prints "23 is greater than -23."
public protocol BinaryInteger :
  Hashable, Numeric, CustomStringConvertible, Strideable
  where Magnitude : BinaryInteger, Magnitude.Magnitude == Magnitude
{
  /// A Boolean value indicating whether this type is a signed integer type.
  ///
  /// *Signed* integer types can represent both positive and negative values.
  /// *Unsigned* integer types can represent only nonnegative values.
  static var isSigned: Bool { get }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  init?<T : BinaryFloatingPoint>(exactly source: T)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  init<T : BinaryFloatingPoint>(_ source: T)

  /// Creates a new instance from the given integer.
  ///
  /// If the value passed as `source` is not representable in this type, a
  /// runtime error may occur.
  ///
  ///     let x = -500 as Int
  ///     let y = Int32(x)
  ///     // y == -500
  ///
  ///     // -500 is not representable as a 'UInt32' instance
  ///     let z = UInt32(x)
  ///     // Error
  ///
  /// - Parameter source: An integer to convert. `source` must be representable
  ///   in this type.
  init<T : BinaryInteger>(_ source: T)

  /// Creates a new instance from the bit pattern of the given instance by
  /// sign-extending or truncating to fit this type.
  ///
  /// When the bit width of `T` (the type of `source`) is equal to or greater
  /// than this type's bit width, the result is the truncated
  /// least-significant bits of `source`. For example, when converting a
  /// 16-bit value to an 8-bit type, only the lower 8 bits of `source` are
  /// used.
  ///
  ///     let p: Int16 = -500
  ///     // 'p' has a binary representation of 11111110_00001100
  ///     let q = Int8(truncatingIfNeeded: p)
  ///     // q == 12
  ///     // 'q' has a binary representation of 00001100
  ///
  /// When the bit width of `T` is less than this type's bit width, the result
  /// is *sign-extended* to fill the remaining bits. That is, if `source` is
  /// negative, the result is padded with ones; otherwise, the result is
  /// padded with zeros.
  ///
  ///     let u: Int8 = 21
  ///     // 'u' has a binary representation of 00010101
  ///     let v = Int16(truncatingIfNeeded: u)
  ///     // v == 21
  ///     // 'v' has a binary representation of 00000000_00010101
  ///
  ///     let w: Int8 = -21
  ///     // 'w' has a binary representation of 11101011
  ///     let x = Int16(truncatingIfNeeded: w)
  ///     // x == -21
  ///     // 'x' has a binary representation of 11111111_11101011
  ///     let y = UInt16(truncatingIfNeeded: w)
  ///     // y == 65515
  ///     // 'y' has a binary representation of 11111111_11101011
  ///
  /// - Parameter source: An integer to convert to this type.
  init<T : BinaryInteger>(truncatingIfNeeded source: T)

  /// Creates a new instance with the representable value that's closest to the
  /// given integer.
  ///
  /// If the value passed as `source` is greater than the maximum representable
  /// value in this type, the result is the type's `max` value. If `source` is
  /// less than the smallest representable value in this type, the result is
  /// the type's `min` value.
  ///
  /// In this example, `x` is initialized as an `Int8` instance by clamping
  /// `500` to the range `-128...127`, and `y` is initialized as a `UInt`
  /// instance by clamping `-500` to the range `0...UInt.max`.
  ///
  ///     let x = Int8(clamping: 500)
  ///     // x == 127
  ///     // x == Int8.max
  ///
  ///     let y = UInt(clamping: -500)
  ///     // y == 0
  ///
  /// - Parameter source: An integer to convert to this type.
  init<T : BinaryInteger>(clamping source: T)

  // FIXME: Should be `Words : Collection where Words.Element == UInt`
  // See <rdar://problem/31798916> for why it isn't.
  /// A type that represents the words of a binary integer.
  ///
  /// The `Words` type must conform to the `Collection` protocol with an
  /// `Element` type of `UInt`.
  associatedtype Words : Sequence where Words.Element == UInt

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
  var words: Words { get }

  /// The least significant word in this value's binary representation.
  var _lowWord: UInt { get }

  /// The number of bits in the current binary representation of this value.
  ///
  /// This property is a constant for instances of fixed-width integer
  /// types.
  var bitWidth: Int { get }

  /// Returns the integer binary logarithm of this value.
  ///
  /// If the value is negative, a runtime error will occur.
  func _binaryLogarithm() -> Self

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number -8 has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  var trailingZeroBitCount: Int { get }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1610)
  // defaulted using an in-place counterpart, but can be used as an
  // optimization hook
  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1612)

  static func /(_ lhs: Self, _ rhs: Self) -> Self

  // implementation hook
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1616)

  static func /=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1610)
  // defaulted using an in-place counterpart, but can be used as an
  // optimization hook
  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1612)

  static func %(_ lhs: Self, _ rhs: Self) -> Self

  // implementation hook
  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1616)

  static func %=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1610)
  // defaulted using an in-place counterpart, but can be used as an
  // optimization hook
  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1612)

  static func +(_ lhs: Self, _ rhs: Self) -> Self

  // implementation hook
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1616)

  static func +=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1610)
  // defaulted using an in-place counterpart, but can be used as an
  // optimization hook
  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1612)

  static func -(_ lhs: Self, _ rhs: Self) -> Self

  // implementation hook
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1616)

  static func -=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1610)
  // defaulted using an in-place counterpart, but can be used as an
  // optimization hook
  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1612)

  static func *(_ lhs: Self, _ rhs: Self) -> Self

  // implementation hook
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1616)

  static func *=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1619)

  /// Returns the inverse of the bits set in the argument.
  ///
  /// The bitwise NOT operator (`~`) is a prefix operator that returns a value
  /// in which all the bits of its argument are flipped: Bits that are `1` in
  /// the argument are `0` in the result, and bits that are `0` in the argument
  /// are `1` in the result. This is equivalent to the inverse of a set. For
  /// example:
  ///
  ///     let x: UInt8 = 5        // 0b00000101
  ///     let notX = ~x           // 0b11111010
  ///
  /// Performing a bitwise NOT operation on 0 returns a value with every bit
  /// set to `1`.
  ///
  ///     let allOnes = ~UInt8.min   // 0b11111111
  ///
  /// - Complexity: O(1).
  static prefix func ~ (_ x: Self) -> Self

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1640)
  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1640)

  static func &(_ lhs: Self, _ rhs: Self) -> Self

  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1643)

  static func &=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1640)
  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1640)

  static func |(_ lhs: Self, _ rhs: Self) -> Self

  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1643)

  static func |=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1640)
  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1640)

  static func ^(_ lhs: Self, _ rhs: Self) -> Self

  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1643)

  static func ^=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1646)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1648)
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right.
  ///
  /// The `>>` operator performs a *smart shift*, which defines a result for a
  /// shift of any value.
  ///
  /// - Using a negative value for `rhs` performs a left shift using
  ///   `abs(rhs)`.
  /// - Using a value for `rhs` that is greater than or equal to the bit width
  ///   of `lhs` is an *overshift*. An overshift results in `-1` for a
  ///   negative value of `lhs` or `0` for a nonnegative value.
  /// - Using any other value for `rhs` performs a right shift on `lhs` by that
  ///   amount.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the value is shifted right by two bits.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x >> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// If you use `11` as `rhs`, `x` is overshifted such that all of its bits
  /// are set to zero.
  ///
  ///     let z = x >> 11
  ///     // z == 0                         // 0b00000000
  ///
  /// Using a negative value as `rhs` is the same as performing a left shift
  /// using `abs(rhs)`.
  ///
  ///     let a = x >> -3
  ///     // a == 240                       // 0b11110000
  ///     let b = x << 3
  ///     // b == 240                       // 0b11110000
  ///
  /// Right shift operations on negative values "fill in" the high bits with
  /// ones instead of zeros.
  ///
  ///     let q: Int8 = -30                 // 0b11100010
  ///     let r = q >> 2
  ///     // r == -8                        // 0b11111000
  ///
  ///     let s = q >> 11
  ///     // s == -1                        // 0b11111111
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1648)

  static func >><RHS: BinaryInteger>(
    _ lhs: Self, _ rhs: RHS
  ) -> Self

  /// Stores the result of shifting a value's binary representation the
  /// specified number of digits to the right in the left-hand-side variable.
  ///
  /// The `>>=` operator performs a *smart shift*, which defines a result for a
  /// shift of any value.
  ///
  /// - Using a negative value for `rhs` performs a left shift using
  ///   `abs(rhs)`.
  /// - Using a value for `rhs` that is greater than or equal to the bit width
  ///   of `lhs` is an *overshift*. An overshift results in `-1` for a
  ///   negative value of `lhs` or `0` for a nonnegative value.
  /// - Using any other value for `rhs` performs a right shift on `lhs` by that
  ///   amount.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the value is shifted right by two bits.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x >>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// If you use `11` as `rhs`, `x` is overshifted such that all of its bits
  /// are set to zero.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y >>= 11
  ///     // y == 0                         // 0b00000000
  ///
  /// Using a negative value as `rhs` is the same as performing a left shift
  /// using `abs(rhs)`.
  ///
  ///     var a: UInt8 = 30                 // 0b00011110
  ///     a >>= -3
  ///     // a == 240                       // 0b11110000
  ///
  ///     var b: UInt8 = 30                 // 0b00011110
  ///     b <<= 3
  ///     // b == 240                       // 0b11110000
  ///
  /// Right shift operations on negative values "fill in" the high bits with
  /// ones instead of zeros.
  ///
  ///     var q: Int8 = -30                 // 0b11100010
  ///     q >>= 2
  ///     // q == -8                        // 0b11111000
  ///
  ///     var r: Int8 = -30                 // 0b11100010
  ///     r >>= 11
  ///     // r == -1                        // 0b11111111
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1653)

  static func >>=<RHS: BinaryInteger>(
    _ lhs: inout Self, _ rhs: RHS)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1648)
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left.
  ///
  /// The `<<` operator performs a *smart shift*, which defines a result for a
  /// shift of any value.
  ///
  /// - Using a negative value for `rhs` performs a right shift using
  ///   `abs(rhs)`.
  /// - Using a value for `rhs` that is greater than or equal to the bit width
  ///   of `lhs` is an *overshift*, resulting in zero.
  /// - Using any other value for `rhs` performs a left shift on `lhs` by that
  ///   amount.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the value is shifted left by two bits.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x << 2
  ///     // y == 120                       // 0b01111000
  ///
  /// If you use `11` as `rhs`, `x` is overshifted such that all of its bits
  /// are set to zero.
  ///
  ///     let z = x << 11
  ///     // z == 0                         // 0b00000000
  ///
  /// Using a negative value as `rhs` is the same as performing a right shift
  /// with `abs(rhs)`.
  ///
  ///     let a = x << -3
  ///     // a == 3                         // 0b00000011
  ///     let b = x >> 3
  ///     // b == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1648)

  static func <<<RHS: BinaryInteger>(
    _ lhs: Self, _ rhs: RHS
  ) -> Self

  /// Stores the result of shifting a value's binary representation the
  /// specified number of digits to the left in the left-hand-side variable.
  ///
  /// The `<<` operator performs a *smart shift*, which defines a result for a
  /// shift of any value.
  ///
  /// - Using a negative value for `rhs` performs a right shift using
  ///   `abs(rhs)`.
  /// - Using a value for `rhs` that is greater than or equal to the bit width
  ///   of `lhs` is an *overshift*, resulting in zero.
  /// - Using any other value for `rhs` performs a left shift on `lhs` by that
  ///   amount.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the value is shifted left by two bits.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x <<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// If you use `11` as `rhs`, `x` is overshifted such that all of its bits
  /// are set to zero.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y <<= 11
  ///     // y == 0                         // 0b00000000
  ///
  /// Using a negative value as `rhs` is the same as performing a right shift
  /// with `abs(rhs)`.
  ///
  ///     var a: UInt8 = 30                 // 0b00011110
  ///     a <<= -3
  ///     // a == 3                         // 0b00000011
  ///
  ///     var b: UInt8 = 30                 // 0b00011110
  ///     b >>= 3
  ///     // b == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1653)

  static func <<=<RHS: BinaryInteger>(
    _ lhs: inout Self, _ rhs: RHS)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1657)

  /// Returns the quotient and remainder of this value divided by the given
  /// value.
  ///
  /// Use this method to calculate the quotient and remainder of a division at
  /// the same time.
  ///
  ///     let x = 1_000_000
  ///     let (q, r) = x.quotientAndRemainder(dividingBy: 933)
  ///     // q == 1071
  ///     // r == 757
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the quotient and remainder of this value
  ///   divided by `rhs`.
  func quotientAndRemainder(dividingBy rhs: Self)
    -> (quotient: Self, remainder: Self)

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  func signum() -> Self
}

extension BinaryInteger {
  /// Creates a new value equal to zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init() {
    self = 0
  }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func signum() -> Self {
    return (self > (0 as Self) ? 1 : 0) - (self < (0 as Self) ? 1 : 0)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var _lowWord: UInt {
    var it = words.makeIterator()
    return it.next() ?? 0
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _binaryLogarithm() -> Self {
    _precondition(self > (0 as Self))
    var (quotient, remainder) =
      (bitWidth &- 1).quotientAndRemainder(dividingBy: UInt.bitWidth)
    remainder = remainder &+ 1
    var word = UInt(truncatingIfNeeded: self >> (bitWidth &- remainder))
    // If, internally, a variable-width binary integer uses digits of greater
    // bit width than that of Magnitude.Words.Element (i.e., UInt), then it is
    // possible that `word` could be zero. Additionally, a signed variable-width
    // binary integer may have a leading word that is zero to store a clear sign
    // bit.
    while word == 0 {
      quotient = quotient &- 1
      remainder = remainder &+ UInt.bitWidth
      word = UInt(truncatingIfNeeded: self >> (bitWidth &- remainder))
    }
    // Note that the order of operations below is important to guarantee that
    // we won't overflow.
    return Self(
      UInt.bitWidth &* quotient &+
        (UInt.bitWidth &- (word.leadingZeroBitCount &+ 1)))
  }

  /// Returns the quotient and remainder of this value divided by the given
  /// value.
  ///
  /// Use this method to calculate the quotient and remainder of a division at
  /// the same time.
  ///
  ///     let x = 1_000_000
  ///     let (q, r) = x.quotientAndRemainder(dividingBy: 933)
  ///     // q == 1071
  ///     // r == 757
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the quotient and remainder of this value
  ///   divided by `rhs`.
  @inlinable // FIXME(sil-serialize-all)
  public func quotientAndRemainder(dividingBy rhs: Self)
    -> (quotient: Self, remainder: Self) {
    return (self / rhs, self % rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1754)

  // Homogeneous
  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1756)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func & (lhs: Self, rhs: Self) -> Self {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1754)

  // Homogeneous
  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1756)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func | (lhs: Self, rhs: Self) -> Self {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1754)

  // Homogeneous
  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1756)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^ (lhs: Self, rhs: Self) -> Self {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1766)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1768)
  // Heterogeneous non-masking shift in terms of shift-assignment
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right.
  ///
  /// The `>>` operator performs a *smart shift*, which defines a result for a
  /// shift of any value.
  ///
  /// - Using a negative value for `rhs` performs a left shift using
  ///   `abs(rhs)`.
  /// - Using a value for `rhs` that is greater than or equal to the bit width
  ///   of `lhs` is an *overshift*. An overshift results in `-1` for a
  ///   negative value of `lhs` or `0` for a nonnegative value.
  /// - Using any other value for `rhs` performs a right shift on `lhs` by that
  ///   amount.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the value is shifted right by two bits.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x >> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// If you use `11` as `rhs`, `x` is overshifted such that all of its bits
  /// are set to zero.
  ///
  ///     let z = x >> 11
  ///     // z == 0                         // 0b00000000
  ///
  /// Using a negative value as `rhs` is the same as performing a left shift
  /// using `abs(rhs)`.
  ///
  ///     let a = x >> -3
  ///     // a == 240                       // 0b11110000
  ///     let b = x << 3
  ///     // b == 240                       // 0b11110000
  ///
  /// Right shift operations on negative values "fill in" the high bits with
  /// ones instead of zeros.
  ///
  ///     let q: Int8 = -30                 // 0b11100010
  ///     let r = q >> 2
  ///     // r == -8                        // 0b11111000
  ///
  ///     let s = q >> 11
  ///     // s == -1                        // 0b11111111
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1769)

  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inlinable
  public static func >><RHS: BinaryInteger>(
    _ lhs: Self, _ rhs: RHS
  ) -> Self {
    var r = lhs
    r >>= rhs
    return r
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1768)
  // Heterogeneous non-masking shift in terms of shift-assignment
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left.
  ///
  /// The `<<` operator performs a *smart shift*, which defines a result for a
  /// shift of any value.
  ///
  /// - Using a negative value for `rhs` performs a right shift using
  ///   `abs(rhs)`.
  /// - Using a value for `rhs` that is greater than or equal to the bit width
  ///   of `lhs` is an *overshift*, resulting in zero.
  /// - Using any other value for `rhs` performs a left shift on `lhs` by that
  ///   amount.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the value is shifted left by two bits.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x << 2
  ///     // y == 120                       // 0b01111000
  ///
  /// If you use `11` as `rhs`, `x` is overshifted such that all of its bits
  /// are set to zero.
  ///
  ///     let z = x << 11
  ///     // z == 0                         // 0b00000000
  ///
  /// Using a negative value as `rhs` is the same as performing a right shift
  /// with `abs(rhs)`.
  ///
  ///     let a = x << -3
  ///     // a == 3                         // 0b00000011
  ///     let b = x >> 3
  ///     // b == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1769)

  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inlinable
  public static func <<<RHS: BinaryInteger>(
    _ lhs: Self, _ rhs: RHS
  ) -> Self {
    var r = lhs
    r <<= rhs
    return r
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 1780)

}


//===----------------------------------------------------------------------===//
//===--- CustomStringConvertible conformance ------------------------------===//
//===----------------------------------------------------------------------===//

extension BinaryInteger {
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  internal func _description(radix: Int, uppercase: Bool) -> String {
    _precondition(2...36 ~= radix, "Radix must be between 2 and 36")

    if bitWidth <= 64 {
      let radix_ = Int64(radix)
      return Self.isSigned
        ? _int64ToString(
          Int64(truncatingIfNeeded: self), radix: radix_, uppercase: uppercase)
        : _uint64ToString(
          UInt64(truncatingIfNeeded: self), radix: radix_, uppercase: uppercase)
    }

    if self == (0 as Self) { return "0" }

    // Bit shifting can be faster than division when `radix` is a power of two
    // (although not necessarily the case for builtin types).
    let isRadixPowerOfTwo = radix.nonzeroBitCount == 1
    let radix_ = Magnitude(radix)
    func _quotientAndRemainder(_ value: Magnitude) -> (Magnitude, Magnitude) {
      return isRadixPowerOfTwo
        ? (value >> radix.trailingZeroBitCount, value & (radix_ - 1))
        : value.quotientAndRemainder(dividingBy: radix_)
    }

    let hasLetters = radix > 10
    func _ascii(_ digit: UInt8) -> UInt8 {
      let base: UInt8
      if !hasLetters || digit < 10 {
        base = UInt8(("0" as Unicode.Scalar).value)
      } else if uppercase {
        base = UInt8(("A" as Unicode.Scalar).value) &- 10
      } else {
        base = UInt8(("a" as Unicode.Scalar).value) &- 10
      }
      return base &+ digit
    }

    let isNegative = Self.isSigned && self < (0 as Self)
    var value = magnitude
    var result: [UInt8] = []
    while value != 0 {
      let (quotient, remainder) = _quotientAndRemainder(value)
      result.append(_ascii(UInt8(truncatingIfNeeded: remainder)))
      value = quotient
    }

    if isNegative {
      result.append(UInt8(("-" as Unicode.Scalar).value))
    }
    return String._fromASCII(result.reversed())
  }

  /// A textual representation of this value.
  @inlinable // FIXME(sil-serialize-all)
  public var description: String {
    return _description(radix: 10, uppercase: false)
  }
}


//===----------------------------------------------------------------------===//
//===--- Strideable conformance -------------------------------------------===//
//===----------------------------------------------------------------------===//

extension BinaryInteger {
  // FIXME(ABI): using Int as the return type is wrong.
  /// Returns the distance from this value to the given value, expressed as a
  /// stride.
  ///
  /// For two values `x` and `y`, and a distance `n = x.distance(to: y)`,
  /// `x.advanced(by: n) == y`.
  ///
  /// - Parameter other: The value to calculate the distance to.
  /// - Returns: The distance from this value to `other`.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func distance(to other: Self) -> Int {
    if !Self.isSigned {
      if self > other {
        if let result = Int(exactly: self - other) {
          return -result
        }
      } else {
        if let result = Int(exactly: other - self) {
          return result
        }
      }
    } else {
      let isNegative = self < (0 as Self)
      if isNegative == (other < (0 as Self)) {
        if let result = Int(exactly: other - self) {
          return result
        }
      } else {
        if let result = Int(exactly: self.magnitude + other.magnitude) {
          return isNegative ? result : -result
        }
      }
    }
    _preconditionFailure("Distance is not representable in Int")
  }

  // FIXME(ABI): using Int as the parameter type is wrong.
  /// Returns a value that is offset the specified distance from this value.
  ///
  /// Use the `advanced(by:)` method in generic code to offset a value by a
  /// specified distance. If you're working directly with numeric values, use
  /// the addition operator (`+`) instead of this method.
  ///
  /// For a value `x`, a distance `n`, and a value `y = x.advanced(by: n)`,
  /// `x.distance(to: y) == n`.
  ///
  /// - Parameter n: The distance to advance this value.
  /// - Returns: A value that is offset from this value by `n`.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func advanced(by n: Int) -> Self {
    if !Self.isSigned {
      return n < (0 as Int)
        ? self - Self(-n)
        : self + Self(n)
    }
    if (self < (0 as Self)) == (n < (0 as Self)) {
      return self + Self(n)
    }
    return self.magnitude < n.magnitude
      ? Self(Int(self) + n)
      : self + Self(n)
  }
}

extension Int {
  // FIXME(ABI): using Int as the return type is wrong.
  /// Returns the distance from this value to the given value, expressed as a
  /// stride.
  ///
  /// For two values `x` and `y`, and a distance `n = x.distance(to: y)`,
  /// `x.advanced(by: n) == y`.
  ///
  /// - Parameter other: The value to calculate the distance to.
  /// - Returns: The distance from this value to `other`.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func distance(to other: Int) -> Int {
    return other - self
  }

  // FIXME(ABI): using Int as the parameter type is wrong.
  /// Returns a value that is offset the specified distance from this value.
  ///
  /// Use the `advanced(by:)` method in generic code to offset a value by a
  /// specified distance. If you're working directly with numeric values, use
  /// the addition operator (`+`) instead of this method.
  ///
  /// For a value `x`, a distance `n`, and a value `y = x.advanced(by: n)`,
  /// `x.distance(to: y) == n`.
  ///
  /// - Parameter n: The distance to advance this value.
  /// - Returns: A value that is offset from this value by `n`.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func advanced(by n: Int) -> Int {
    return self + n
  }
}


//===----------------------------------------------------------------------===//
//===--- Heterogeneous comparison -----------------------------------------===//
//===----------------------------------------------------------------------===//

extension BinaryInteger {
  /// Returns a Boolean value indicating whether the two given values are
  /// equal.
  ///
  /// You can check the equality of instances of any `BinaryInteger` types
  /// using the equal-to operator (`==`). For example, you can test whether
  /// the first `UInt8` value in a string's UTF-8 encoding is equal to the
  /// first `UInt32` value in its Unicode scalar view:
  ///
  ///     let gameName = "Red Light, Green Light"
  ///     if let firstUTF8 = gameName.utf8.first,
  ///         let firstScalar = gameName.unicodeScalars.first?.value {
  ///         print("First code values are equal: \(firstUTF8 == firstScalar)")
  ///     }
  ///     // Prints "First code values are equal: true"
  ///
  /// - Parameters:
  ///   - lhs: An integer to compare.
  ///   - rhs: Another integer to compare.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func == <
    Other : BinaryInteger
  >(lhs: Self, rhs: Other) -> Bool {
    let lhsNegative = Self.isSigned && lhs < (0 as Self)
    let rhsNegative = Other.isSigned && rhs < (0 as Other)

    if lhsNegative != rhsNegative { return false }

    // Here we know the values are of the same sign.
    //
    // There are a few possible scenarios from here:
    //
    // 1. Both values are negative
    //  - If one value is strictly wider than the other, then it is safe to
    //    convert to the wider type.
    //  - If the values are of the same width, it does not matter which type we
    //    choose to convert to as the values are already negative, and thus
    //    include the sign bit if two's complement representation already.
    // 2. Both values are non-negative
    //  - If one value is strictly wider than the other, then it is safe to
    //    convert to the wider type.
    //  - If the values are of the same width, than signedness matters, as not
    //    unsigned types are 'wider' in a sense they don't need to 'waste' the
    //    sign bit. Therefore it is safe to convert to the unsigned type.

    if lhs.bitWidth < rhs.bitWidth {
      return Other(truncatingIfNeeded: lhs) == rhs
    }
    if lhs.bitWidth > rhs.bitWidth {
      return lhs == Self(truncatingIfNeeded: rhs)
    }

    if Self.isSigned {
      return Other(truncatingIfNeeded: lhs) == rhs
    }
    return lhs == Self(truncatingIfNeeded: rhs)
  }

  /// Returns a Boolean value indicating whether the two given values are not
  /// equal.
  ///
  /// You can check the inequality of instances of any `BinaryInteger` types
  /// using the not-equal-to operator (`!=`). For example, you can test
  /// whether the first `UInt8` value in a string's UTF-8 encoding is not
  /// equal to the first `UInt32` value in its Unicode scalar view:
  ///
  ///     let gameName = "Red Light, Green Light"
  ///     if let firstUTF8 = gameName.utf8.first,
  ///         let firstScalar = gameName.unicodeScalars.first?.value {
  ///         print("First code values are different: \(firstUTF8 != firstScalar)")
  ///     }
  ///     // Prints "First code values are different: false"
  ///
  /// - Parameters:
  ///   - lhs: An integer to compare.
  ///   - rhs: Another integer to compare.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != <
    Other : BinaryInteger
  >(lhs: Self, rhs: Other) -> Bool {
    return !(lhs == rhs)
  }

  /// Returns a Boolean value indicating whether the value of the first
  /// argument is less than that of the second argument.
  ///
  /// You can compare instances of any `BinaryInteger` types using the
  /// less-than operator (`<`), even if the two instances are of different
  /// types.
  ///
  /// - Parameters:
  ///   - lhs: An integer to compare.
  ///   - rhs: Another integer to compare.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func < <Other : BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
    let lhsNegative = Self.isSigned && lhs < (0 as Self)
    let rhsNegative = Other.isSigned && rhs < (0 as Other)
    if lhsNegative != rhsNegative { return lhsNegative }

    if lhs == (0 as Self) && rhs == (0 as Other) { return false }

    // if we get here, lhs and rhs have the same sign. If they're negative,
    // then Self and Other are both signed types, and one of them can represent
    // values of the other type. Otherwise, lhs and rhs are positive, and one
    // of Self, Other may be signed and the other unsigned.

    let rhsAsSelf = Self(truncatingIfNeeded: rhs)
    let rhsAsSelfNegative = rhsAsSelf < (0 as Self)


    // Can we round-trip rhs through Other?
    if Other(truncatingIfNeeded: rhsAsSelf) == rhs &&
      // This additional check covers the `Int8.max < (128 as UInt8)` case.
      // Since the types are of the same width, init(truncatingIfNeeded:)
      // will result in a simple bitcast, so that rhsAsSelf would be -128, and
      // `lhs < rhsAsSelf` will return false.
      // We basically guard against that bitcast by requiring rhs and rhsAsSelf
      // to be the same sign.
      rhsNegative == rhsAsSelfNegative {
      return lhs < rhsAsSelf
    }

    return Other(truncatingIfNeeded: lhs) < rhs
  }

  /// Returns a Boolean value indicating whether the value of the first
  /// argument is less than or equal to that of the second argument.
  ///
  /// You can compare instances of any `BinaryInteger` types using the
  /// less-than-or-equal-to operator (`<=`), even if the two instances are of
  /// different types.
  ///
  /// - Parameters:
  ///   - lhs: An integer to compare.
  ///   - rhs: Another integer to compare.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  //@inline(__always)
  public static func <= <Other : BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
    return !(rhs < lhs)
  }

  /// Returns a Boolean value indicating whether the value of the first
  /// argument is greater than or equal to that of the second argument.
  ///
  /// You can compare instances of any `BinaryInteger` types using the
  /// greater-than-or-equal-to operator (`>=`), even if the two instances are
  /// of different types.
  ///
  /// - Parameters:
  ///   - lhs: An integer to compare.
  ///   - rhs: Another integer to compare.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  //@inline(__always)
  public static func >= <Other : BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
    return !(lhs < rhs)
  }

  /// Returns a Boolean value indicating whether the value of the first
  /// argument is greater than that of the second argument.
  ///
  /// You can compare instances of any `BinaryInteger` types using the
  /// greater-than operator (`>`), even if the two instances are of different
  /// types.
  ///
  /// - Parameters:
  ///   - lhs: An integer to compare.
  ///   - rhs: Another integer to compare.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  //@inline(__always)
  public static func > <Other : BinaryInteger>(lhs: Self, rhs: Other) -> Bool {
    return rhs < lhs
  }
}

//===----------------------------------------------------------------------===//
//===--- Ambiguity breakers -----------------------------------------------===//
//
// These two versions of the operators are not ordered with respect to one
// another, but the compiler choses the second one, and that results in infinite
// recursion.
//
//     <T : Comparable>(T, T) -> Bool
//     <T : BinaryInteger, U : BinaryInteger>(T, U) -> Bool
//
// so we define:
//
//     <T : BinaryInteger>(T, T) -> Bool
//
//===----------------------------------------------------------------------===//

extension BinaryInteger {
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: Self, rhs: Self) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: Self, rhs: Self) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: Self, rhs: Self) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: Self, rhs: Self) -> Bool {
    return rhs < lhs
  }
}

//===----------------------------------------------------------------------===//
//===--- FixedWidthInteger ------------------------------------------------===//
//===----------------------------------------------------------------------===//

/// An integer type that uses a fixed size for every instance.
///
/// The `FixedWidthInteger` protocol adds binary bitwise operations, bit
/// shifts, and overflow handling to the operations supported by the
/// `BinaryInteger` protocol.
///
/// Use the `FixedWidthInteger` protocol as a constraint or extension point
/// when writing operations that depend on bit shifting, performing bitwise
/// operations, catching overflows, or having access to the maximum or minimum
/// representable value of a type. For example, the following code provides a
/// `binaryString` property on every fixed-width integer that represents the
/// number's binary representation, split into 8-bit chunks.
///
///     extension FixedWidthInteger {
///         var binaryString: String {
///             var result: [String] = []
///             for i in 0..<(Self.bitWidth / 8) {
///                 let byte = UInt8(truncatingIfNeeded: self >> (i * 8))
///                 let byteString = String(byte, radix: 2)
///                 let padding = String(repeating: "0",
///                                      count: 8 - byteString.count)
///                 result.append(padding + byteString)
///             }
///             return "0b" + result.reversed().joined(separator: "_")
///         }
///     }
///
///     print(Int16.max.binaryString)
///     // Prints "0b01111111_11111111"
///     print((101 as UInt8).binaryString)
///     // Prints "0b11001001"
///
/// The `binaryString` implementation uses the static `bitWidth` property and
/// the right shift operator (`<<`), both of which are available to any type
/// that conforms to the `FixedWidthInteger` protocol.
///
/// The next example declares a generic `squared` function, which accepts an
/// instance `x` of any fixed-width integer type. The function uses the
/// `multipliedReportingOverflow(by:)` method to multiply `x` by itself and
/// check whether the result is too large to represent in the same type.
///
///     func squared<T: FixedWidthInteger>(_ x: T) -> T? {
///         let (result, overflow) = x.multipliedReportingOverflow(by: x)
///         if overflow {
///             return nil
///         }
///         return result
///     }
///
///     let (x, y): (Int8, Int8) = (9, 123)
///     print(squared(x))
///     // Prints "Optional(81)"
///     print(squared(y))
///     // Prints "nil"
///
/// Conforming to the FixedWidthInteger Protocol
/// ============================================
///
/// To make your own custom type conform to the `FixedWidthInteger` protocol,
/// declare the required initializers, properties, and methods. The required
/// methods that are suffixed with `ReportingOverflow` serve as the
/// customization points for arithmetic operations. When you provide just those
/// methods, the standard library provides default implementations for all
/// other arithmetic methods and operators.
public protocol FixedWidthInteger :
  BinaryInteger, LosslessStringConvertible, _BitwiseOperations
  where Magnitude : FixedWidthInteger
{
  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
  /// An unsigned, fixed-width integer type can represent values from 0 through
  /// `(2 ** bitWidth) - 1`, where `**` is exponentiation. A signed,
  /// fixed-width integer type can represent values from
  /// `-(2 ** (bitWidth - 1))` through `(2 ** (bitWidth - 1)) - 1`. For example,
  /// the `Int8` type has a `bitWidth` value of 8 and can store any integer in
  /// the range `-128...127`.
  static var bitWidth: Int { get }

  /// The maximum representable integer in this type.
  ///
  /// For unsigned integer types, this value is `(2 ** bitWidth) - 1`, where
  /// `**` is exponentiation. For signed integer types, this value is
  /// `(2 ** (bitWidth - 1)) - 1`.
  static var max: Self { get }

  /// The minimum representable integer in this type.
  ///
  /// For unsigned integer types, this value is always `0`. For signed integer
  /// types, this value is `-(2 ** (bitWidth - 1))`, where `**` is
  /// exponentiation.
  static var min: Self { get }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)
  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)

  func addingReportingOverflow(
    _ rhs: Self
  ) -> (partialValue: Self, overflow: Bool)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)
  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)

  func subtractingReportingOverflow(
    _ rhs: Self
  ) -> (partialValue: Self, overflow: Bool)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)
  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)

  func multipliedReportingOverflow(
    by rhs: Self
  ) -> (partialValue: Self, overflow: Bool)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)
  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)

  func dividedReportingOverflow(
    by rhs: Self
  ) -> (partialValue: Self, overflow: Bool)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)
  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2282)

  func remainderReportingOverflow(
    dividingBy rhs: Self
  ) -> (partialValue: Self, overflow: Bool)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2287)

  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple containing both the
  /// `high` and `low` parts of the product of this value and `other`. The
  /// following example uses this method to multiply two `Int8` values that
  /// normally overflow when multiplied:
  ///
  ///     let x: Int8 = 48
  ///     let y: Int8 = -40
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == -8
  ///     // result.low  == 128
  ///
  /// The product of `x` and `y` is `-1920`, which is too large to represent in
  /// an `Int8` instance. The `high` and `low` compnents of the `result` value
  /// represent `-1920` when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of an `Int16` instance.
  ///
  ///     let z = Int16(result.high) << 8 | Int16(result.low)
  ///     // z == -1920
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  func multipliedFullWidth(by other: Self) -> (high: Self, low: Self.Magnitude)

  /// Returns a tuple containing the quotient and remainder obtained by dividing
  /// the given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient is too large to represent in the type, a runtime
  /// error may occur.
  ///
  /// The following example divides a value that is too large to be represented
  /// using a single `Int` instance by another `Int` value. Because the quotient
  /// is representable as an `Int`, the division succeeds.
  ///
  ///     // 'dividend' represents the value 0x506f70652053616e74612049494949
  ///     let dividend = (22640526660490081, 7959093232766896457 as UInt)
  ///     let divisor = 2241543570477705381
  ///
  ///     let (quotient, remainder) = divisor.dividingFullWidth(dividend)
  ///     // quotient == 186319822866995413
  ///     // remainder == 0
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer.
  /// - Returns: A tuple containing the quotient and remainder obtained by
  ///   dividing `dividend` by this value.
  func dividingFullWidth(_ dividend: (high: Self, low: Self.Magnitude))
    -> (quotient: Self, remainder: Self)

  init(_truncatingBits bits: UInt)

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  var nonzeroBitCount: Int { get }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  var leadingZeroBitCount: Int { get }

  /// Creates an integer from its big-endian representation, changing the byte
  /// order if necessary.
  ///
  /// - Parameter value: A value to use as the big-endian representation of the
  ///   new integer.
  init(bigEndian value: Self)

  /// Creates an integer from its little-endian representation, changing the
  /// byte order if necessary.
  ///
  /// - Parameter value: A value to use as the little-endian representation of
  ///   the new integer.
  init(littleEndian value: Self)

  /// The big-endian representation of this integer.
  ///
  /// If necessary, the byte order of this value is reversed from the typical
  /// byte order of this integer type. On a big-endian platform, for any
  /// integer `x`, `x == x.bigEndian`.
  var bigEndian: Self { get }

  /// The little-endian representation of this integer.
  ///
  /// If necessary, the byte order of this value is reversed from the typical
  /// byte order of this integer type. On a little-endian platform, for any
  /// integer `x`, `x == x.littleEndian`.
  var littleEndian: Self { get }

  /// A representation of this integer with the byte order swapped.
  var byteSwapped: Self { get }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2398)
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2398)

  static func &>>(_ lhs: Self, _ rhs: Self) -> Self

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2401)

  static func &>>=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2398)
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2398)

  static func &<<(_ lhs: Self, _ rhs: Self) -> Self

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2401)

  static func &<<=(_ lhs: inout Self, _ rhs: Self)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2404)

}

extension FixedWidthInteger {
  /// The empty bitset.
  ///
  /// The `allZeros` static property is the [identity element][] for bitwise OR
  /// and XOR operations and the [fixed point][] for bitwise AND operations.
  /// For example:
  ///
  ///     let x: UInt8 = 5        // 0b00000101
  ///
  ///     // Identity
  ///     x | .allZeros           // 0b00000101
  ///     x ^ .allZeros           // 0b00000101
  ///
  ///     // Fixed point
  ///     x & .allZeros           // 0b00000000
  ///
  /// [identity element]:http://en.wikipedia.org/wiki/Identity_element
  /// [fixed point]:http://en.wikipedia.org/wiki/Fixed_point_(mathematics)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, deprecated: 3.1, obsoleted: 4.0, message: "Use 0")
  public static var allZeros: Self { return 0 }

  /// The number of bits in the binary representation of this value.
  @inlinable
  public var bitWidth: Int { return Self.bitWidth }

  @inlinable // FIXME(sil-serialize-all)
  public func _binaryLogarithm() -> Self {
    _precondition(self > (0 as Self))
    return Self(Self.bitWidth &- (leadingZeroBitCount &+ 1))
  }

  /// Creates an integer from its little-endian representation, changing the
  /// byte order if necessary.
  ///
  /// - Parameter value: A value to use as the little-endian representation of
  ///   the new integer.
  @inlinable // FIXME(sil-serialize-all)
  public init(littleEndian value: Self) {
#if _endian(little)
    self = value
#else
    self = value.byteSwapped
#endif
  }

  /// Creates an integer from its big-endian representation, changing the byte
  /// order if necessary.
  ///
  /// - Parameter value: A value to use as the big-endian representation of the
  ///   new integer.
  @inlinable // FIXME(sil-serialize-all)
  public init(bigEndian value: Self) {
#if _endian(big)
    self = value
#else
    self = value.byteSwapped
#endif
  }

  /// The little-endian representation of this integer.
  ///
  /// If necessary, the byte order of this value is reversed from the typical
  /// byte order of this integer type. On a little-endian platform, for any
  /// integer `x`, `x == x.littleEndian`.
  @inlinable // FIXME(sil-serialize-all)
  public var littleEndian: Self {
#if _endian(little)
    return self
#else
    return byteSwapped
#endif
  }

  /// The big-endian representation of this integer.
  ///
  /// If necessary, the byte order of this value is reversed from the typical
  /// byte order of this integer type. On a big-endian platform, for any
  /// integer `x`, `x == x.bigEndian`.
  @inlinable // FIXME(sil-serialize-all)
  public var bigEndian: Self {
#if _endian(big)
    return self
#else
    return byteSwapped
#endif
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2496)

  // Homogeneous masking shift
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2498)

  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func &>> (lhs: Self, rhs: Self) -> Self {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }


  // Heterogeneous masking shift
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2510)

  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inlinable
  public static func &>> <
    Other : BinaryInteger
  >(lhs: Self, rhs: Other) -> Self {
    return lhs &>> Self(truncatingIfNeeded: rhs)
  }

  // Heterogeneous masking shift assignment
  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2520)

  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func &>>= <
    Other : BinaryInteger
  >(lhs: inout Self, rhs: Other) {
    lhs = lhs &>> rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2496)

  // Homogeneous masking shift
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2498)

  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func &<< (lhs: Self, rhs: Self) -> Self {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }


  // Heterogeneous masking shift
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2510)

  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inlinable
  public static func &<< <
    Other : BinaryInteger
  >(lhs: Self, rhs: Other) -> Self {
    return lhs &<< Self(truncatingIfNeeded: rhs)
  }

  // Heterogeneous masking shift assignment
  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2520)

  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func &<<= <
    Other : BinaryInteger
  >(lhs: inout Self, rhs: Other) {
    lhs = lhs &<< rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2531)
}

//===----------------------------------------------------------------------===//
//===--- Operators on FixedWidthInteger -----------------------------------===//
//===----------------------------------------------------------------------===//

extension FixedWidthInteger {
  /// Returns the inverse of the bits set in the argument.
  ///
  /// The bitwise NOT operator (`~`) is a prefix operator that returns a value
  /// in which all the bits of its argument are flipped: Bits that are `1` in
  /// the argument are `0` in the result, and bits that are `0` in the argument
  /// are `1` in the result. This is equivalent to the inverse of a set. For
  /// example:
  ///
  ///     let x: UInt8 = 5        // 0b00000101
  ///     let notX = ~x           // 0b11111010
  ///
  /// Performing a bitwise NOT operation on 0 returns a value with every bit
  /// set to `1`.
  ///
  ///     let allOnes = ~UInt8.min   // 0b11111111
  ///
  /// - Complexity: O(1).
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static prefix func ~ (x: Self) -> Self {
    return 0 &- x &- 1
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2562)

//===----------------------------------------------------------------------===//
//=== "Smart right shift", supporting overshifts and negative shifts -===//
//===----------------------------------------------------------------------===//

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right.
  ///
  /// The `>>` operator performs a *smart shift*, which defines a result for a
  /// shift of any value.
  ///
  /// - Using a negative value for `rhs` performs a left shift using
  ///   `abs(rhs)`.
  /// - Using a value for `rhs` that is greater than or equal to the bit width
  ///   of `lhs` is an *overshift*. An overshift results in `-1` for a
  ///   negative value of `lhs` or `0` for a nonnegative value.
  /// - Using any other value for `rhs` performs a right shift on `lhs` by that
  ///   amount.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the value is shifted right by two bits.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x >> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// If you use `11` as `rhs`, `x` is overshifted such that all of its bits
  /// are set to zero.
  ///
  ///     let z = x >> 11
  ///     // z == 0                         // 0b00000000
  ///
  /// Using a negative value as `rhs` is the same as performing a left shift
  /// using `abs(rhs)`.
  ///
  ///     let a = x >> -3
  ///     // a == 240                       // 0b11110000
  ///     let b = x << 3
  ///     // b == 240                       // 0b11110000
  ///
  /// Right shift operations on negative values "fill in" the high bits with
  /// ones instead of zeros.
  ///
  ///     let q: Int8 = -30                 // 0b11100010
  ///     let r = q >> 2
  ///     // r == -8                        // 0b11111000
  ///
  ///     let s = q >> 11
  ///     // s == -1                        // 0b11111111
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2567)

  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >> <
    Other : BinaryInteger
  >(lhs: Self, rhs: Other) -> Self {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @_semantics("optimize.sil.specialize.generic.partial.never")
  public static func >>= <
    Other : BinaryInteger
  >(lhs: inout Self, rhs: Other) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func _nonMaskingRightShiftGeneric <
    Other : BinaryInteger
  >(_ lhs: inout Self, _ rhs: Other) {
    let shift = rhs < -Self.bitWidth ? -Self.bitWidth
                : rhs > Self.bitWidth ? Self.bitWidth
                : Int(rhs)
    lhs = _nonMaskingRightShift(lhs, shift)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2601)
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func _nonMaskingRightShift(_ lhs: Self, _ rhs: Int) -> Self {
    let overshiftR = Self.isSigned ? lhs &>> (Self.bitWidth - 1) : 0
    let overshiftL: Self = 0
    if _fastPath(rhs >= 0) {
      if _fastPath(rhs < Self.bitWidth) {
        return lhs &>> Self(truncatingIfNeeded: rhs)
      }
      return overshiftR
    }

    if _slowPath(rhs <= -Self.bitWidth) {
      return overshiftL
    }
    return lhs &<< -rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2562)

//===----------------------------------------------------------------------===//
//=== "Smart left shift", supporting overshifts and negative shifts -===//
//===----------------------------------------------------------------------===//

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left.
  ///
  /// The `<<` operator performs a *smart shift*, which defines a result for a
  /// shift of any value.
  ///
  /// - Using a negative value for `rhs` performs a right shift using
  ///   `abs(rhs)`.
  /// - Using a value for `rhs` that is greater than or equal to the bit width
  ///   of `lhs` is an *overshift*, resulting in zero.
  /// - Using any other value for `rhs` performs a left shift on `lhs` by that
  ///   amount.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the value is shifted left by two bits.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x << 2
  ///     // y == 120                       // 0b01111000
  ///
  /// If you use `11` as `rhs`, `x` is overshifted such that all of its bits
  /// are set to zero.
  ///
  ///     let z = x << 11
  ///     // z == 0                         // 0b00000000
  ///
  /// Using a negative value as `rhs` is the same as performing a right shift
  /// with `abs(rhs)`.
  ///
  ///     let a = x << -3
  ///     // a == 3                         // 0b00000011
  ///     let b = x >> 3
  ///     // b == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2567)

  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func << <
    Other : BinaryInteger
  >(lhs: Self, rhs: Other) -> Self {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  @_semantics("optimize.sil.specialize.generic.partial.never")
  public static func <<= <
    Other : BinaryInteger
  >(lhs: inout Self, rhs: Other) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func _nonMaskingLeftShiftGeneric <
    Other : BinaryInteger
  >(_ lhs: inout Self, _ rhs: Other) {
    let shift = rhs < -Self.bitWidth ? -Self.bitWidth
                : rhs > Self.bitWidth ? Self.bitWidth
                : Int(rhs)
    lhs = _nonMaskingLeftShift(lhs, shift)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2601)
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func _nonMaskingLeftShift(_ lhs: Self, _ rhs: Int) -> Self {
    let overshiftR = Self.isSigned ? lhs &>> (Self.bitWidth - 1) : 0
    let overshiftL: Self = 0
    if _fastPath(rhs >= 0) {
      if _fastPath(rhs < Self.bitWidth) {
        return lhs &<< Self(truncatingIfNeeded: rhs)
      }
      return overshiftL
    }

    if _slowPath(rhs <= -Self.bitWidth) {
      return overshiftR
    }
    return lhs &>> -rhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2620)
}

extension FixedWidthInteger {
  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  public // @testable
  static func _convert<Source : BinaryFloatingPoint>(
    from source: Source
  ) -> (value: Self?, exact: Bool) {
    guard _fastPath(!source.isZero) else { return (0, true) }
    guard _fastPath(source.isFinite) else { return (nil, false) }
    guard Self.isSigned || source > -1 else { return (nil, false) }
    let exponent = source.exponent
    if _slowPath(Self.bitWidth <= exponent) { return (nil, false) }
    let minBitWidth = source.significandWidth
    let isExact = (minBitWidth <= exponent)
    let bitPattern = source.significandBitPattern
    // `RawSignificand.bitWidth` is not available if `RawSignificand` does not
    // conform to `FixedWidthInteger`; we can compute this value as follows if
    // `source` is finite:
    let bitWidth = minBitWidth &+ bitPattern.trailingZeroBitCount
    let shift = exponent - Source.Exponent(bitWidth)
    // Use `Self.Magnitude` to prevent sign extension if `shift < 0`.
    let shiftedBitPattern = Self.Magnitude.bitWidth > bitWidth
      ? Self.Magnitude(truncatingIfNeeded: bitPattern) << shift
      : Self.Magnitude(truncatingIfNeeded: bitPattern << shift)
    if _slowPath(Self.isSigned && Self.bitWidth &- 1 == exponent) {
      return source < 0 && shiftedBitPattern == 0
        ? (Self.min, isExact)
        : (nil, false)
    }
    let magnitude = ((1 as Self.Magnitude) << exponent) | shiftedBitPattern
    return (
      Self.isSigned && source < 0 ? 0 &- Self(magnitude) : Self(magnitude),
      isExact)
  }

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero. Any fractional part of the value passed as `source` is removed.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...outside the representable range
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inline(__always)
  public init<T : BinaryFloatingPoint>(_ source: T) {
    guard let value = Self._convert(from: source).value else {
      fatalError("""
        \(T.self) value cannot be converted to \(Self.self) because it is \
        outside the representable range
        """)
    }
    self = value
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inline(__always)
  public init?<T : BinaryFloatingPoint>(exactly source: T) {
    let (temporary, exact) = Self._convert(from: source)
    guard exact, let value = temporary else {
      return nil
    }
    self = value
  }

  /// Creates a new instance with the representable value that's closest to the
  /// given integer.
  ///
  /// If the value passed as `source` is greater than the maximum representable
  /// value in this type, the result is the type's `max` value. If `source` is
  /// less than the smallest representable value in this type, the result is
  /// the type's `min` value.
  ///
  /// In this example, `x` is initialized as an `Int8` instance by clamping
  /// `500` to the range `-128...127`, and `y` is initialized as a `UInt`
  /// instance by clamping `-500` to the range `0...UInt.max`.
  ///
  ///     let x = Int8(clamping: 500)
  ///     // x == 127
  ///     // x == Int8.max
  ///
  ///     let y = UInt(clamping: -500)
  ///     // y == 0
  ///
  /// - Parameter source: An integer to convert to this type.
  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  public init<Other : BinaryInteger>(clamping source: Other) {
    if _slowPath(source < Self.min) {
      self = Self.min
    }
    else if _slowPath(source > Self.max) {
      self = Self.max
    }
    else { self = Self(truncatingIfNeeded: source) }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2746)
// FIXME(integers): uncomment this block and remove the corresponding one from
// the concrete types
#if false
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2749)

  @_transparent
  public static func +=(_ lhs: inout Self, _ rhs: Self) {
    let (result, overflow) = lhs.addingReportingOverflow(rhs)
    _precondition(!overflow, "Overflow in +=")
    lhs = result
  }
#endif
// end of FIXME(integers)

  /// Returns the sum of this value and the given value without checking for
  /// arithmetic overflow.
  ///
  /// Use this function only to avoid the cost of overflow checking when you
  /// are certain that the operation won't overflow. In optimized builds (`-O`)
  /// the compiler is free to assume that overflow won't occur. Failure to
  /// satisfy that assumption is a serious programming error and could lead to
  /// statements being unexpectedly executed or skipped.
  ///
  /// In debug builds (`-Onone`) a runtime error is still triggered if the
  /// operation overflows.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: The sum of this value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2759)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func unsafeAdding(_ other: Self) -> Self {
    let (result, overflow) = self.addingReportingOverflow(other)

    if overflow {
      if (_isDebugAssertConfiguration()) {
        _preconditionFailure("Overflow in unsafeAdding")
      }
      else {
        Builtin.conditionallyUnreachable()
      }
    }
    return result
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2746)
// FIXME(integers): uncomment this block and remove the corresponding one from
// the concrete types
#if false
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2749)

  @_transparent
  public static func -=(_ lhs: inout Self, _ rhs: Self) {
    let (result, overflow) = lhs.subtractingReportingOverflow(rhs)
    _precondition(!overflow, "Overflow in -=")
    lhs = result
  }
#endif
// end of FIXME(integers)

  /// Returns the difference obtained by subtracting the given value from this
  /// value without checking for arithmetic overflow.
  ///
  /// Use this function only to avoid the cost of overflow checking when you
  /// are certain that the operation won't overflow. In optimized builds (`-O`)
  /// the compiler is free to assume that overflow won't occur. Failure to
  /// satisfy that assumption is a serious programming error and could lead to
  /// statements being unexpectedly executed or skipped.
  ///
  /// In debug builds (`-Onone`) a runtime error is still triggered if the
  /// operation overflows.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: The result of subtracting `rhs` from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2759)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func unsafeSubtracting(_ other: Self) -> Self {
    let (result, overflow) = self.subtractingReportingOverflow(other)

    if overflow {
      if (_isDebugAssertConfiguration()) {
        _preconditionFailure("Overflow in unsafeSubtracting")
      }
      else {
        Builtin.conditionallyUnreachable()
      }
    }
    return result
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2746)
// FIXME(integers): uncomment this block and remove the corresponding one from
// the concrete types
#if false
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2749)

  @_transparent
  public static func *=(_ lhs: inout Self, _ rhs: Self) {
    let (result, overflow) = lhs.multipliedReportingOverflow(by: rhs)
    _precondition(!overflow, "Overflow in *=")
    lhs = result
  }
#endif
// end of FIXME(integers)

  /// Returns the product of this value and the given value without checking
  /// for arithmetic overflow.
  ///
  /// Use this function only to avoid the cost of overflow checking when you
  /// are certain that the operation won't overflow. In optimized builds (`-O`)
  /// the compiler is free to assume that overflow won't occur. Failure to
  /// satisfy that assumption is a serious programming error and could lead to
  /// statements being unexpectedly executed or skipped.
  ///
  /// In debug builds (`-Onone`) a runtime error is still triggered if the
  /// operation overflows.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: The product of this value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2759)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func unsafeMultiplied(by other: Self) -> Self {
    let (result, overflow) = self.multipliedReportingOverflow(by: other)

    if overflow {
      if (_isDebugAssertConfiguration()) {
        _preconditionFailure("Overflow in unsafeMultiplied")
      }
      else {
        Builtin.conditionallyUnreachable()
      }
    }
    return result
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2746)
// FIXME(integers): uncomment this block and remove the corresponding one from
// the concrete types
#if false
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2749)

  @_transparent
  public static func /=(_ lhs: inout Self, _ rhs: Self) {
    let (result, overflow) = lhs.dividedReportingOverflow(by: rhs)
    _precondition(!overflow, "Overflow in /=")
    lhs = result
  }
#endif
// end of FIXME(integers)

  /// Returns the quotient obtained by dividing this value by the given value
  /// without checking for arithmetic overflow.
  ///
  /// Use this function only to avoid the cost of overflow checking when you
  /// are certain that the operation won't overflow. In optimized builds (`-O`)
  /// the compiler is free to assume that overflow won't occur. Failure to
  /// satisfy that assumption is a serious programming error and could lead to
  /// statements being unexpectedly executed or skipped.
  ///
  /// In debug builds (`-Onone`) a runtime error is still triggered if the
  /// operation overflows.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: The result of dividing this value by `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2759)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func unsafeDivided(by other: Self) -> Self {
    let (result, overflow) = self.dividedReportingOverflow(by: other)

    if overflow {
      if (_isDebugAssertConfiguration()) {
        _preconditionFailure("Overflow in unsafeDivided")
      }
      else {
        Builtin.conditionallyUnreachable()
      }
    }
    return result
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2776)

  /// Creates a new instance from the bit pattern of the given instance by
  /// truncating or sign-extending if needed to fit this type.
  ///
  /// When the bit width of `T` (the type of `source`) is equal to or greater
  /// than this type's bit width, the result is the truncated
  /// least-significant bits of `source`. For example, when converting a
  /// 16-bit value to an 8-bit type, only the lower 8 bits of `source` are
  /// used.
  ///
  ///     let p: Int16 = -500
  ///     // 'p' has a binary representation of 11111110_00001100
  ///     let q = Int8(truncatingIfNeeded: p)
  ///     // q == 12
  ///     // 'q' has a binary representation of 00001100
  ///
  /// When the bit width of `T` is less than this type's bit width, the result
  /// is *sign-extended* to fill the remaining bits. That is, if `source` is
  /// negative, the result is padded with ones; otherwise, the result is
  /// padded with zeros.
  ///
  ///     let u: Int8 = 21
  ///     // 'u' has a binary representation of 00010101
  ///     let v = Int16(truncatingIfNeeded: u)
  ///     // v == 21
  ///     // 'v' has a binary representation of 00000000_00010101
  ///
  ///     let w: Int8 = -21
  ///     // 'w' has a binary representation of 11101011
  ///     let x = Int16(truncatingIfNeeded: w)
  ///     // x == -21
  ///     // 'x' has a binary representation of 11111111_11101011
  ///     let y = UInt16(truncatingIfNeeded: w)
  ///     // y == 65515
  ///     // 'y' has a binary representation of 11111111_11101011
  ///
  /// - Parameter source: An integer to convert to this type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public init<T : BinaryInteger>(truncatingIfNeeded source: T) {
    if Self.bitWidth <= 64 {
      self = Self.init(_truncatingBits: source._lowWord)
    }
    else {
      let neg = source < (0 as T)
      var result: Self = neg ? ~0 : 0
      var shift: Self = 0
      let width = Self(_truncatingBits: Self.bitWidth._lowWord)
      for word in source.words {
        guard shift < width else { break }
        // Masking shift is OK here because we have already ensured
        // that shift < Self.bitWidth. Not masking results in
        // infinite recursion.
        result ^= Self(_truncatingBits: neg ? ~word : word) &<< shift
        shift += 64
      }
      self = result
    }
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  static var _highBitIndex: Self {
    return Self.init(_truncatingBits: UInt(Self.bitWidth._value) &- 1)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2846)
  /// Returns the sum of the two given values, discarding any overflow.
  ///
  /// The masking addition operator (`&+`) silently discards any overflow that
  /// occurs during the operation. In the following example, the sum of `100`
  /// and `121` is greater than the maximum representable `Int8` value, so the
  /// result is the overflowed value:
  ///
  ///     let x: Int8 = 10 &+ 21
  ///     // x == 31
  ///     let y: Int8 = 100 &+ 121
  ///     // y == -35 (after overflow)
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2846)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &+ (lhs: Self, rhs: Self) -> Self {
    return lhs.addingReportingOverflow(rhs).partialValue
  }

  /// Adds two values and stores the result in the left-hand-side variable, 
  /// discarding any overflow.
  ///
  /// The masking addition assignment operator (`&+=`) silently discards any 
  /// overflow that occurs during the operation. In the following example, the 
  /// sum of `100` and `121` is greater than the maximum representable `Int8` 
  /// value, so the result is the overflowed value:
  ///
  ///     var x: Int8 = 10
  ///     x &+= 21
  ///     // x == 31
  ///     var y: Int8 = 100
  ///     y &+= 121
  ///     // y == -35 (after overflow)
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2853)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &+= (lhs: inout Self, rhs: Self) {
    lhs = lhs &+ rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2846)
  /// Returns the difference of the two given values, discarding any overflow.
  ///
  /// The masking subtraction operator (`&-`) silently discards any overflow
  /// that occurs during the operation. In the following example, the
  /// difference of `10` and `21` is less than zero, the minimum representable
  /// `UInt` value, so the result is the overflowed value:
  ///
  ///     let x: UInt8 = 21 &- 10
  ///     // x == 11
  ///     let y: UInt8 = 10 &- 21
  ///     // y == 245 (after overflow)
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2846)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &- (lhs: Self, rhs: Self) -> Self {
    return lhs.subtractingReportingOverflow(rhs).partialValue
  }

  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable, discarding any overflow.
  ///
  /// The masking subtraction assignment operator (`&-=`) silently discards any
  /// overflow that occurs during the operation. In the following example, the
  /// difference of `10` and `21` is less than zero, the minimum representable
  /// `UInt` value, so the result is the overflowed value:
  ///
  ///     var x: Int8 = 21
  ///     x &-= 10
  ///     // x == 11
  ///     var y: UInt8 = 10
  ///     y &-= 21
  ///     // y == 245 (after overflow)
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2853)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &-= (lhs: inout Self, rhs: Self) {
    lhs = lhs &- rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2846)
  /// Returns the product of the two given values, discarding any overflow.
  ///
  /// The masking multiplication operator (`&*`) silently discards any overflow
  /// that occurs during the operation. In the following example, the product
  /// of `10` and `50` is greater than the maximum representable `Int8` value,
  /// so the result is the overflowed value:
  ///
  ///     let x: Int8 = 10 &* 5
  ///     // x == 50
  ///     let y: Int8 = 10 &* 50
  ///     // y == -12 (after overflow)
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2846)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &* (lhs: Self, rhs: Self) -> Self {
    return lhs.multipliedReportingOverflow(by: rhs).partialValue
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable, discarding any overflow.
  ///
  /// The masking multiplication assignment operator (`&*=`) silently discards 
  /// any overflow that occurs during the operation. In the following example, 
  /// the product of `10` and `50` is greater than the maximum representable 
  /// `Int8` value, so the result is the overflowed value:
  ///
  ///     var x: Int8 = 10
  ///     x &*= 5
  ///     // x == 50
  ///     var y: Int8 = 10
  ///     y &*= 50
  ///     // y == -12 (after overflow)
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2853)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &*= (lhs: inout Self, rhs: Self) {
    lhs = lhs &* rhs
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 2861)
}

//===----------------------------------------------------------------------===//
//===--- UnsignedInteger --------------------------------------------------===//
//===----------------------------------------------------------------------===//

/// An integer type that can represent only nonnegative values.
public protocol UnsignedInteger : BinaryInteger { }

extension UnsignedInteger {
  /// The magnitude of this value.
  ///
  /// Every unsigned integer is its own magnitude, so for any value `x`,
  /// `x == x.magnitude`.
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var magnitude: Self { return self }

  /// A Boolean value indicating whether this type is a signed integer type.
  ///
  /// This property is always `false` for unsigned integer types.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var isSigned: Bool { return false }
}

extension UnsignedInteger where Self : FixedWidthInteger {
  /// Creates a new instance from the given integer.
  ///
  /// Use this initializer to convert from another integer type when you know
  /// the value is within the bounds of this type. Passing a value that can't
  /// be represented in this type results in a runtime error.
  ///
  /// In the following example, the constant `y` is successfully created from
  /// `x`, an `Int` instance with a value of `100`. Because the `Int8` type
  /// can represent `127` at maximum, the attempt to create `z` with a value
  /// of `1000` results in a runtime error.
  ///
  ///     let x = 100
  ///     let y = Int8(x)
  ///     // y == 100
  ///     let z = Int8(x * 10)
  ///     // Error: Not enough bits to represent the given value
  ///
  /// - Parameter source: A value to convert to this type of integer. The value
  ///   passed as `source` must be representable in this type.
  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inline(__always)
  public init<T : BinaryInteger>(_ source: T) {
    // This check is potentially removable by the optimizer
    if T.isSigned {
      _precondition(source >= (0 as T), "Negative value is not representable")
    }
    // This check is potentially removable by the optimizer
    if source.bitWidth >= Self.bitWidth {
      _precondition(source <= Self.max,
        "Not enough bits to represent a signed value")
    }
    self.init(truncatingIfNeeded: source)
  }

  /// Creates a new instance from the given integer, if it can be represented
  /// exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `100`, while the attempt to initialize the
  /// constant `y` from `1_000` fails because the `Int8` type can represent
  /// `127` at maximum:
  ///
  ///     let x = Int8(exactly: 100)
  ///     // x == Optional(100)
  ///     let y = Int8(exactly: 1_000)
  ///     // y == nil
  ///
  /// - Parameter source: A value to convert to this type of integer.
  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inline(__always)
  public init?<T : BinaryInteger>(exactly source: T) {
    // This check is potentially removable by the optimizer
    if T.isSigned && source < (0 as T) {
      return nil
    }
    // The width check can be eliminated by the optimizer
    if source.bitWidth >= Self.bitWidth &&
       source > Self.max {
      return nil
    }
    self.init(truncatingIfNeeded: source)
  }

  /// The maximum representable integer in this type.
  ///
  /// For unsigned integer types, this value is `(2 ** bitWidth) - 1`, where
  /// `**` is exponentiation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var max: Self {
    return ~0
  }

  /// The minimum representable integer in this type.
  ///
  /// For unsigned integer types, this value is always `0`.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var min: Self {
    return 0
  }
}


//===----------------------------------------------------------------------===//
//===--- SignedInteger ----------------------------------------------------===//
//===----------------------------------------------------------------------===//

/// An integer type that can represent both positive and negative values.
public protocol SignedInteger : BinaryInteger, SignedNumeric {
  // These requirements are for the source code compatibility with Swift 3
  static func _maskingAdd(_ lhs: Self, _ rhs: Self) -> Self
  static func _maskingSubtract(_ lhs: Self, _ rhs: Self) -> Self
}

extension SignedInteger {
  /// A Boolean value indicating whether this type is a signed integer type.
  ///
  /// This property is always `true` for signed integer types.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var isSigned: Bool { return true }
}

extension SignedInteger where Self : FixedWidthInteger {
  /// Creates a new instance from the given integer.
  ///
  /// Use this initializer to convert from another integer type when you know
  /// the value is within the bounds of this type. Passing a value that can't
  /// be represented in this type results in a runtime error.
  ///
  /// In the following example, the constant `y` is successfully created from
  /// `x`, an `Int` instance with a value of `100`. Because the `Int8` type
  /// can represent `127` at maximum, the attempt to create `z` with a value
  /// of `1000` results in a runtime error.
  ///
  ///     let x = 100
  ///     let y = Int8(x)
  ///     // y == 100
  ///     let z = Int8(x * 10)
  ///     // Error: Not enough bits to represent the given value
  ///
  /// - Parameter source: A value to convert to this type of integer. The value
  ///   passed as `source` must be representable in this type.
  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inline(__always)
  public init<T : BinaryInteger>(_ source: T) {
    // This check is potentially removable by the optimizer
    if T.isSigned && source.bitWidth > Self.bitWidth {
      _precondition(source >= Self.min,
        "Not enough bits to represent a signed value")
    }
    // This check is potentially removable by the optimizer
    if (source.bitWidth > Self.bitWidth) ||
       (source.bitWidth == Self.bitWidth && !T.isSigned) {
      _precondition(source <= Self.max,
        "Not enough bits to represent a signed value")
    }
    self.init(truncatingIfNeeded: source)
  }

  /// Creates a new instance from the given integer, if it can be represented
  /// exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `100`, while the attempt to initialize the
  /// constant `y` from `1_000` fails because the `Int8` type can represent
  /// `127` at maximum:
  ///
  ///     let x = Int8(exactly: 100)
  ///     // x == Optional(100)
  ///     let y = Int8(exactly: 1_000)
  ///     // y == nil
  ///
  /// - Parameter source: A value to convert to this type of integer.
  @inlinable // FIXME(sil-serialize-all)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @inline(__always)
  public init?<T : BinaryInteger>(exactly source: T) {
    // This check is potentially removable by the optimizer
    if T.isSigned && source.bitWidth > Self.bitWidth && source < Self.min {
      return nil
    }
    // The width check can be eliminated by the optimizer
    if (source.bitWidth > Self.bitWidth ||
        (source.bitWidth == Self.bitWidth && !T.isSigned)) &&
       source > Self.max {
      return nil
    }
    self.init(truncatingIfNeeded: source)
  }

  /// The maximum representable integer in this type.
  ///
  /// For signed integer types, this value is `(2 ** (bitWidth - 1)) - 1`,
  /// where `**` is exponentiation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var max: Self {
    return ~min
  }

  /// The minimum representable integer in this type.
  ///
  /// For signed integer types, this value is `-(2 ** (bitWidth - 1))`, where
  /// `**` is exponentiation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var min: Self {
    return (-1 as Self) &<< Self._highBitIndex
  }
}


//===----------------------------------------------------------------------===//
//===--- Concrete FixedWidthIntegers --------------------------------------===//
//===----------------------------------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3114)
/// An 8-bit unsigned integer value
/// type.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct UInt8
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt8


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_u_checked_trunc_Int2048_Int8(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: Int8) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt8 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt8 because the result would be less than UInt8.min")
    _precondition(source < 256.0,
      "Float value cannot be converted to UInt8 because the result would be greater than UInt8.max")
    self._value = Builtin.fptoui_FPIEEE32_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptoui_FPIEEE32_Int8(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt8 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt8 because the result would be less than UInt8.min")
    _precondition(source < 256.0,
      "Double value cannot be converted to UInt8 because the result would be greater than UInt8.max")
    self._value = Builtin.fptoui_FPIEEE64_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptoui_FPIEEE64_Int8(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt8 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt8 because the result would be less than UInt8.min")
    _precondition(source < 256.0,
      "Float80 value cannot be converted to UInt8 because the result would be greater than UInt8.max")
    self._value = Builtin.fptoui_FPIEEE80_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptoui_FPIEEE80_Int8(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: UInt8, rhs: UInt8) -> Bool {
    return Bool(Builtin.cmp_eq_Int8(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: UInt8, rhs: UInt8) -> Bool {
    return Bool(Builtin.cmp_ult_Int8(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout UInt8, _ rhs: UInt8) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt8(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout UInt8, _ rhs: UInt8) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt8(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout UInt8, _ rhs: UInt8) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt8(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout UInt8, _ rhs: UInt8) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt8)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.udiv_Int8(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt8(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt8)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.udiv_Int8(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt8)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.urem_Int8(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt8
  ) -> (partialValue: UInt8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout UInt8, _ rhs: UInt8) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt8)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.urem_Int8(lhs._value, rhs._value),
      false._value)
    lhs = UInt8(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int8) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout UInt8, _ rhs: UInt8) {
    lhs = UInt8(Builtin.and_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout UInt8, _ rhs: UInt8) {
    lhs = UInt8(Builtin.or_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout UInt8, _ rhs: UInt8) {
    lhs = UInt8(Builtin.xor_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout UInt8, _ rhs: UInt8) {
    let rhs_ = rhs & 7
    lhs = UInt8(
      Builtin.lshr_Int8(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout UInt8, _ rhs: UInt8) {
    let rhs_ = rhs & 7
    lhs = UInt8(
      Builtin.shl_Int8(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3368)
  /// The bit width of an `UInt8` instance is 8.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 8 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt8(
        Builtin.int_ctlz_Int8(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt8(
        Builtin.int_cttz_Int8(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt8(
        Builtin.int_ctpop_Int8(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt8.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: UInt8

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: UInt8) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (8 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt8(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.zextOrBitCast_Int8_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int8(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt8

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: UInt8)
    -> (high: UInt8, low: UInt8.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.zext_Int8_Int16(self._value)
    let rhs_ = Builtin.zext_Int8_Int16(other._value)

    let res = Builtin.mul_Int16(lhs_, rhs_)
    let low = UInt8.Magnitude(Builtin.truncOrBitCast_Int16_Int8(res))
    let shift = Builtin.zextOrBitCast_Int8_Int16(UInt8(8)._value)
    let shifted = Builtin.ashr_Int16(res, shift)
    let high = UInt8(Builtin.truncOrBitCast_Int16_Int8(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: UInt8, low: UInt8.Magnitude)
  ) -> (quotient: UInt8, remainder: UInt8) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int8_Int16(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int16(UInt8(8)._value)
    let lhsHighShifted = Builtin.shl_Int16(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int8_Int16(dividend.low._value)
    let lhs_ = Builtin.or_Int16(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int8_Int16(self._value)

    let quotient_ = Builtin.udiv_Int16(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int16(lhs_, rhs_)

    let quotient = UInt8(
      Builtin.truncOrBitCast_Int16_Int8(quotient_))
    let remainder = UInt8(
      Builtin.truncOrBitCast_Int16_Int8(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: UInt8 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3633)
    return self
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int8

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt8 { return 8 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt8 { return 8/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> UInt8 {
    let isPositive = UInt8(Builtin.zext_Int1_Int8(
      (self > (0 as UInt8))._value))
    return isPositive | (self &>> 7)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension UInt8 : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<UInt8> outside a generic context.  See
// Range.swift for details.
extension UInt8 {
  public typealias _DisabledRangeIndex = UInt8
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt16) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int16_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int16) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int16_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt32) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int32_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int32) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int32_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt8 {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: UInt8, _ rhs: UInt8) -> UInt8 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt8, rhs: UInt8
  ) -> UInt8 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt8, rhs: UInt8
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt8, rhs: UInt8
  ) -> UInt8 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt8, rhs: UInt8
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: UInt8, rhs: UInt8) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: UInt8, rhs: UInt8) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: UInt8, rhs: UInt8) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: UInt8, rhs: UInt8) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3114)
/// An 8-bit signed integer value
/// type.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct Int8
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int8


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_s_checked_trunc_Int2048_Int8(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: UInt8) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int8 because it is either infinite or NaN")
    _precondition(source > -129.0,
      "Float value cannot be converted to Int8 because the result would be less than Int8.min")
    _precondition(source < 128.0,
      "Float value cannot be converted to Int8 because the result would be greater than Int8.max")
    self._value = Builtin.fptosi_FPIEEE32_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptosi_FPIEEE32_Int8(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int8 because it is either infinite or NaN")
    _precondition(source > -129.0,
      "Double value cannot be converted to Int8 because the result would be less than Int8.min")
    _precondition(source < 128.0,
      "Double value cannot be converted to Int8 because the result would be greater than Int8.max")
    self._value = Builtin.fptosi_FPIEEE64_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptosi_FPIEEE64_Int8(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int8 because it is either infinite or NaN")
    _precondition(source > -129.0,
      "Float80 value cannot be converted to Int8 because the result would be less than Int8.min")
    _precondition(source < 128.0,
      "Float80 value cannot be converted to Int8 because the result would be greater than Int8.max")
    self._value = Builtin.fptosi_FPIEEE80_Int8(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptosi_FPIEEE80_Int8(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: Int8, rhs: Int8) -> Bool {
    return Bool(Builtin.cmp_eq_Int8(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: Int8, rhs: Int8) -> Bool {
    return Bool(Builtin.cmp_slt_Int8(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout Int8, _ rhs: Int8) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int8(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout Int8, _ rhs: Int8) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int8(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout Int8, _ rhs: Int8) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int8(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int8(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout Int8, _ rhs: Int8) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int8)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3252)
    if _slowPath(
      lhs == Int8.min && rhs == (-1 as Int8)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.sdiv_Int8(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int8(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int8)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int8.min && other == (-1 as Int8)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int8(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int8)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int8.min && other == (-1 as Int8)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.srem_Int8(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: Int8
  ) -> (partialValue: Int8, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int8(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int8(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout Int8, _ rhs: Int8) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int8)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3321)
    if _slowPath(lhs == Int8.min && rhs == (-1 as Int8)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.srem_Int8(lhs._value, rhs._value),
      false._value)
    lhs = Int8(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int8) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout Int8, _ rhs: Int8) {
    lhs = Int8(Builtin.and_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout Int8, _ rhs: Int8) {
    lhs = Int8(Builtin.or_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout Int8, _ rhs: Int8) {
    lhs = Int8(Builtin.xor_Int8(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout Int8, _ rhs: Int8) {
    let rhs_ = rhs & 7
    lhs = Int8(
      Builtin.ashr_Int8(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout Int8, _ rhs: Int8) {
    let rhs_ = rhs & 7
    lhs = Int8(
      Builtin.shl_Int8(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3368)
  /// The bit width of an `Int8` instance is 8.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 8 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int8(
        Builtin.int_ctlz_Int8(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int8(
        Builtin.int_cttz_Int8(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int8(
        Builtin.int_ctpop_Int8(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int8.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: Int8

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: Int8) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (8 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int8(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3476)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.sextOrBitCast_Int8_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int8(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt8

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3510)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var magnitude: UInt8 {
    let base = UInt8(_value)
    return self < (0 as Int8) ? ~base + 1 : base
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: Int8)
    -> (high: Int8, low: Int8.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.sext_Int8_Int16(self._value)
    let rhs_ = Builtin.sext_Int8_Int16(other._value)

    let res = Builtin.mul_Int16(lhs_, rhs_)
    let low = Int8.Magnitude(Builtin.truncOrBitCast_Int16_Int8(res))
    let shift = Builtin.zextOrBitCast_Int8_Int16(UInt8(8)._value)
    let shifted = Builtin.ashr_Int16(res, shift)
    let high = Int8(Builtin.truncOrBitCast_Int16_Int8(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: Int8, low: Int8.Magnitude)
  ) -> (quotient: Int8, remainder: Int8) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int8_Int16(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int16(UInt8(8)._value)
    let lhsHighShifted = Builtin.shl_Int16(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int8_Int16(dividend.low._value)
    let lhs_ = Builtin.or_Int16(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int8_Int16(self._value)

    let quotient_ = Builtin.sdiv_Int16(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int16(lhs_, rhs_)

    let quotient = Int8(
      Builtin.truncOrBitCast_Int16_Int8(quotient_))
    let remainder = Int8(
      Builtin.truncOrBitCast_Int16_Int8(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: Int8 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3633)
    return self
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int8

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int8 { return 8 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int8 { return 8/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> Int8 {
    let isPositive = Int8(Builtin.zext_Int1_Int8(
      (self > (0 as Int8))._value))
    return isPositive | (self &>> 7)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension Int8 : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<Int8> outside a generic context.  See
// Range.swift for details.
extension Int8 {
  public typealias _DisabledRangeIndex = Int8
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt16) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int16_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int16) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int16_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt32) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int32_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int32) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int32_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int8 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int8(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int8 {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: Int8, _ rhs: Int8) -> Int8 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int8, rhs: Int8
  ) -> Int8 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int8, rhs: Int8
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int8, rhs: Int8
  ) -> Int8 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int8, rhs: Int8
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: Int8, rhs: Int8) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: Int8, rhs: Int8) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: Int8, rhs: Int8) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: Int8, rhs: Int8) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3848)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@inlinable // FIXME(sil-serialize-all)
@_transparent
public func _assumeNonNegative(_ x: Int8) -> Int8 {
  _sanityCheck(x >= (0 as Int8))
  return Int8(Builtin.assumeNonNegative_Int8(x._value))
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3114)
/// A 16-bit unsigned integer value
/// type.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct UInt16
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt16


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_u_checked_trunc_Int2048_Int16(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: Int16) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt16 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt16 because the result would be less than UInt16.min")
    _precondition(source < 65536.0,
      "Float value cannot be converted to UInt16 because the result would be greater than UInt16.max")
    self._value = Builtin.fptoui_FPIEEE32_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptoui_FPIEEE32_Int16(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt16 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt16 because the result would be less than UInt16.min")
    _precondition(source < 65536.0,
      "Double value cannot be converted to UInt16 because the result would be greater than UInt16.max")
    self._value = Builtin.fptoui_FPIEEE64_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptoui_FPIEEE64_Int16(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt16 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt16 because the result would be less than UInt16.min")
    _precondition(source < 65536.0,
      "Float80 value cannot be converted to UInt16 because the result would be greater than UInt16.max")
    self._value = Builtin.fptoui_FPIEEE80_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptoui_FPIEEE80_Int16(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: UInt16, rhs: UInt16) -> Bool {
    return Bool(Builtin.cmp_eq_Int16(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: UInt16, rhs: UInt16) -> Bool {
    return Bool(Builtin.cmp_ult_Int16(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout UInt16, _ rhs: UInt16) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt16(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout UInt16, _ rhs: UInt16) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt16(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout UInt16, _ rhs: UInt16) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt16(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout UInt16, _ rhs: UInt16) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt16)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.udiv_Int16(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt16(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt16)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.udiv_Int16(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt16)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.urem_Int16(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt16
  ) -> (partialValue: UInt16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout UInt16, _ rhs: UInt16) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt16)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.urem_Int16(lhs._value, rhs._value),
      false._value)
    lhs = UInt16(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int16) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout UInt16, _ rhs: UInt16) {
    lhs = UInt16(Builtin.and_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout UInt16, _ rhs: UInt16) {
    lhs = UInt16(Builtin.or_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout UInt16, _ rhs: UInt16) {
    lhs = UInt16(Builtin.xor_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout UInt16, _ rhs: UInt16) {
    let rhs_ = rhs & 15
    lhs = UInt16(
      Builtin.lshr_Int16(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout UInt16, _ rhs: UInt16) {
    let rhs_ = rhs & 15
    lhs = UInt16(
      Builtin.shl_Int16(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3368)
  /// The bit width of a `UInt16` instance is 16.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 16 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt16(
        Builtin.int_ctlz_Int16(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt16(
        Builtin.int_cttz_Int16(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt16(
        Builtin.int_ctpop_Int16(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt16.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: UInt16

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: UInt16) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (16 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt16(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.zextOrBitCast_Int16_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int16(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt16

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: UInt16)
    -> (high: UInt16, low: UInt16.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.zext_Int16_Int32(self._value)
    let rhs_ = Builtin.zext_Int16_Int32(other._value)

    let res = Builtin.mul_Int32(lhs_, rhs_)
    let low = UInt16.Magnitude(Builtin.truncOrBitCast_Int32_Int16(res))
    let shift = Builtin.zextOrBitCast_Int8_Int32(UInt8(16)._value)
    let shifted = Builtin.ashr_Int32(res, shift)
    let high = UInt16(Builtin.truncOrBitCast_Int32_Int16(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: UInt16, low: UInt16.Magnitude)
  ) -> (quotient: UInt16, remainder: UInt16) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int16_Int32(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int32(UInt8(16)._value)
    let lhsHighShifted = Builtin.shl_Int32(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int16_Int32(dividend.low._value)
    let lhs_ = Builtin.or_Int32(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int16_Int32(self._value)

    let quotient_ = Builtin.udiv_Int32(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int32(lhs_, rhs_)

    let quotient = UInt16(
      Builtin.truncOrBitCast_Int32_Int16(quotient_))
    let remainder = UInt16(
      Builtin.truncOrBitCast_Int32_Int16(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: UInt16 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3635)
    return UInt16(Builtin.int_bswap_Int16(_value))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int16

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt16 { return 16 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt16 { return 16/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> UInt16 {
    let isPositive = UInt16(Builtin.zext_Int1_Int16(
      (self > (0 as UInt16))._value))
    return isPositive | (self &>> 15)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension UInt16 : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<UInt16> outside a generic context.  See
// Range.swift for details.
extension UInt16 {
  public typealias _DisabledRangeIndex = UInt16
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt32) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int32_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int32) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int32_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt16 {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: UInt16, _ rhs: UInt16) -> UInt16 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt16, rhs: UInt16
  ) -> UInt16 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt16, rhs: UInt16
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt16, rhs: UInt16
  ) -> UInt16 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt16, rhs: UInt16
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: UInt16, rhs: UInt16) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: UInt16, rhs: UInt16) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: UInt16, rhs: UInt16) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: UInt16, rhs: UInt16) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3114)
/// A 16-bit signed integer value
/// type.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct Int16
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int16


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_s_checked_trunc_Int2048_Int16(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: UInt16) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int16 because it is either infinite or NaN")
    _precondition(source > -32769.0,
      "Float value cannot be converted to Int16 because the result would be less than Int16.min")
    _precondition(source < 32768.0,
      "Float value cannot be converted to Int16 because the result would be greater than Int16.max")
    self._value = Builtin.fptosi_FPIEEE32_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptosi_FPIEEE32_Int16(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int16 because it is either infinite or NaN")
    _precondition(source > -32769.0,
      "Double value cannot be converted to Int16 because the result would be less than Int16.min")
    _precondition(source < 32768.0,
      "Double value cannot be converted to Int16 because the result would be greater than Int16.max")
    self._value = Builtin.fptosi_FPIEEE64_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptosi_FPIEEE64_Int16(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int16 because it is either infinite or NaN")
    _precondition(source > -32769.0,
      "Float80 value cannot be converted to Int16 because the result would be less than Int16.min")
    _precondition(source < 32768.0,
      "Float80 value cannot be converted to Int16 because the result would be greater than Int16.max")
    self._value = Builtin.fptosi_FPIEEE80_Int16(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptosi_FPIEEE80_Int16(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: Int16, rhs: Int16) -> Bool {
    return Bool(Builtin.cmp_eq_Int16(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: Int16, rhs: Int16) -> Bool {
    return Bool(Builtin.cmp_slt_Int16(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout Int16, _ rhs: Int16) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int16(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout Int16, _ rhs: Int16) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int16(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout Int16, _ rhs: Int16) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int16(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int16(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout Int16, _ rhs: Int16) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int16)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3252)
    if _slowPath(
      lhs == Int16.min && rhs == (-1 as Int16)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.sdiv_Int16(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int16(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int16)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int16.min && other == (-1 as Int16)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int16(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int16)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int16.min && other == (-1 as Int16)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.srem_Int16(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: Int16
  ) -> (partialValue: Int16, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int16(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int16(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout Int16, _ rhs: Int16) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int16)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3321)
    if _slowPath(lhs == Int16.min && rhs == (-1 as Int16)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.srem_Int16(lhs._value, rhs._value),
      false._value)
    lhs = Int16(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int16) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout Int16, _ rhs: Int16) {
    lhs = Int16(Builtin.and_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout Int16, _ rhs: Int16) {
    lhs = Int16(Builtin.or_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout Int16, _ rhs: Int16) {
    lhs = Int16(Builtin.xor_Int16(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout Int16, _ rhs: Int16) {
    let rhs_ = rhs & 15
    lhs = Int16(
      Builtin.ashr_Int16(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout Int16, _ rhs: Int16) {
    let rhs_ = rhs & 15
    lhs = Int16(
      Builtin.shl_Int16(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3368)
  /// The bit width of a `Int16` instance is 16.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 16 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int16(
        Builtin.int_ctlz_Int16(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int16(
        Builtin.int_cttz_Int16(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int16(
        Builtin.int_ctpop_Int16(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int16.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: Int16

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: Int16) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (16 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int16(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3476)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.sextOrBitCast_Int16_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int16(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt16

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3510)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var magnitude: UInt16 {
    let base = UInt16(_value)
    return self < (0 as Int16) ? ~base + 1 : base
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: Int16)
    -> (high: Int16, low: Int16.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.sext_Int16_Int32(self._value)
    let rhs_ = Builtin.sext_Int16_Int32(other._value)

    let res = Builtin.mul_Int32(lhs_, rhs_)
    let low = Int16.Magnitude(Builtin.truncOrBitCast_Int32_Int16(res))
    let shift = Builtin.zextOrBitCast_Int8_Int32(UInt8(16)._value)
    let shifted = Builtin.ashr_Int32(res, shift)
    let high = Int16(Builtin.truncOrBitCast_Int32_Int16(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: Int16, low: Int16.Magnitude)
  ) -> (quotient: Int16, remainder: Int16) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int16_Int32(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int32(UInt8(16)._value)
    let lhsHighShifted = Builtin.shl_Int32(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int16_Int32(dividend.low._value)
    let lhs_ = Builtin.or_Int32(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int16_Int32(self._value)

    let quotient_ = Builtin.sdiv_Int32(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int32(lhs_, rhs_)

    let quotient = Int16(
      Builtin.truncOrBitCast_Int32_Int16(quotient_))
    let remainder = Int16(
      Builtin.truncOrBitCast_Int32_Int16(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: Int16 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3635)
    return Int16(Builtin.int_bswap_Int16(_value))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int16

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int16 { return 16 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int16 { return 16/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> Int16 {
    let isPositive = Int16(Builtin.zext_Int1_Int16(
      (self > (0 as Int16))._value))
    return isPositive | (self &>> 15)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension Int16 : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<Int16> outside a generic context.  See
// Range.swift for details.
extension Int16 {
  public typealias _DisabledRangeIndex = Int16
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt32) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int32_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int32) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int32_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int16 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int16(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int16 {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: Int16, _ rhs: Int16) -> Int16 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int16, rhs: Int16
  ) -> Int16 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int16, rhs: Int16
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int16, rhs: Int16
  ) -> Int16 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int16, rhs: Int16
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: Int16, rhs: Int16) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: Int16, rhs: Int16) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: Int16, rhs: Int16) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: Int16, rhs: Int16) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3848)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@inlinable // FIXME(sil-serialize-all)
@_transparent
public func _assumeNonNegative(_ x: Int16) -> Int16 {
  _sanityCheck(x >= (0 as Int16))
  return Int16(Builtin.assumeNonNegative_Int16(x._value))
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3114)
/// A 32-bit unsigned integer value
/// type.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct UInt32
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt32


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_u_checked_trunc_Int2048_Int32(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: Int32) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt32 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt32 because the result would be less than UInt32.min")
    _precondition(source < 4294967296.0,
      "Float value cannot be converted to UInt32 because the result would be greater than UInt32.max")
    self._value = Builtin.fptoui_FPIEEE32_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptoui_FPIEEE32_Int32(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt32 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt32 because the result would be less than UInt32.min")
    _precondition(source < 4294967296.0,
      "Double value cannot be converted to UInt32 because the result would be greater than UInt32.max")
    self._value = Builtin.fptoui_FPIEEE64_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptoui_FPIEEE64_Int32(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt32 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt32 because the result would be less than UInt32.min")
    _precondition(source < 4294967296.0,
      "Float80 value cannot be converted to UInt32 because the result would be greater than UInt32.max")
    self._value = Builtin.fptoui_FPIEEE80_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptoui_FPIEEE80_Int32(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: UInt32, rhs: UInt32) -> Bool {
    return Bool(Builtin.cmp_eq_Int32(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: UInt32, rhs: UInt32) -> Bool {
    return Bool(Builtin.cmp_ult_Int32(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout UInt32, _ rhs: UInt32) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt32(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout UInt32, _ rhs: UInt32) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt32(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout UInt32, _ rhs: UInt32) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt32(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout UInt32, _ rhs: UInt32) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt32)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.udiv_Int32(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt32(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt32)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.udiv_Int32(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt32)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.urem_Int32(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt32
  ) -> (partialValue: UInt32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout UInt32, _ rhs: UInt32) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt32)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.urem_Int32(lhs._value, rhs._value),
      false._value)
    lhs = UInt32(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int32) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout UInt32, _ rhs: UInt32) {
    lhs = UInt32(Builtin.and_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout UInt32, _ rhs: UInt32) {
    lhs = UInt32(Builtin.or_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout UInt32, _ rhs: UInt32) {
    lhs = UInt32(Builtin.xor_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout UInt32, _ rhs: UInt32) {
    let rhs_ = rhs & 31
    lhs = UInt32(
      Builtin.lshr_Int32(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout UInt32, _ rhs: UInt32) {
    let rhs_ = rhs & 31
    lhs = UInt32(
      Builtin.shl_Int32(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3368)
  /// The bit width of a `UInt32` instance is 32.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 32 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt32(
        Builtin.int_ctlz_Int32(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt32(
        Builtin.int_cttz_Int32(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt32(
        Builtin.int_ctpop_Int32(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt32.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: UInt32

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: UInt32) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (32 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt32(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.zextOrBitCast_Int32_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int32(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: UInt32)
    -> (high: UInt32, low: UInt32.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.zext_Int32_Int64(self._value)
    let rhs_ = Builtin.zext_Int32_Int64(other._value)

    let res = Builtin.mul_Int64(lhs_, rhs_)
    let low = UInt32.Magnitude(Builtin.truncOrBitCast_Int64_Int32(res))
    let shift = Builtin.zextOrBitCast_Int8_Int64(UInt8(32)._value)
    let shifted = Builtin.ashr_Int64(res, shift)
    let high = UInt32(Builtin.truncOrBitCast_Int64_Int32(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: UInt32, low: UInt32.Magnitude)
  ) -> (quotient: UInt32, remainder: UInt32) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int32_Int64(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int64(UInt8(32)._value)
    let lhsHighShifted = Builtin.shl_Int64(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int32_Int64(dividend.low._value)
    let lhs_ = Builtin.or_Int64(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int32_Int64(self._value)

    let quotient_ = Builtin.udiv_Int64(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int64(lhs_, rhs_)

    let quotient = UInt32(
      Builtin.truncOrBitCast_Int64_Int32(quotient_))
    let remainder = UInt32(
      Builtin.truncOrBitCast_Int64_Int32(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: UInt32 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3635)
    return UInt32(Builtin.int_bswap_Int32(_value))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt32 { return 32 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt32 { return 32/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> UInt32 {
    let isPositive = UInt32(Builtin.zext_Int1_Int32(
      (self > (0 as UInt32))._value))
    return isPositive | (self &>> 31)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension UInt32 : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<UInt32> outside a generic context.  See
// Range.swift for details.
extension UInt32 {
  public typealias _DisabledRangeIndex = UInt32
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt32 {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: UInt32, _ rhs: UInt32) -> UInt32 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt32, rhs: UInt32
  ) -> UInt32 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt32, rhs: UInt32
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt32, rhs: UInt32
  ) -> UInt32 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt32, rhs: UInt32
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: UInt32, rhs: UInt32) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: UInt32, rhs: UInt32) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: UInt32, rhs: UInt32) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: UInt32, rhs: UInt32) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3114)
/// A 32-bit signed integer value
/// type.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct Int32
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int32


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_s_checked_trunc_Int2048_Int32(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: UInt32) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3150)
  @available(*, unavailable,
    message: "Please use Int32(bitPattern: UInt32) in combination with Float.bitPattern property.")
  public init(bitPattern x: Float) {
    Builtin.unreachable()
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int32 because it is either infinite or NaN")
    _precondition(source > -2147483904.0,
      "Float value cannot be converted to Int32 because the result would be less than Int32.min")
    _precondition(source < 2147483648.0,
      "Float value cannot be converted to Int32 because the result would be greater than Int32.max")
    self._value = Builtin.fptosi_FPIEEE32_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptosi_FPIEEE32_Int32(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int32 because it is either infinite or NaN")
    _precondition(source > -2147483649.0,
      "Double value cannot be converted to Int32 because the result would be less than Int32.min")
    _precondition(source < 2147483648.0,
      "Double value cannot be converted to Int32 because the result would be greater than Int32.max")
    self._value = Builtin.fptosi_FPIEEE64_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptosi_FPIEEE64_Int32(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int32 because it is either infinite or NaN")
    _precondition(source > -2147483649.0,
      "Float80 value cannot be converted to Int32 because the result would be less than Int32.min")
    _precondition(source < 2147483648.0,
      "Float80 value cannot be converted to Int32 because the result would be greater than Int32.max")
    self._value = Builtin.fptosi_FPIEEE80_Int32(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptosi_FPIEEE80_Int32(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: Int32, rhs: Int32) -> Bool {
    return Bool(Builtin.cmp_eq_Int32(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: Int32, rhs: Int32) -> Bool {
    return Bool(Builtin.cmp_slt_Int32(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout Int32, _ rhs: Int32) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int32(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout Int32, _ rhs: Int32) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int32(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout Int32, _ rhs: Int32) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int32(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int32(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout Int32, _ rhs: Int32) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int32)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3252)
    if _slowPath(
      lhs == Int32.min && rhs == (-1 as Int32)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.sdiv_Int32(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int32(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int32)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int32.min && other == (-1 as Int32)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int32(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int32)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int32.min && other == (-1 as Int32)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.srem_Int32(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: Int32
  ) -> (partialValue: Int32, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int32(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int32(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout Int32, _ rhs: Int32) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int32)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3321)
    if _slowPath(lhs == Int32.min && rhs == (-1 as Int32)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.srem_Int32(lhs._value, rhs._value),
      false._value)
    lhs = Int32(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int32) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout Int32, _ rhs: Int32) {
    lhs = Int32(Builtin.and_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout Int32, _ rhs: Int32) {
    lhs = Int32(Builtin.or_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout Int32, _ rhs: Int32) {
    lhs = Int32(Builtin.xor_Int32(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout Int32, _ rhs: Int32) {
    let rhs_ = rhs & 31
    lhs = Int32(
      Builtin.ashr_Int32(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout Int32, _ rhs: Int32) {
    let rhs_ = rhs & 31
    lhs = Int32(
      Builtin.shl_Int32(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3368)
  /// The bit width of a `Int32` instance is 32.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 32 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int32(
        Builtin.int_ctlz_Int32(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int32(
        Builtin.int_cttz_Int32(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int32(
        Builtin.int_ctpop_Int32(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int32.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: Int32

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: Int32) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (32 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int32(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3476)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.sextOrBitCast_Int32_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int32(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3510)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var magnitude: UInt32 {
    let base = UInt32(_value)
    return self < (0 as Int32) ? ~base + 1 : base
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: Int32)
    -> (high: Int32, low: Int32.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.sext_Int32_Int64(self._value)
    let rhs_ = Builtin.sext_Int32_Int64(other._value)

    let res = Builtin.mul_Int64(lhs_, rhs_)
    let low = Int32.Magnitude(Builtin.truncOrBitCast_Int64_Int32(res))
    let shift = Builtin.zextOrBitCast_Int8_Int64(UInt8(32)._value)
    let shifted = Builtin.ashr_Int64(res, shift)
    let high = Int32(Builtin.truncOrBitCast_Int64_Int32(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: Int32, low: Int32.Magnitude)
  ) -> (quotient: Int32, remainder: Int32) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int32_Int64(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int64(UInt8(32)._value)
    let lhsHighShifted = Builtin.shl_Int64(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int32_Int64(dividend.low._value)
    let lhs_ = Builtin.or_Int64(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int32_Int64(self._value)

    let quotient_ = Builtin.sdiv_Int64(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int64(lhs_, rhs_)

    let quotient = Int32(
      Builtin.truncOrBitCast_Int64_Int32(quotient_))
    let remainder = Int32(
      Builtin.truncOrBitCast_Int64_Int32(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: Int32 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3635)
    return Int32(Builtin.int_bswap_Int32(_value))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int32

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int32 { return 32 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int32 { return 32/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> Int32 {
    let isPositive = Int32(Builtin.zext_Int1_Int32(
      (self > (0 as Int32))._value))
    return isPositive | (self &>> 31)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension Int32 : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<Int32> outside a generic context.  See
// Range.swift for details.
extension Int32 {
  public typealias _DisabledRangeIndex = Int32
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int32 {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3765)
    let dstNotWord = Builtin.trunc_Int64_Int32(src)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int32 {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: Int32, _ rhs: Int32) -> Int32 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int32, rhs: Int32
  ) -> Int32 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int32, rhs: Int32
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int32, rhs: Int32
  ) -> Int32 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int32, rhs: Int32
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: Int32, rhs: Int32) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: Int32, rhs: Int32) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: Int32, rhs: Int32) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: Int32, rhs: Int32) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3848)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@inlinable // FIXME(sil-serialize-all)
@_transparent
public func _assumeNonNegative(_ x: Int32) -> Int32 {
  _sanityCheck(x >= (0 as Int32))
  return Int32(Builtin.assumeNonNegative_Int32(x._value))
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3114)
/// A 64-bit unsigned integer value
/// type.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct UInt64
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt64


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_u_checked_trunc_Int2048_Int64(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: Int64) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt64 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt64 because the result would be less than UInt64.min")
    _precondition(source < 18446744073709551616.0,
      "Float value cannot be converted to UInt64 because the result would be greater than UInt64.max")
    self._value = Builtin.fptoui_FPIEEE32_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptoui_FPIEEE32_Int64(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt64 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt64 because the result would be less than UInt64.min")
    _precondition(source < 18446744073709551616.0,
      "Double value cannot be converted to UInt64 because the result would be greater than UInt64.max")
    self._value = Builtin.fptoui_FPIEEE64_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptoui_FPIEEE64_Int64(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt64 because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt64 because the result would be less than UInt64.min")
    _precondition(source < 18446744073709551616.0,
      "Float80 value cannot be converted to UInt64 because the result would be greater than UInt64.max")
    self._value = Builtin.fptoui_FPIEEE80_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptoui_FPIEEE80_Int64(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: UInt64, rhs: UInt64) -> Bool {
    return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: UInt64, rhs: UInt64) -> Bool {
    return Bool(Builtin.cmp_ult_Int64(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout UInt64, _ rhs: UInt64) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt64(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout UInt64, _ rhs: UInt64) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt64(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout UInt64, _ rhs: UInt64) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt64(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout UInt64, _ rhs: UInt64) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt64)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.udiv_Int64(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt64(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt64)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.udiv_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt64)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.urem_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt64
  ) -> (partialValue: UInt64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout UInt64, _ rhs: UInt64) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt64)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.urem_Int64(lhs._value, rhs._value),
      false._value)
    lhs = UInt64(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int64) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout UInt64, _ rhs: UInt64) {
    lhs = UInt64(Builtin.and_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout UInt64, _ rhs: UInt64) {
    lhs = UInt64(Builtin.or_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout UInt64, _ rhs: UInt64) {
    lhs = UInt64(Builtin.xor_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout UInt64, _ rhs: UInt64) {
    let rhs_ = rhs & 63
    lhs = UInt64(
      Builtin.lshr_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout UInt64, _ rhs: UInt64) {
    let rhs_ = rhs & 63
    lhs = UInt64(
      Builtin.shl_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3368)
  /// The bit width of a `UInt64` instance is 64.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 64 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt64(
        Builtin.int_ctlz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt64(
        Builtin.int_cttz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt64(
        Builtin.int_ctpop_Int64(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt64.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: UInt64

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: UInt64) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (64 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt64(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.zextOrBitCast_Int64_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int64(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt64

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: UInt64)
    -> (high: UInt64, low: UInt64.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.zext_Int64_Int128(self._value)
    let rhs_ = Builtin.zext_Int64_Int128(other._value)

    let res = Builtin.mul_Int128(lhs_, rhs_)
    let low = UInt64.Magnitude(Builtin.truncOrBitCast_Int128_Int64(res))
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let shifted = Builtin.ashr_Int128(res, shift)
    let high = UInt64(Builtin.truncOrBitCast_Int128_Int64(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: UInt64, low: UInt64.Magnitude)
  ) -> (quotient: UInt64, remainder: UInt64) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int64_Int128(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let lhsHighShifted = Builtin.shl_Int128(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int64_Int128(dividend.low._value)
    let lhs_ = Builtin.or_Int128(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int64_Int128(self._value)

    let quotient_ = Builtin.udiv_Int128(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int128(lhs_, rhs_)

    let quotient = UInt64(
      Builtin.truncOrBitCast_Int128_Int64(quotient_))
    let remainder = UInt64(
      Builtin.truncOrBitCast_Int128_Int64(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: UInt64 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3635)
    return UInt64(Builtin.int_bswap_Int64(_value))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int64

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt64 { return 64 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt64 { return 64/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> UInt64 {
    let isPositive = UInt64(Builtin.zext_Int1_Int64(
      (self > (0 as UInt64))._value))
    return isPositive | (self &>> 63)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension UInt64 : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<UInt64> outside a generic context.  See
// Range.swift for details.
extension UInt64 {
  public typealias _DisabledRangeIndex = UInt64
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt64 {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: UInt64, _ rhs: UInt64) -> UInt64 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt64, rhs: UInt64
  ) -> UInt64 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt64, rhs: UInt64
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt64, rhs: UInt64
  ) -> UInt64 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt64, rhs: UInt64
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: UInt64, rhs: UInt64) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: UInt64, rhs: UInt64) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: UInt64, rhs: UInt64) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: UInt64, rhs: UInt64) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3114)
/// A 64-bit signed integer value
/// type.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct Int64
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int64


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_s_checked_trunc_Int2048_Int64(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: UInt64) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3150)
  @available(*, unavailable,
    message: "Please use Int64(bitPattern: UInt64) in combination with Double.bitPattern property.")
  public init(bitPattern x: Double) {
    Builtin.unreachable()
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int64 because it is either infinite or NaN")
    _precondition(source > -9223373136366403584.0,
      "Float value cannot be converted to Int64 because the result would be less than Int64.min")
    _precondition(source < 9223372036854775808.0,
      "Float value cannot be converted to Int64 because the result would be greater than Int64.max")
    self._value = Builtin.fptosi_FPIEEE32_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptosi_FPIEEE32_Int64(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int64 because it is either infinite or NaN")
    _precondition(source > -9223372036854777856.0,
      "Double value cannot be converted to Int64 because the result would be less than Int64.min")
    _precondition(source < 9223372036854775808.0,
      "Double value cannot be converted to Int64 because the result would be greater than Int64.max")
    self._value = Builtin.fptosi_FPIEEE64_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptosi_FPIEEE64_Int64(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int64 because it is either infinite or NaN")
    _precondition(source > -9223372036854775809.0,
      "Float80 value cannot be converted to Int64 because the result would be less than Int64.min")
    _precondition(source < 9223372036854775808.0,
      "Float80 value cannot be converted to Int64 because the result would be greater than Int64.max")
    self._value = Builtin.fptosi_FPIEEE80_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptosi_FPIEEE80_Int64(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: Int64, rhs: Int64) -> Bool {
    return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: Int64, rhs: Int64) -> Bool {
    return Bool(Builtin.cmp_slt_Int64(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout Int64, _ rhs: Int64) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int64(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout Int64, _ rhs: Int64) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int64(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout Int64, _ rhs: Int64) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int64(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout Int64, _ rhs: Int64) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int64)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3252)
    if _slowPath(
      lhs == Int64.min && rhs == (-1 as Int64)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.sdiv_Int64(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int64(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int64)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int64.min && other == (-1 as Int64)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int64)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int64.min && other == (-1 as Int64)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.srem_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: Int64
  ) -> (partialValue: Int64, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int64(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout Int64, _ rhs: Int64) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int64)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3321)
    if _slowPath(lhs == Int64.min && rhs == (-1 as Int64)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.srem_Int64(lhs._value, rhs._value),
      false._value)
    lhs = Int64(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int64) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout Int64, _ rhs: Int64) {
    lhs = Int64(Builtin.and_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout Int64, _ rhs: Int64) {
    lhs = Int64(Builtin.or_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout Int64, _ rhs: Int64) {
    lhs = Int64(Builtin.xor_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout Int64, _ rhs: Int64) {
    let rhs_ = rhs & 63
    lhs = Int64(
      Builtin.ashr_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout Int64, _ rhs: Int64) {
    let rhs_ = rhs & 63
    lhs = Int64(
      Builtin.shl_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3368)
  /// The bit width of a `Int64` instance is 64.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 64 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int64(
        Builtin.int_ctlz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int64(
        Builtin.int_cttz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int64(
        Builtin.int_ctpop_Int64(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int64.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: Int64

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: Int64) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (64 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int64(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3476)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.sextOrBitCast_Int64_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int64(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt64

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3510)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var magnitude: UInt64 {
    let base = UInt64(_value)
    return self < (0 as Int64) ? ~base + 1 : base
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: Int64)
    -> (high: Int64, low: Int64.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.sext_Int64_Int128(self._value)
    let rhs_ = Builtin.sext_Int64_Int128(other._value)

    let res = Builtin.mul_Int128(lhs_, rhs_)
    let low = Int64.Magnitude(Builtin.truncOrBitCast_Int128_Int64(res))
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let shifted = Builtin.ashr_Int128(res, shift)
    let high = Int64(Builtin.truncOrBitCast_Int128_Int64(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: Int64, low: Int64.Magnitude)
  ) -> (quotient: Int64, remainder: Int64) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int64_Int128(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let lhsHighShifted = Builtin.shl_Int128(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int64_Int128(dividend.low._value)
    let lhs_ = Builtin.or_Int128(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int64_Int128(self._value)

    let quotient_ = Builtin.sdiv_Int128(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int128(lhs_, rhs_)

    let quotient = Int64(
      Builtin.truncOrBitCast_Int128_Int64(quotient_))
    let remainder = Int64(
      Builtin.truncOrBitCast_Int128_Int64(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: Int64 {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3635)
    return Int64(Builtin.int_bswap_Int64(_value))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int64

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int64 { return 64 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int64 { return 64/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> Int64 {
    let isPositive = Int64(Builtin.zext_Int1_Int64(
      (self > (0 as Int64))._value))
    return isPositive | (self &>> 63)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension Int64 : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<Int64> outside a generic context.  See
// Range.swift for details.
extension Int64 {
  public typealias _DisabledRangeIndex = Int64
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int64 {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: Int64, _ rhs: Int64) -> Int64 {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int64, rhs: Int64
  ) -> Int64 {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int64, rhs: Int64
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int64, rhs: Int64
  ) -> Int64 {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int64, rhs: Int64
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: Int64, rhs: Int64) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: Int64, rhs: Int64) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: Int64, rhs: Int64) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: Int64, rhs: Int64) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3848)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@inlinable // FIXME(sil-serialize-all)
@_transparent
public func _assumeNonNegative(_ x: Int64) -> Int64 {
  _sanityCheck(x >= (0 as Int64))
  return Int64(Builtin.assumeNonNegative_Int64(x._value))
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3109)
/// An unsigned integer value type.
///
/// On 32-bit platforms, `UInt` is the same size as `UInt32`, and
/// on 64-bit platforms, `UInt` is the same size as `UInt64`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct UInt
  : FixedWidthInteger, UnsignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = UInt


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_u_checked_trunc_Int2048_Int64(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: Int) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to UInt because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float value cannot be converted to UInt because the result would be less than UInt.min")
    _precondition(source < 18446744073709551616.0,
      "Float value cannot be converted to UInt because the result would be greater than UInt.max")
    self._value = Builtin.fptoui_FPIEEE32_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptoui_FPIEEE32_Int64(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to UInt because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Double value cannot be converted to UInt because the result would be less than UInt.min")
    _precondition(source < 18446744073709551616.0,
      "Double value cannot be converted to UInt because the result would be greater than UInt.max")
    self._value = Builtin.fptoui_FPIEEE64_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptoui_FPIEEE64_Int64(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to UInt because it is either infinite or NaN")
    _precondition(source > -1.0,
      "Float80 value cannot be converted to UInt because the result would be less than UInt.min")
    _precondition(source < 18446744073709551616.0,
      "Float80 value cannot be converted to UInt because the result would be greater than UInt.max")
    self._value = Builtin.fptoui_FPIEEE80_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptoui_FPIEEE80_Int64(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: UInt, rhs: UInt) -> Bool {
    return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: UInt, rhs: UInt) -> Bool {
    return Bool(Builtin.cmp_ult_Int64(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout UInt, _ rhs: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.uadd_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout UInt, _ rhs: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.usub_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout UInt, _ rhs: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.umul_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout UInt, _ rhs: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.udiv_Int64(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = UInt(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.udiv_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as UInt)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.urem_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.uadd_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.usub_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: UInt
  ) -> (partialValue: UInt, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.umul_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: UInt(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout UInt, _ rhs: UInt) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as UInt)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.urem_Int64(lhs._value, rhs._value),
      false._value)
    lhs = UInt(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int64) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout UInt, _ rhs: UInt) {
    lhs = UInt(Builtin.and_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout UInt, _ rhs: UInt) {
    lhs = UInt(Builtin.or_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout UInt, _ rhs: UInt) {
    lhs = UInt(Builtin.xor_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout UInt, _ rhs: UInt) {
    let rhs_ = rhs & 63
    lhs = UInt(
      Builtin.lshr_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout UInt, _ rhs: UInt) {
    let rhs_ = rhs & 63
    lhs = UInt(
      Builtin.shl_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3365)
  /// The bit width of a `UInt` instance is 32 on 32-bit
  /// platforms and 64 on 64-bit platforms.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 64 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      UInt(
        Builtin.int_ctlz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      UInt(
        Builtin.int_cttz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      UInt(
        Builtin.int_ctpop_Int64(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<UInt.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: UInt

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: UInt) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (64 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> UInt(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.zextOrBitCast_Int64_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int64(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: UInt)
    -> (high: UInt, low: UInt.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.zext_Int64_Int128(self._value)
    let rhs_ = Builtin.zext_Int64_Int128(other._value)

    let res = Builtin.mul_Int128(lhs_, rhs_)
    let low = UInt.Magnitude(Builtin.truncOrBitCast_Int128_Int64(res))
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let shifted = Builtin.ashr_Int128(res, shift)
    let high = UInt(Builtin.truncOrBitCast_Int128_Int64(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: UInt, low: UInt.Magnitude)
  ) -> (quotient: UInt, remainder: UInt) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.zext_Int64_Int128(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let lhsHighShifted = Builtin.shl_Int128(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int64_Int128(dividend.low._value)
    let lhs_ = Builtin.or_Int128(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.zext_Int64_Int128(self._value)

    let quotient_ = Builtin.udiv_Int128(lhs_, rhs_)
    let remainder_ = Builtin.urem_Int128(lhs_, rhs_)

    let quotient = UInt(
      Builtin.truncOrBitCast_Int128_Int64(quotient_))
    let remainder = UInt(
      Builtin.truncOrBitCast_Int128_Int64(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3635)
    return UInt(Builtin.int_bswap_Int64(_value))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int64

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3644)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // @testable
  init(_ _v: Builtin.Word) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3651)
    self._value = Builtin.zextOrBitCast_Word_Int64(_v)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3653)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // @testable
  var _builtinWordValue: Builtin.Word {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3662)
    return Builtin.truncOrBitCast_Int64_Word(_value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3664)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toIntMax() -> Int64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: UInt { return 64 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: UInt { return 64/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> UInt {
    let isPositive = UInt(Builtin.zext_Int1_Int64(
      (self > (0 as UInt))._value))
    return isPositive | (self &>> 63)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension UInt : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<UInt> outside a generic context.  See
// Range.swift for details.
extension UInt {
  public typealias _DisabledRangeIndex = UInt
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3763)
    let dstNotWord = src
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension UInt {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3763)
    let dstNotWord = src
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension UInt {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: UInt, _ rhs: UInt) -> UInt {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: UInt, rhs: UInt
  ) -> UInt {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout UInt, rhs: UInt
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: UInt, rhs: UInt
  ) -> UInt {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout UInt, rhs: UInt
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: UInt, rhs: UInt) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: UInt, rhs: UInt) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: UInt, rhs: UInt) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: UInt, rhs: UInt) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3106)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3109)
/// A signed integer value type.
///
/// On 32-bit platforms, `Int` is the same size as `Int32`, and
/// on 64-bit platforms, `Int` is the same size as `Int64`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3117)
@_fixed_layout
public struct Int
  : FixedWidthInteger, SignedInteger,
    _ExpressibleByBuiltinIntegerLiteral {

  /// A type that represents an integer literal.
  public typealias IntegerLiteralType = Int


  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_builtinIntegerLiteral x: _MaxBuiltinIntegerType) {
    _value = Builtin.s_to_s_checked_trunc_Int2048_Int64(x).0
  }

  /// Creates a new instance with the same memory representation as the given
  /// value.
  ///
  /// This initializer does not perform any range or overflow checking. The
  /// resulting instance may not have the same numeric value as
  /// `bitPattern`---it is only guaranteed to use the same pattern of bits in
  /// its binary representation.
  ///
  /// - Parameter x: A value to use as the source of the new instance's binary
  ///   representation.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(bitPattern x: UInt) {
    _value = x._value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3156)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float) {
    _precondition(source.isFinite,
      "Float value cannot be converted to Int because it is either infinite or NaN")
    _precondition(source > -9223373136366403584.0,
      "Float value cannot be converted to Int because the result would be less than Int.min")
    _precondition(source < 9223372036854775808.0,
      "Float value cannot be converted to Int because the result would be greater than Int.max")
    self._value = Builtin.fptosi_FPIEEE32_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float) {
    self._value = Builtin.fptosi_FPIEEE32_Int64(source._value)
    if Float(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Double) {
    _precondition(source.isFinite,
      "Double value cannot be converted to Int because it is either infinite or NaN")
    _precondition(source > -9223372036854777856.0,
      "Double value cannot be converted to Int because the result would be less than Int.min")
    _precondition(source < 9223372036854775808.0,
      "Double value cannot be converted to Int because the result would be greater than Int.max")
    self._value = Builtin.fptosi_FPIEEE64_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Double) {
    self._value = Builtin.fptosi_FPIEEE64_Int64(source._value)
    if Double(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3160)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3162)
#if !os(Windows) && (arch(i386) || arch(x86_64))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3164)

  /// Creates an integer from the given floating-point value, rounding toward
  /// zero.
  ///
  /// Any fractional part of the value passed as `source` is removed, rounding
  /// the value toward zero.
  ///
  ///     let x = Int(21.5)
  ///     // x == 21
  ///     let y = Int(-21.5)
  ///     // y == -21
  ///
  /// If `source` is outside the bounds of this type after rounding toward
  /// zero, a runtime error may occur.
  ///
  ///     let z = UInt(-21.5)
  ///     // Error: ...the result would be less than UInt.min
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  ///   `source` must be representable in this type after rounding toward
  ///   zero.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ source: Float80) {
    _precondition(source.isFinite,
      "Float80 value cannot be converted to Int because it is either infinite or NaN")
    _precondition(source > -9223372036854775809.0,
      "Float80 value cannot be converted to Int because the result would be less than Int.min")
    _precondition(source < 9223372036854775808.0,
      "Float80 value cannot be converted to Int because the result would be greater than Int.max")
    self._value = Builtin.fptosi_FPIEEE80_Int64(source._value)
  }

  /// Creates an integer from the given floating-point value, if it can be
  /// represented exactly.
  ///
  /// If the value passed as `source` is not representable exactly, the result
  /// is `nil`. In the following example, the constant `x` is successfully
  /// created from a value of `21.0`, while the attempt to initialize the
  /// constant `y` from `21.5` fails:
  ///
  ///     let x = Int(exactly: 21.0)
  ///     // x == Optional(21)
  ///     let y = Int(exactly: 21.5)
  ///     // y == nil
  ///
  /// - Parameter source: A floating-point value to convert to an integer.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init?(exactly source: Float80) {
    self._value = Builtin.fptosi_FPIEEE80_Int64(source._value)
    if Float80(self) != source {
      return nil
    }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3221)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3223)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3225)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func == (lhs: Int, rhs: Int) -> Bool {
    return Bool(Builtin.cmp_eq_Int64(lhs._value, rhs._value))
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func < (lhs: Int, rhs: Int) -> Bool {
    return Bool(Builtin.cmp_slt_Int64(lhs._value, rhs._value))
  }

// See corresponding definitions in the FixedWidthInteger extension.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Adds two values and stores the result in the left-hand-side variable.
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x += 120
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +=(_ lhs: inout Int, _ rhs: Int) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.sadd_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Subtracts the second value from the first and stores the difference in the
  /// left-hand-side variable.
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     var x: UInt8 = 21
  ///     x - 50
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -=(_ lhs: inout Int, _ rhs: Int) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.ssub_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *=(_ lhs: inout Int, _ rhs: Int) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3263)
    let (result, overflow) =
      Builtin.smul_with_overflow_Int64(
        lhs._value, rhs._value, true._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)
  /// Divides the first value by the second and stores the quotient in the
  /// left-hand-side variable.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     var x = 21
  ///     x /= 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3240)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /=(_ lhs: inout Int, _ rhs: Int) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3245)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int)) {
      _preconditionFailure(
        "Division by zero")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3252)
    if _slowPath(
      lhs == Int.min && rhs == (-1 as Int)
    ) {
      _preconditionFailure(
        "Division results in an overflow")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3259)
    let (result, overflow) =
      (Builtin.sdiv_Int64(lhs._value, rhs._value),
      false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3267)
    Builtin.condfail(overflow)
    lhs = Int(result)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3271)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the quotient obtained by dividing this value by the given value,
  /// along with a Boolean value indicating whether overflow occurred in the
  /// operation.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.dividedReportingOverflow(by: 0)` is `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the division along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   quotient. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains either the truncated quotient
  ///   or, if the quotient is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func dividedReportingOverflow(
    by other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int.min && other == (-1 as Int)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.sdiv_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the remainder after dividing this value by the given value, along
  /// with a Boolean value indicating whether overflow occurred during division.
  ///
  /// Dividing by zero is not an error when using this method. For a value `x`,
  /// the result of `x.remainderReportingOverflow(dividingBy: 0)` is
  /// `(x, true)`.
  ///
  /// - Parameter rhs: The value to divide this value by.
  /// - Returns: A tuple containing the result of the operation along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   remainder. If the `overflow` component is `true`, an overflow occurred
  ///   during division and the `partialValue` component contains either the
  ///   entire remainder or, if the remainder is undefined, the dividend.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func remainderReportingOverflow(
    dividingBy other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3281)
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(other == (0 as Int)) {
      return (partialValue: self, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3287)
    if _slowPath(self == Int.min && other == (-1 as Int)) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3289)
      return (partialValue: 0, overflow: true)
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3292)

    let (newStorage, overflow) = (
      Builtin.srem_Int64(self._value, other._value),
      false._value)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the sum of this value and the given value, along with a Boolean
  /// value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to add to this value.
  /// - Returns: A tuple containing the result of the addition along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   sum. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated sum of this value
  ///   and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func addingReportingOverflow(
    _ other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.sadd_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the difference obtained by subtracting the given value from this
  /// value, along with a Boolean value indicating whether overflow occurred in
  /// the operation.
  ///
  /// - Parameter rhs: The value to subtract from this value.
  /// - Returns: A tuple containing the result of the subtraction along with a
  ///   Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   difference. If the `overflow` component is `true`, an overflow occurred
  ///   and the `partialValue` component contains the truncated result of `rhs`
  ///   subtracted from this value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func subtractingReportingOverflow(
    _ other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.ssub_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3273)

  /// Returns the product of this value and the given value, along with a
  /// Boolean value indicating whether overflow occurred in the operation.
  ///
  /// - Parameter rhs: The value to multiply by this value.
  /// - Returns: A tuple containing the result of the multiplication along with
  ///   a Boolean value indicating whether overflow occurred. If the `overflow`
  ///   component is `false`, the `partialValue` component contains the entire
  ///   product. If the `overflow` component is `true`, an overflow occurred and
  ///   the `partialValue` component contains the truncated product of this
  ///   value and `rhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3274)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public func multipliedReportingOverflow(
    by other: Int
  ) -> (partialValue: Int, overflow: Bool) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3298)

    let (newStorage, overflow) =
      Builtin.smul_with_overflow_Int64(
        self._value, other._value, false._value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3303)

    return (
      partialValue: Int(newStorage),
      overflow: Bool(overflow))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3309)

  /// Divides the first value by the second and stores the remainder in the
  /// left-hand-side variable.
  ///
  /// The result has the same sign as `lhs` and is less than `rhs.magnitude`.
  ///
  ///     var x = 22
  ///     x %= 5
  ///     // x == 2
  ///
  ///     var y = 22
  ///     y %= -5
  ///     // y == 2
  ///
  ///     var z = -22
  ///     z %= -5
  ///     // z == -2
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3310)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %=(_ lhs: inout Int, _ rhs: Int) {
    // No LLVM primitives for checking overflow of division operations, so we
    // check manually.
    if _slowPath(rhs == (0 as Int)) {
      _preconditionFailure(
        "Division by zero in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3321)
    if _slowPath(lhs == Int.min && rhs == (-1 as Int)) {
      _preconditionFailure(
        "Division results in an overflow in remainder operation")
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3326)

    let (newStorage, _) = (
      Builtin.srem_Int64(lhs._value, rhs._value),
      false._value)
    lhs = Int(newStorage)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public init(_ _value: Builtin.Int64) {
    self._value = _value
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise AND operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x &= y                    // 0b00000100
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &=(_ lhs: inout Int, _ rhs: Int) {
    lhs = Int(Builtin.and_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise OR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x |= y                    // 0b00001111
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |=(_ lhs: inout Int, _ rhs: Int) {
    lhs = Int(Builtin.or_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)
  /// Stores the result of performing a bitwise XOR operation on the two given
  /// values in the left-hand-side variable.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     var x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     x ^= y                    // 0b00001011
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3340)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^=(_ lhs: inout Int, _ rhs: Int) {
    lhs = Int(Builtin.xor_Int64(lhs._value, rhs._value))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3347)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Calculates the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&>>=` operator performs a *masking shift*, where the value passed as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &>>= 2
  ///     // x == 7                         // 0b00000111
  ///
  /// However, if you use `19` as `rhs`, the operation first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &>>= 19
  ///     // y == 3                         // 0b00000011
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>=(_ lhs: inout Int, _ rhs: Int) {
    let rhs_ = rhs & 63
    lhs = Int(
      Builtin.ashr_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3349)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width, and stores the result in the left-hand-side variable.
  ///
  /// The `&<<=` operator performs a *masking shift*, where the value used as
  /// `rhs` is masked to produce a value in the range `0..<lhs.bitWidth`. The
  /// shift is performed using this masked value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     var x: UInt8 = 30                 // 0b00011110
  ///     x &<<= 2
  ///     // x == 120                       // 0b01111000
  ///
  /// However, if you pass `19` as `rhs`, the method first bitmasks `rhs` to
  /// `3`, and then uses that masked value as the number of bits to shift `lhs`.
  ///
  ///     var y: UInt8 = 30                 // 0b00011110
  ///     y &<<= 19
  ///     // y == 240                       // 0b11110000
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3350)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<=(_ lhs: inout Int, _ rhs: Int) {
    let rhs_ = rhs & 63
    lhs = Int(
      Builtin.shl_Int64(lhs._value, rhs_._value))
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3360)

  /// The number of bits used for the underlying binary representation of
  /// values of this type.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3365)
  /// The bit width of a `Int` instance is 32 on 32-bit
  /// platforms and 64 on 64-bit platforms.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3370)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static var bitWidth : Int { return 64 }

  /// The number of leading zeros in this value's binary representation.
  ///
  /// For example, in an integer type with a `bitWidth` value of 8,
  /// the number *31* has three leading zeros.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.leadingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var leadingZeroBitCount: Int {
    return Int(
      Int(
        Builtin.int_ctlz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of trailing zeros in this value's binary representation.
  ///
  /// For example, the number *-8* has three trailing zeros.
  ///
  ///     let x = Int8(bitPattern: 0b1111_1000)
  ///     // x == -8
  ///     // x.trailingZeroBitCount == 3
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var trailingZeroBitCount: Int {
    return Int(
      Int(
        Builtin.int_cttz_Int64(self._value, false._value)
      )._lowWord._value)
  }

  /// The number of bits equal to 1 in this value's binary representation.
  ///
  /// For example, in a fixed-width integer type with a `bitWidth` value of 8,
  /// the number *31* has five bits equal to *1*.
  ///
  ///     let x: Int8 = 0b0001_1111
  ///     // x == 31
  ///     // x.nonzeroBitCount == 5
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var nonzeroBitCount: Int {
    return Int(
      Int(
        Builtin.int_ctpop_Int64(self._value)
      )._lowWord._value)
  }

  // FIXME should be RandomAccessCollection
  /// A type that represents the words of this integer.
  @_fixed_layout // FIXME(sil-serialize-all)
  public struct Words : BidirectionalCollection {
    public typealias Indices = Range<Int>
    public typealias SubSequence = Slice<Int.Words>

    @usableFromInline // FIXME(sil-serialize-all)
    internal var _value: Int

    @inlinable // FIXME(sil-serialize-all)
    public init(_ value: Int) {
      self._value = value
    }

    @inlinable // FIXME(sil-serialize-all)
    public var count: Int {
      return (64 + 64 - 1) / 64
    }

    @inlinable // FIXME(sil-serialize-all)
    public var startIndex: Int { return 0 }

    @inlinable // FIXME(sil-serialize-all)
    public var endIndex: Int { return count }

    @inlinable // FIXME(sil-serialize-all)
    public var indices: Indices { return startIndex ..< endIndex }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(after i: Int) -> Int { return i + 1 }

    @inlinable // FIXME(sil-serialize-all)
    @_transparent
    public func index(before i: Int) -> Int { return i - 1 }

    @inlinable // FIXME(sil-serialize-all)
    public subscript(position: Int) -> UInt {
      get {
        _precondition(position >= 0, "Negative word index")
        _precondition(position < endIndex, "Word index out of range")
        let shift = UInt(position._value) &* 64
        _sanityCheck(shift < UInt(_value.bitWidth._value))
        return (_value &>> Int(_truncatingBits: shift))._lowWord
      }
    }
  }

  /// A collection containing the words of this value's binary
  /// representation, in order from the least significant to most significant.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3476)
  ///
  /// Negative values are returned in two's complement representation,
  /// regardless of the type's underlying implementation.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3480)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var words: Words {
    return Words(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  var _lowWord: UInt {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3491)
    return UInt(
      Builtin.sextOrBitCast_Int64_Int64(_value)
    )
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // transparent
  init(_truncatingBits bits: UInt) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3501)
    self.init(
      Builtin.truncOrBitCast_Int64_Int64(bits._value))
  }

  /// A type that can represent the absolute value of any possible value of
  /// this type.
  public typealias Magnitude = UInt

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3510)
  /// The magnitude of this value.
  ///
  /// For any numeric value `x`, `x.magnitude` is the absolute value of `x`.
  /// You can use the `magnitude` property in operations that are simpler to
  /// implement in terms of unsigned values, such as printing the value of an
  /// integer, which is just printing a '-' character in front of an absolute
  /// value.
  ///
  ///     let x = -200
  ///     // x.magnitude == 200
  ///
  /// The global `abs(_:)` function provides more familiar syntax when you need
  /// to find an absolute value. In addition, because `abs(_:)` always returns
  /// a value of the same type, even in a generic context, using the function
  /// instead of the `magnitude` property is encouraged.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var magnitude: UInt {
    let base = UInt(_value)
    return self < (0 as Int) ? ~base + 1 : base
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3532)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3534)
  /// Returns a tuple containing the high and low parts of the result of
  /// multiplying this value by the given value.
  ///
  /// Use this method to calculate the full result of a product that would
  /// otherwise overflow. Unlike traditional truncating multiplication, the
  /// `multipliedFullWidth(by:)` method returns a tuple
  /// containing both the `high` and `low` parts of the product of this value and
  /// `other`. The following example uses this method to multiply two `UInt8`
  /// values that normally overflow when multiplied:
  ///
  ///     let x: UInt8 = 100
  ///     let y: UInt8 = 20
  ///     let result = x.multipliedFullWidth(by: y)
  ///     // result.high == 0b00000111
  ///     // result.low  == 0b11010000
  ///
  /// The product of `x` and `y` is 2000, which is too large to represent in a
  /// `UInt8` instance. The `high` and `low` properties of the `result` value
  /// represent 2000 when concatenated to form a double-width integer; that
  /// is, using `result.high` as the high byte and `result.low` as the low byte
  /// of a `UInt16` instance.
  ///
  ///     let z = UInt16(result.high) << 8 | UInt16(result.low)
  ///     // z == 2000
  ///
  /// - Parameter other: The value to multiply this value by.
  /// - Returns: A tuple containing the high and low parts of the result of
  ///   multiplying this value and `other`.
  @inlinable // FIXME(sil-serialize-all)
  public func multipliedFullWidth(by other: Int)
    -> (high: Int, low: Int.Magnitude) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3571)
    let lhs_ = Builtin.sext_Int64_Int128(self._value)
    let rhs_ = Builtin.sext_Int64_Int128(other._value)

    let res = Builtin.mul_Int128(lhs_, rhs_)
    let low = Int.Magnitude(Builtin.truncOrBitCast_Int128_Int64(res))
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let shifted = Builtin.ashr_Int128(res, shift)
    let high = Int(Builtin.truncOrBitCast_Int128_Int64(shifted))
    return (high: high, low: low)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3581)
  }

  /// Returns a tuple containing the quotient and remainder of dividing the
  /// given value by this value.
  ///
  /// The resulting quotient must be representable within the bounds of the
  /// type. If the quotient of dividing `dividend` by this value is too large
  /// to represent in the type, a runtime error may occur.
  ///
  /// - Parameter dividend: A tuple containing the high and low parts of a
  ///   double-width integer. The `high` component of the value carries the
  ///   sign, if the type is signed.
  /// - Returns: A tuple containing the quotient and remainder of `dividend`
  ///   divided by this value.
  @inlinable // FIXME(sil-serialize-all)
  public func dividingFullWidth(
    _ dividend: (high: Int, low: Int.Magnitude)
  ) -> (quotient: Int, remainder: Int) {
    // FIXME(integers): tests
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3607)
    // FIXME(integers): handle division by zero and overflows
    _precondition(self != 0, "Division by zero")
    let lhsHigh = Builtin.sext_Int64_Int128(dividend.high._value)
    let shift = Builtin.zextOrBitCast_Int8_Int128(UInt8(64)._value)
    let lhsHighShifted = Builtin.shl_Int128(lhsHigh, shift)
    let lhsLow = Builtin.zext_Int64_Int128(dividend.low._value)
    let lhs_ = Builtin.or_Int128(lhsHighShifted, lhsLow)
    let rhs_ = Builtin.sext_Int64_Int128(self._value)

    let quotient_ = Builtin.sdiv_Int128(lhs_, rhs_)
    let remainder_ = Builtin.srem_Int128(lhs_, rhs_)

    let quotient = Int(
      Builtin.truncOrBitCast_Int128_Int64(quotient_))
    let remainder = Int(
      Builtin.truncOrBitCast_Int128_Int64(remainder_))

    return (quotient: quotient, remainder: remainder)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3626)
  }

  /// A representation of this integer with the byte order swapped.
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public var byteSwapped: Int {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3635)
    return Int(Builtin.int_bswap_Int64(_value))
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3637)
  }

  // Implementation details

  public var _value: Builtin.Int64

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3644)
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // @testable
  init(_ _v: Builtin.Word) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3651)
    self._value = Builtin.zextOrBitCast_Word_Int64(_v)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3653)
  }

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public // @testable
  var _builtinWordValue: Builtin.Word {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3662)
    return Builtin.truncOrBitCast_Int64_Word(_value)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3664)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3666)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, message: "Use initializers instead")
  public func toUIntMax() -> UInt64 {
    return numericCast(self)
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use bitWidth instead.")
  public static var _sizeInBits: Int { return 64 }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public static var _sizeInBytes: Int { return 64/8 }

  /// Returns `-1` if this value is negative and `1` if it's positive;
  /// otherwise, `0`.
  ///
  /// - Returns: The sign of this number, expressed as an integer of the same
  ///   type.
  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public func signum() -> Int {
    let isPositive = Int(Builtin.zext_Int1_Int64(
      (self > (0 as Int))._value))
    return isPositive | (self &>> 63)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3695)

extension Int : Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    // FIXME(hasher): To correctly bridge `Set`s/`Dictionary`s containing
    // `AnyHashable`-boxed integers, all integer values are currently required
    // to hash exactly the same way as the corresponding (U)Int64 value.  To fix
    // this, we should introduce a custom AnyHashable box for integer values
    // that sign-extends values to 64 bits.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3705)
    hasher._combine(_lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3715)
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    // FIXME(hasher): Note that the AnyHashable concern applies here too,
    // because hashValue uses top-level hashing.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3722)
    return Hasher._hash(seed: seed, _lowWord)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3731)
  }
}


// Create an ambiguity when indexing or slicing
// Range[OfStrideable]<Int> outside a generic context.  See
// Range.swift for details.
extension Int {
  public typealias _DisabledRangeIndex = Int
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: UInt64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3763)
    let dstNotWord = src
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3748)
extension Int {
  /// Creates a new instance with the same bitwise representation as the least
  /// significant bits of the given value.
  ///
  /// This initializer performs no range or overflow checking. The resulting
  /// instance may have a different numeric value from `source`.
  ///
  /// - Parameter source: An integer to use as the source of the new value's
  ///   bit pattern.
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0, renamed: "init(truncatingIfNeeded:)")
  @_transparent
  public init(truncatingBitPattern source: Int64) {
    let src = source._value
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3763)
    let dstNotWord = src
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3767)
    self._value = dstNotWord
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3772)


// FIXME(integers): this section here is to help the typechecker,
// as it seems to have problems with a pattern where the nonmutating operation
// is defined on a protocol in terms of a mutating one that is itself defined
// on concrete types.
extension Int {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise AND operation on the two given
  /// values.
  ///
  /// A bitwise AND operation results in a value that has each bit set to `1`
  /// where *both* of its arguments have that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x & y             // 0b00000100
  ///     // z == 4
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs &= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise OR operation on the two given
  /// values.
  ///
  /// A bitwise OR operation results in a value that has each bit set to `1`
  /// where *one or both* of its arguments have that bit set to `1`. For
  /// example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x | y             // 0b00001111
  ///     // z == 15
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func |(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs |= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of performing a bitwise XOR operation on the two given
  /// values.
  ///
  /// A bitwise XOR operation, also known as an exclusive OR operation, results
  /// in a value that has each bit set to `1` where *one or the other but not
  /// both* of its arguments had that bit set to `1`. For example:
  ///
  ///     let x: UInt8 = 5          // 0b00000101
  ///     let y: UInt8 = 14         // 0b00001110
  ///     let z = x ^ y             // 0b00001011
  ///     // z == 11
  ///
  /// - Parameters:
  ///   - lhs: An integer value.
  ///   - rhs: Another integer value.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func ^(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs ^= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the right, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking right shift operator (`&>>`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking right shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &>> 2
  ///     // y == 7                         // 0b00000111
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &>> 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the right. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &>>(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs &>>= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the result of shifting a value's binary representation the
  /// specified number of digits to the left, masking the shift amount to the
  /// type's bit width.
  ///
  /// Use the masking left shift operator (`&<<`) when you need to perform a
  /// shift and are sure that the shift amount is in the range
  /// `0..<lhs.bitWidth`. Before shifting, the masking left shift operator
  /// masks the shift to this range. The shift is performed using this masked
  /// value.
  ///
  /// The following example defines `x` as an instance of `UInt8`, an 8-bit,
  /// unsigned integer type. If you use `2` as the right-hand-side value in an
  /// operation on `x`, the shift amount requires no masking.
  ///
  ///     let x: UInt8 = 30                 // 0b00011110
  ///     let y = x &<< 2
  ///     // y == 120                       // 0b01111000
  ///
  /// However, if you use `8` as the shift amount, the method first masks the
  /// shift amount to zero, and then performs the shift, resulting in no change
  /// to the original value.
  ///
  ///     let z = x &<< 8
  ///     // z == 30                        // 0b00011110
  ///
  /// If the bit width of the shifted integer type is a power of two, masking
  /// is performed using a bitmask; otherwise, masking is performed using a
  /// modulo operation.
  ///
  /// - Parameters:
  ///   - lhs: The value to shift.
  ///   - rhs: The number of bits to shift `lhs` to the left. If `rhs` is
  ///     outside the range `0..<lhs.bitWidth`, it is masked to produce a
  ///     value within that range.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func &<<(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs &<<= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the quotient of dividing the first value by the second.
  ///
  /// For integer types, any remainder of the division is discarded.
  ///
  ///     let x = 21 / 5
  ///     // x == 4
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func /(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs /= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Returns the remainder of dividing the first value by the second.
  ///
  /// The result of the modulo operator (`%`) has the same sign as `lhs` and is
  /// less than `rhs.magnitude`.
  ///
  ///     let x = 22 % 5
  ///     // x == 2
  ///     let y = 22 % -5
  ///     // y == 2
  ///     let z = -22 % -5
  ///     // z == -2
  ///
  /// For any two integers `a` and `b`, their quotient `q`, and their remainder
  /// `r`, `a == b * q + r`.
  ///
  /// - Parameters:
  ///   - lhs: The value to divide.
  ///   - rhs: The value to divide `lhs` by. `rhs` must not be zero.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func %(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs %= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Adds two values and produces their sum.
  ///
  /// The addition operator (`+`) calculates the sum of its two arguments. For
  /// example:
  ///
  ///     1 + 2                   // 3
  ///     -10 + 15                // 5
  ///     -15 + -5                // -20
  ///     21.5 + 3.25             // 24.75
  ///
  /// You cannot use `+` with arguments of different types. To add values of
  /// different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) + y              // 1000021
  ///
  /// The sum of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 + 120` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x + 120                 // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow addition operator (`&+`).
  ///
  ///     x &+ 120                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to add.
  ///   - rhs: The second value to add.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func +(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs += rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Subtracts one value from another and produces their difference.
  ///
  /// The subtraction operator (`-`) calculates the difference of its two
  /// arguments. For example:
  ///
  ///     8 - 3                   // 5
  ///     -10 - 5                 // -15
  ///     100 - -5                // 105
  ///     10.5 - 100.0            // -89.5
  ///
  /// You cannot use `-` with arguments of different types. To subtract values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: UInt8 = 21
  ///     let y: UInt = 1000000
  ///     y - UInt(x)             // 999979
  ///
  /// The difference of the two arguments must be representable in the
  /// arguments' type. In the following example, the result of `21 - 50` is
  /// less than zero, the minimum representable `UInt8` value:
  ///
  ///     x - 50                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow subtraction operator (`&-`).
  ///
  ///     x &- 50                // 227
  ///
  /// - Parameters:
  ///   - lhs: A numeric value.
  ///   - rhs: The value to subtract from `lhs`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func -(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs -= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3781)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3782)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func *(_ lhs: Int, _ rhs: Int) -> Int {
    var lhs = lhs
    lhs *= rhs
    return lhs
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3792)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Int, rhs: Int
  ) -> Int {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Int, rhs: Int
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3794)

  /// Multiplies two values and produces their product.
  ///
  /// The multiplication operator (`*`) calculates the product of its two
  /// arguments. For example:
  ///
  ///     2 * 3                   // 6
  ///     100 * 21                // 2100
  ///     -10 * 15                // -150
  ///     3.5 * 2.25              // 7.875
  ///
  /// You cannot use `*` with arguments of different types. To multiply values
  /// of different types, convert one of the values to the other value's type.
  ///
  ///     let x: Int8 = 21
  ///     let y: Int = 1000000
  ///     Int(x) * y              // 21000000
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     x * 21                  // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// If you want to opt out of overflow checking and ignore any overflow, use
  /// the overflow multiplication operator (`&*`).
  ///
  ///     x &* 21                // -115
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3795)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Int, rhs: Int
  ) -> Int {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  /// Multiplies two values and stores the result in the left-hand-side
  /// variable.
  ///
  /// The product of the two arguments must be representable in the arguments'
  /// type. In the following example, the result of `21 * 21` is greater than
  /// the maximum representable `Int8` value:
  ///
  ///     var x: Int8 = 21
  ///     x * 21
  ///     // Overflow error
  ///
  /// - Note: Overflow checking is not performed in `-Ounchecked` builds.
  ///
  /// - Parameters:
  ///   - lhs: The first value to multiply.
  ///   - rhs: The second value to multiply.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3808)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Int, rhs: Int
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3820)

  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func != (lhs: Int, rhs: Int) -> Bool {
    return !(lhs == rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func <= (lhs: Int, rhs: Int) -> Bool {
    return !(rhs < lhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func >= (lhs: Int, rhs: Int) -> Bool {
    return !(lhs < rhs)
  }

  @inlinable // FIXME(sil-serialize-all)
  @inline(__always)
  public static func > (lhs: Int, rhs: Int) -> Bool {
    return rhs < lhs
  }
}


// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3848)
// TODO: Consider removing the underscore.
/// Returns the argument and specifies that the value is not negative.
/// It has only an effect if the argument is a load or call.
@inlinable // FIXME(sil-serialize-all)
@_transparent
public func _assumeNonNegative(_ x: Int) -> Int {
  _sanityCheck(x >= (0 as Int))
  return Int(Builtin.assumeNonNegative_Int64(x._value))
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3858)

//===--- end of FIXME(integers) -------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3862)


/// Returns the given integer as the equivalent value in a different integer
/// type.
///
/// The `numericCast(_:)` function traps on overflow in `-O` and `-Onone`
/// builds.
///
/// You can use `numericCast(_:)` to convert a value when the destination type
/// can be inferred from the context. In the following example, the
/// `random(in:)` function uses `numericCast(_:)` twice to convert the
/// argument and return value of the `arc4random_uniform(_:)` function to the
/// appropriate type.
///
///     func random(in range: Range<Int>) -> Int {
///         return numericCast(arc4random_uniform(numericCast(range.count)))
///             + range.lowerBound
///     }
///
///     let number = random(in: -10...<10)
///     // number == -3, perhaps
///
/// - Parameter x: The integer to convert, and instance of type `T`.
/// - Returns: The value of `x` converted to type `U`.
@inlinable // FIXME(sil-serialize-all)
@_transparent
public func numericCast<T : BinaryInteger, U : BinaryInteger>(_ x: T) -> U {
  return U(x)
}

// FIXME(integers): switch to using `FixedWidthInteger.unsafeAdding`
@inlinable // FIXME(sil-serialize-all)
internal func _unsafePlus(_ lhs: Int, _ rhs: Int) -> Int {
#if INTERNAL_CHECKS_ENABLED
  return lhs + rhs
#else
  return lhs &+ rhs
#endif
}

// FIXME(integers): switch to using `FixedWidthInteger.unsafeSubtracting`
@inlinable // FIXME(sil-serialize-all)
internal func _unsafeMinus(_ lhs: Int, _ rhs: Int) -> Int {
#if INTERNAL_CHECKS_ENABLED
  return lhs - rhs
#else
  return lhs &- rhs
#endif
}

// Swift 3 compatibility APIs

@available(swift, obsoleted: 4, renamed: "BinaryInteger")
public typealias Integer = BinaryInteger

@available(swift, obsoleted: 4, renamed: "BinaryInteger")
public typealias IntegerArithmetic = BinaryInteger

@available(swift, obsoleted: 4, message: "Please use 'SignedNumeric & Comparable' instead.")
public typealias SignedNumber = SignedNumeric & Comparable

@available(swift, obsoleted: 4, message: "Please use 'SignedNumeric & Comparable' instead.")
public typealias AbsoluteValuable = SignedNumeric & Comparable

@available(swift, obsoleted: 4, renamed: "SignedInteger")
public typealias _SignedInteger = SignedInteger

extension SignedNumeric where Self : Comparable {
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Please use the 'abs(_:)' free function.")
  @_transparent
  public static func abs(_ x: Self) -> Self {
    return Swift.abs(x)
  }
}

extension BinaryInteger {
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public func toIntMax() -> Int64 {
    return Int64(self)
  }
}

extension UnsignedInteger {
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  public func toUIntMax() -> UInt64 {
    return UInt64(self)
  }
}

// FIXME(integers): These overloads allow expressions like the following in
// Swift 3 compatibility mode:
//    let x = 1 << i32
//    f(i32: x)
// At the same time, since they are obsolete in Swift 4, this will not cause
// `u8 << -1` to fail due to an overflow in an unsigned value.
extension FixedWidthInteger {

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3963)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>(
    lhs: Self, rhs: Self
  ) -> Self {
    var lhs = lhs
    _nonMaskingRightShiftGeneric(&lhs, rhs)
    return lhs
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func >>=(
    lhs: inout Self, rhs: Self
  ) {
    _nonMaskingRightShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3963)

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<(
    lhs: Self, rhs: Self
  ) -> Self {
    var lhs = lhs
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
    return lhs
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4)
  @_semantics("optimize.sil.specialize.generic.partial.never")
  @_transparent
  public static func <<=(
    lhs: inout Self, rhs: Self
  ) {
    _nonMaskingLeftShiftGeneric(&lhs, rhs)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3987)

}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 3999)

extension FixedWidthInteger {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4002)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use addingReportingOverflow(_:) instead.")
  @_transparent
  public static func addWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    let (partialValue, overflow) =
      lhs.addingReportingOverflow( rhs)
    return (partialValue, overflow: overflow)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4002)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use subtractingReportingOverflow(_:) instead.")
  @_transparent
  public static func subtractWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    let (partialValue, overflow) =
      lhs.subtractingReportingOverflow( rhs)
    return (partialValue, overflow: overflow)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4002)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use multipliedReportingOverflow(by:) instead.")
  @_transparent
  public static func multiplyWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    let (partialValue, overflow) =
      lhs.multipliedReportingOverflow(by: rhs)
    return (partialValue, overflow: overflow)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4002)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use dividedReportingOverflow(by:) instead.")
  @_transparent
  public static func divideWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    let (partialValue, overflow) =
      lhs.dividedReportingOverflow(by: rhs)
    return (partialValue, overflow: overflow)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4002)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4, message: "Use remainderReportingOverflow(dividingBy:) instead.")
  @_transparent
  public static func remainderWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    let (partialValue, overflow) =
      lhs.remainderReportingOverflow(dividingBy: rhs)
    return (partialValue, overflow: overflow)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4014)
}

extension BinaryInteger {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4018)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 3.2,
    message: "Please use FixedWidthInteger protocol as a generic constraint and addingReportingOverflow(_:) method instead.")
  public static func addWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    fatalError("Unavailable")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4018)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 3.2,
    message: "Please use FixedWidthInteger protocol as a generic constraint and subtractingReportingOverflow(_:) method instead.")
  public static func subtractWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    fatalError("Unavailable")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4018)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 3.2,
    message: "Please use FixedWidthInteger protocol as a generic constraint and multipliedReportingOverflow(by:) method instead.")
  public static func multiplyWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    fatalError("Unavailable")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4018)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 3.2,
    message: "Please use FixedWidthInteger protocol as a generic constraint and dividedReportingOverflow(by:) method instead.")
  public static func divideWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    fatalError("Unavailable")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4018)
  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 3.2,
    message: "Please use FixedWidthInteger protocol as a generic constraint and remainderReportingOverflow(dividingBy:) method instead.")
  public static func remainderWithOverflow(
    _ lhs: Self, _ rhs: Self
  ) -> (Self, overflow: Bool) {
    fatalError("Unavailable")
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4027)
}

// FIXME(integers): Absence of &+ causes ambiguity in the code like the
// following:
//    func f<T : SignedInteger>(_ x: T, _ y: T) {
//      var _  = (x &+ (y - 1)) < x
//    }
//  Compiler output:
//  error: ambiguous reference to member '-'
//    var _  = (x &+ (y - 1)) < x
//                      ^
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4041)
extension SignedInteger {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4043)
  @inlinable // FIXME(sil-serialize-all)
  public static func _maskingAdd(_ lhs: Self, _ rhs: Self) -> Self {
    fatalError("Should be overridden in a more specific type")
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0,
      message: "Please use 'FixedWidthInteger' instead of 'SignedInteger' to get '&+' in generic code.")
  public static func &+ (lhs: Self, rhs: Self) -> Self {
    return _maskingAdd(lhs, rhs)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4043)
  @inlinable // FIXME(sil-serialize-all)
  public static func _maskingSubtract(_ lhs: Self, _ rhs: Self) -> Self {
    fatalError("Should be overridden in a more specific type")
  }

  @inlinable // FIXME(sil-serialize-all)
  @available(swift, obsoleted: 4.0,
      message: "Please use 'FixedWidthInteger' instead of 'SignedInteger' to get '&-' in generic code.")
  public static func &- (lhs: Self, rhs: Self) -> Self {
    return _maskingSubtract(lhs, rhs)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4055)
}

extension SignedInteger where Self : FixedWidthInteger {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4059)
  // This overload is supposed to break the ambiguity between the
  // implementations on SignedInteger and FixedWidthInteger
  @inlinable // FIXME(sil-serialize-all)
  public static func &+ (lhs: Self, rhs: Self) -> Self {
    return _maskingAdd(lhs, rhs)
  }
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func _maskingAdd(_ lhs: Self, _ rhs: Self) -> Self {
    return lhs.addingReportingOverflow(rhs).partialValue
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4059)
  // This overload is supposed to break the ambiguity between the
  // implementations on SignedInteger and FixedWidthInteger
  @inlinable // FIXME(sil-serialize-all)
  public static func &- (lhs: Self, rhs: Self) -> Self {
    return _maskingSubtract(lhs, rhs)
  }
  @inlinable // FIXME(sil-serialize-all)
  @_transparent
  public static func _maskingSubtract(_ lhs: Self, _ rhs: Self) -> Self {
    return lhs.subtractingReportingOverflow(rhs).partialValue
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Integers.swift.gyb", line: 4071)
}
