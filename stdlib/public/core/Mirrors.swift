// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 1)
//===--- Mirrors.swift.gyb - Common _Mirror implementations ---*- swift -*-===//
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

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 37)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Float : CustomReflectable {
  /// A mirror that reflects the `Float` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Float : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Float` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Float.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .float(self)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Double : CustomReflectable {
  /// A mirror that reflects the `Double` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Double : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Double` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Double.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .double(self)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Bool : CustomReflectable {
  /// A mirror that reflects the `Bool` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Bool : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Bool` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Bool.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .bool(self)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension String : CustomReflectable {
  /// A mirror that reflects the `String` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension String : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `String` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "String.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .text(self)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Character : CustomReflectable {
  /// A mirror that reflects the `Character` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Character : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Character` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Character.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .text(String(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Unicode.Scalar : CustomReflectable {
  /// A mirror that reflects the `Unicode.Scalar` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Unicode.Scalar : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Unicode.Scalar` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Unicode.Scalar.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .uInt(UInt64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension UInt8 : CustomReflectable {
  /// A mirror that reflects the `UInt8` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension UInt8 : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `UInt8` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "UInt8.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .uInt(UInt64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Int8 : CustomReflectable {
  /// A mirror that reflects the `Int8` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Int8 : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Int8` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Int8.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .int(Int64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension UInt16 : CustomReflectable {
  /// A mirror that reflects the `UInt16` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension UInt16 : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `UInt16` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "UInt16.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .uInt(UInt64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Int16 : CustomReflectable {
  /// A mirror that reflects the `Int16` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Int16 : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Int16` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Int16.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .int(Int64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension UInt32 : CustomReflectable {
  /// A mirror that reflects the `UInt32` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension UInt32 : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `UInt32` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "UInt32.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .uInt(UInt64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Int32 : CustomReflectable {
  /// A mirror that reflects the `Int32` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Int32 : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Int32` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Int32.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .int(Int64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension UInt64 : CustomReflectable {
  /// A mirror that reflects the `UInt64` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension UInt64 : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `UInt64` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "UInt64.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .uInt(UInt64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Int64 : CustomReflectable {
  /// A mirror that reflects the `Int64` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Int64 : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Int64` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Int64.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .int(Int64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension UInt : CustomReflectable {
  /// A mirror that reflects the `UInt` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension UInt : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `UInt` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "UInt.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .uInt(UInt64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 39)

extension Int : CustomReflectable {
  /// A mirror that reflects the `Int` instance.
  @inlinable // FIXME(sil-serialize-all)
  public var customMirror: Mirror {
    return Mirror(self, unlabeledChildren: EmptyCollection<Void>())
  }
}

extension Int : CustomPlaygroundQuickLookable {
  /// A custom playground Quick Look for the `Int` instance.
  @inlinable // FIXME(sil-serialize-all)
  @available(*, deprecated, message: "Int.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    return .int(Int64(self))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Mirrors.swift.gyb", line: 57)

// Local Variables:
// eval: (read-only-mode 1)
// End:
