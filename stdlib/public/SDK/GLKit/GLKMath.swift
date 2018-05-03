// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 1)
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
// GLKit overlays for Swift
//===----------------------------------------------------------------------===//

@_exported import GLKit // Clang module

// The GLKit headers provide a fairly complete set of types and operations
// that Swift's importer is now able to present in Swift. However, Swift
// still doesn't know yet how to natively expose the elements of these types.
// This overlay generates Swift accessors for the GLKit matrix and vector
// types.

// Do dirty pointer manipulations to index an opaque struct like an array.
@inline(__always)
public func _indexHomogeneousValue<TTT, T>(_ aggregate: UnsafePointer<TTT>,
                                           _ index: Int) -> T {
  return UnsafeRawPointer(aggregate).load(
    fromByteOffset: index * MemoryLayout<T>.stride, as: T.self)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 47)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 49)

extension GLKMatrix2 {
  
  public subscript(i: Int) -> Float {
    @inline(__always)
    get {
      _precondition(i >= 0, "Negative GLKMatrix2 index out of range")
      _precondition(i < 4, "GLKMatrix2 index out of range")

      // We can't derive an UnsafePointer from a let binding. Lame.
      var clone = self
      return _indexHomogeneousValue(&clone, i)
    }
  }
  
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 52)
}

extension GLKVector2 {
  
  public subscript(i: Int) -> Float {
    @inline(__always)
    get {
      _precondition(i >= 0, "Negative GLKVector2 index out of range")
      _precondition(i < 2, "GLKVector2 index out of range")

      // We can't derive an UnsafePointer from a let binding. Lame.
      var clone = self
      return _indexHomogeneousValue(&clone, i)
    }
  }
  
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 56)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 49)

extension GLKMatrix3 {
  
  public subscript(i: Int) -> Float {
    @inline(__always)
    get {
      _precondition(i >= 0, "Negative GLKMatrix3 index out of range")
      _precondition(i < 9, "GLKMatrix3 index out of range")

      // We can't derive an UnsafePointer from a let binding. Lame.
      var clone = self
      return _indexHomogeneousValue(&clone, i)
    }
  }
  
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 52)
}

extension GLKVector3 {
  
  public subscript(i: Int) -> Float {
    @inline(__always)
    get {
      _precondition(i >= 0, "Negative GLKVector3 index out of range")
      _precondition(i < 3, "GLKVector3 index out of range")

      // We can't derive an UnsafePointer from a let binding. Lame.
      var clone = self
      return _indexHomogeneousValue(&clone, i)
    }
  }
  
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 56)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 49)

extension GLKMatrix4 {
  
  public subscript(i: Int) -> Float {
    @inline(__always)
    get {
      _precondition(i >= 0, "Negative GLKMatrix4 index out of range")
      _precondition(i < 16, "GLKMatrix4 index out of range")

      // We can't derive an UnsafePointer from a let binding. Lame.
      var clone = self
      return _indexHomogeneousValue(&clone, i)
    }
  }
  
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 52)
}

extension GLKVector4 {
  
  public subscript(i: Int) -> Float {
    @inline(__always)
    get {
      _precondition(i >= 0, "Negative GLKVector4 index out of range")
      _precondition(i < 4, "GLKVector4 index out of range")

      // We can't derive an UnsafePointer from a let binding. Lame.
      var clone = self
      return _indexHomogeneousValue(&clone, i)
    }
  }
  
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 56)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 59)

extension GLKQuaternion {
  
  public subscript(i: Int) -> Float {
    @inline(__always)
    get {
      _precondition(i >= 0, "Negative GLKQuaternion index out of range")
      _precondition(i < 4, "GLKQuaternion index out of range")

      // We can't derive an UnsafePointer from a let binding. Lame.
      var clone = self
      return _indexHomogeneousValue(&clone, i)
    }
  }
  
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/GLKit/GLKMath.swift.gyb", line: 62)
}
