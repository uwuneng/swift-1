// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/Platform/Darwin.swift.gyb", line: 1)
//===----------------------------------------------------------------------===//
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

@_exported import Darwin // Clang module

public let MAP_FAILED: UnsafeMutableRawPointer! = UnsafeMutableRawPointer(bitPattern: -1)

//  Constants defined by <math.h>
@available(swift, deprecated: 3.0, message: "Please use 'Double.pi' or '.pi' to get the value of correct type and avoid casting.")
public let M_PI = Double.pi

@available(swift, deprecated: 3.0, message: "Please use 'Double.pi / 2' or '.pi / 2' to get the value of correct type and avoid casting.")
public let M_PI_2 = Double.pi / 2

@available(swift, deprecated: 3.0, message: "Please use 'Double.pi / 4' or '.pi / 4' to get the value of correct type and avoid casting.")
public let M_PI_4 = Double.pi / 4

@available(swift, deprecated: 3.0, message: "Please use '2.squareRoot()'.")
public let M_SQRT2 = 2.squareRoot()

@available(swift, deprecated: 3.0, message: "Please use '0.5.squareRoot()'.")
public let M_SQRT1_2 = 0.5.squareRoot()

//  Constants defined by <float.h>
@available(swift, deprecated: 3.0, message: "Please use 'T.radix' to get the radix of a FloatingPoint type 'T'.")
public let FLT_RADIX = Double.radix

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/Platform/Darwin.swift.gyb", line: 41)
//  Where does the 1 come from? C counts the usually-implicit leading
//  significand bit, but Swift does not. Neither is really right or wrong.
@available(swift, deprecated: 3.0, message: "Please use 'Float.significandBitCount + 1'.")
public let FLT_MANT_DIG = Float.significandBitCount + 1

//  Where does the 1 come from? C models floating-point numbers as having a
//  significand in [0.5, 1), but Swift (following IEEE 754) considers the
//  significand to be in [1, 2). This rationale applies to FLT_MIN_EXP
//  as well.
@available(swift, deprecated: 3.0, message: "Please use 'Float.greatestFiniteMagnitude.exponent + 1'.")
public let FLT_MAX_EXP = Float.greatestFiniteMagnitude.exponent + 1

@available(swift, deprecated: 3.0, message: "Please use 'Float.leastNormalMagnitude.exponent + 1'.")
public let FLT_MIN_EXP = Float.leastNormalMagnitude.exponent + 1

@available(swift, deprecated: 3.0, message: "Please use 'Float.greatestFiniteMagnitude' or '.greatestFiniteMagnitude'.")
public let FLT_MAX = Float.greatestFiniteMagnitude

@available(swift, deprecated: 3.0, message: "Please use 'Float.ulpOfOne' or '.ulpOfOne'.")
public let FLT_EPSILON = Float.ulpOfOne

@available(swift, deprecated: 3.0, message: "Please use 'Float.leastNormalMagnitude' or '.leastNormalMagnitude'.")
public let FLT_MIN = Float.leastNormalMagnitude

@available(swift, deprecated: 3.0, message: "Please use 'Float.leastNonzeroMagnitude' or '.leastNonzeroMagnitude'.")
public let FLT_TRUE_MIN = Float.leastNonzeroMagnitude

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/Platform/Darwin.swift.gyb", line: 41)
//  Where does the 1 come from? C counts the usually-implicit leading
//  significand bit, but Swift does not. Neither is really right or wrong.
@available(swift, deprecated: 3.0, message: "Please use 'Double.significandBitCount + 1'.")
public let DBL_MANT_DIG = Double.significandBitCount + 1

//  Where does the 1 come from? C models floating-point numbers as having a
//  significand in [0.5, 1), but Swift (following IEEE 754) considers the
//  significand to be in [1, 2). This rationale applies to DBL_MIN_EXP
//  as well.
@available(swift, deprecated: 3.0, message: "Please use 'Double.greatestFiniteMagnitude.exponent + 1'.")
public let DBL_MAX_EXP = Double.greatestFiniteMagnitude.exponent + 1

@available(swift, deprecated: 3.0, message: "Please use 'Double.leastNormalMagnitude.exponent + 1'.")
public let DBL_MIN_EXP = Double.leastNormalMagnitude.exponent + 1

@available(swift, deprecated: 3.0, message: "Please use 'Double.greatestFiniteMagnitude' or '.greatestFiniteMagnitude'.")
public let DBL_MAX = Double.greatestFiniteMagnitude

@available(swift, deprecated: 3.0, message: "Please use 'Double.ulpOfOne' or '.ulpOfOne'.")
public let DBL_EPSILON = Double.ulpOfOne

@available(swift, deprecated: 3.0, message: "Please use 'Double.leastNormalMagnitude' or '.leastNormalMagnitude'.")
public let DBL_MIN = Double.leastNormalMagnitude

@available(swift, deprecated: 3.0, message: "Please use 'Double.leastNonzeroMagnitude' or '.leastNonzeroMagnitude'.")
public let DBL_TRUE_MIN = Double.leastNonzeroMagnitude

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/Platform/Darwin.swift.gyb", line: 39)
#if arch(i386) || arch(x86_64)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/Platform/Darwin.swift.gyb", line: 41)
//  Where does the 1 come from? C counts the usually-implicit leading
//  significand bit, but Swift does not. Neither is really right or wrong.
@available(swift, deprecated: 3.0, message: "Please use 'Float80.significandBitCount + 1'.")
public let LDBL_MANT_DIG = Float80.significandBitCount + 1

//  Where does the 1 come from? C models floating-point numbers as having a
//  significand in [0.5, 1), but Swift (following IEEE 754) considers the
//  significand to be in [1, 2). This rationale applies to LDBL_MIN_EXP
//  as well.
@available(swift, deprecated: 3.0, message: "Please use 'Float80.greatestFiniteMagnitude.exponent + 1'.")
public let LDBL_MAX_EXP = Float80.greatestFiniteMagnitude.exponent + 1

@available(swift, deprecated: 3.0, message: "Please use 'Float80.leastNormalMagnitude.exponent + 1'.")
public let LDBL_MIN_EXP = Float80.leastNormalMagnitude.exponent + 1

@available(swift, deprecated: 3.0, message: "Please use 'Float80.greatestFiniteMagnitude' or '.greatestFiniteMagnitude'.")
public let LDBL_MAX = Float80.greatestFiniteMagnitude

@available(swift, deprecated: 3.0, message: "Please use 'Float80.ulpOfOne' or '.ulpOfOne'.")
public let LDBL_EPSILON = Float80.ulpOfOne

@available(swift, deprecated: 3.0, message: "Please use 'Float80.leastNormalMagnitude' or '.leastNormalMagnitude'.")
public let LDBL_MIN = Float80.leastNormalMagnitude

@available(swift, deprecated: 3.0, message: "Please use 'Float80.leastNonzeroMagnitude' or '.leastNonzeroMagnitude'.")
public let LDBL_TRUE_MIN = Float80.leastNonzeroMagnitude

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/Platform/Darwin.swift.gyb", line: 69)
#endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/Platform/Darwin.swift.gyb", line: 72)

// Macros defined in bsd/sys/proc.h that do not import into Swift.
extension extern_proc {
    // #define p_starttime p_un.__p_starttime
    @_transparent
    public var p_starttime: timeval {
        get { return self.p_un.__p_starttime }
        set { self.p_un.__p_starttime = newValue }
    }
}
