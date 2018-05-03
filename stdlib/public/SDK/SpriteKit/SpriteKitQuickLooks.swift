// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/SpriteKit/SpriteKitQuickLooks.swift.gyb", line: 1)
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

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/SpriteKit/SpriteKitQuickLooks.swift.gyb", line: 14)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/SpriteKit/SpriteKitQuickLooks.swift.gyb", line: 16)

extension SKShapeNode : CustomPlaygroundQuickLookable {
  @available(*, deprecated, message: "SKShapeNode.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    let data = (self as AnyObject)._copyImageData?() as Data?

    // we could send a Raw, but I don't want to make a copy of the
    // bytes for no good reason make an NSImage out of them and
    // send that
#if os(macOS)
    let image = data.flatMap(NSImage.init(data:)) ?? NSImage()
#elseif os(iOS) || os(watchOS) || os(tvOS)
    let image = data.flatMap(UIImage.init(data:)) ?? UIImage() 
#endif

    return .sprite(image)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/SpriteKit/SpriteKitQuickLooks.swift.gyb", line: 16)

extension SKSpriteNode : CustomPlaygroundQuickLookable {
  @available(*, deprecated, message: "SKSpriteNode.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    let data = (self as AnyObject)._copyImageData?() as Data?

    // we could send a Raw, but I don't want to make a copy of the
    // bytes for no good reason make an NSImage out of them and
    // send that
#if os(macOS)
    let image = data.flatMap(NSImage.init(data:)) ?? NSImage()
#elseif os(iOS) || os(watchOS) || os(tvOS)
    let image = data.flatMap(UIImage.init(data:)) ?? UIImage() 
#endif

    return .sprite(image)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/SpriteKit/SpriteKitQuickLooks.swift.gyb", line: 16)

extension SKTextureAtlas : CustomPlaygroundQuickLookable {
  @available(*, deprecated, message: "SKTextureAtlas.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    let data = (self as AnyObject)._copyImageData?() as Data?

    // we could send a Raw, but I don't want to make a copy of the
    // bytes for no good reason make an NSImage out of them and
    // send that
#if os(macOS)
    let image = data.flatMap(NSImage.init(data:)) ?? NSImage()
#elseif os(iOS) || os(watchOS) || os(tvOS)
    let image = data.flatMap(UIImage.init(data:)) ?? UIImage() 
#endif

    return .sprite(image)
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/SpriteKit/SpriteKitQuickLooks.swift.gyb", line: 16)

extension SKTexture : CustomPlaygroundQuickLookable {
  @available(*, deprecated, message: "SKTexture.customPlaygroundQuickLook will be removed in a future Swift version")
  public var customPlaygroundQuickLook: PlaygroundQuickLook {
    let data = (self as AnyObject)._copyImageData?() as Data?

    // we could send a Raw, but I don't want to make a copy of the
    // bytes for no good reason make an NSImage out of them and
    // send that
#if os(macOS)
    let image = data.flatMap(NSImage.init(data:)) ?? NSImage()
#elseif os(iOS) || os(watchOS) || os(tvOS)
    let image = data.flatMap(UIImage.init(data:)) ?? UIImage() 
#endif

    return .sprite(image)
  }
}
