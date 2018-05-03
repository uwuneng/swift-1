// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/stubs/SwiftNativeNSXXXBase.mm.gyb", line: 1)
//===--- SwiftNativeNSXXXBase.mm.gyb - Cocoa classes with fast refcounts --===//
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
//
// Classes derived from ObjC bases but that use native swift reference
// counting, layout, and allocation.
//
// These classes declare a native Swift object header and override the
// NSObject methods that do reference counting to use it accordingly.
// We can only do this trick with objc classes that are known not to
// use the storage where Swift places its native object header.  This
// takes care of how the classes are handled from Objective-C code.
//    _NSSwiftArrayBase, _NSSwiftDictionaryBase, _NSSwiftSetBase
//    _NSSwiftSetBase, _NSSwiftStringBase
//
// To trick Swift into using its fast refcounting and allocation
// directly (rather than going through objc_msgSend to arrive at the
// implementations defined here), we define subclasses on the Swift
// side but we establish the inheritance relationship with
// the special @_swift_native_objc_runtime_base attribute rather
// than directly subclassing the classes defined here.
//
//===----------------------------------------------------------------------===//

#include "swift/Runtime/Config.h"

#if SWIFT_OBJC_INTEROP
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#include <objc/NSObject.h>
#include <objc/runtime.h>
#include <objc/objc.h>
#include "swift/Runtime/HeapObject.h"
#include "swift/Runtime/Metadata.h"
#include "swift/Runtime/ObjCBridge.h"
#include "llvm/ADT/DenseMap.h"
#include <stdio.h>
#include <stdlib.h>

extern "C" CFHashCode CFStringHashCString(const uint8_t *bytes, CFIndex len);

using namespace swift;

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/stubs/SwiftNativeNSXXXBase.mm.gyb", line: 53)
SWIFT_RUNTIME_STDLIB_INTERFACE
@interface _SwiftNativeNSArrayBase : NSArray
{
 @private
  SWIFT_HEAPOBJECT_NON_OBJC_MEMBERS;
}
@end


@implementation _SwiftNativeNSArrayBase

- (id)retain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_retain(SELF);
  return self;
}
- (oneway void)release {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_release(SELF);
}
- (id)autorelease {
  return _objc_rootAutorelease(self);
}
- (NSUInteger)retainCount {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return swift_retainCount(SELF);
}

- (BOOL)_tryRetain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return (bool)swift_tryRetain(SELF);
}
- (BOOL)_isDeallocating {
  return swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)allowsWeakReference {
  return !swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)retainWeakReference {
  return swift_tryRetain(reinterpret_cast<HeapObject*>(self)) != nullptr;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)dealloc {
  swift_rootObjCDealloc(reinterpret_cast<HeapObject *>(self));
}
#pragma clang diagnostic pop

@end
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/stubs/SwiftNativeNSXXXBase.mm.gyb", line: 53)
SWIFT_RUNTIME_STDLIB_INTERFACE
@interface _SwiftNativeNSDictionaryBase : NSDictionary
{
 @private
  SWIFT_HEAPOBJECT_NON_OBJC_MEMBERS;
}
@end


@implementation _SwiftNativeNSDictionaryBase

- (id)retain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_retain(SELF);
  return self;
}
- (oneway void)release {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_release(SELF);
}
- (id)autorelease {
  return _objc_rootAutorelease(self);
}
- (NSUInteger)retainCount {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return swift_retainCount(SELF);
}

- (BOOL)_tryRetain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return (bool)swift_tryRetain(SELF);
}
- (BOOL)_isDeallocating {
  return swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)allowsWeakReference {
  return !swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)retainWeakReference {
  return swift_tryRetain(reinterpret_cast<HeapObject*>(self)) != nullptr;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)dealloc {
  swift_rootObjCDealloc(reinterpret_cast<HeapObject *>(self));
}
#pragma clang diagnostic pop

@end
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/stubs/SwiftNativeNSXXXBase.mm.gyb", line: 53)
SWIFT_RUNTIME_STDLIB_INTERFACE
@interface _SwiftNativeNSSetBase : NSSet
{
 @private
  SWIFT_HEAPOBJECT_NON_OBJC_MEMBERS;
}
@end


@implementation _SwiftNativeNSSetBase

- (id)retain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_retain(SELF);
  return self;
}
- (oneway void)release {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_release(SELF);
}
- (id)autorelease {
  return _objc_rootAutorelease(self);
}
- (NSUInteger)retainCount {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return swift_retainCount(SELF);
}

- (BOOL)_tryRetain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return (bool)swift_tryRetain(SELF);
}
- (BOOL)_isDeallocating {
  return swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)allowsWeakReference {
  return !swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)retainWeakReference {
  return swift_tryRetain(reinterpret_cast<HeapObject*>(self)) != nullptr;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)dealloc {
  swift_rootObjCDealloc(reinterpret_cast<HeapObject *>(self));
}
#pragma clang diagnostic pop

@end
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/stubs/SwiftNativeNSXXXBase.mm.gyb", line: 53)
SWIFT_RUNTIME_STDLIB_INTERFACE
@interface _SwiftNativeNSStringBase : NSString
{
 @private
  SWIFT_HEAPOBJECT_NON_OBJC_MEMBERS;
}
@end


@implementation _SwiftNativeNSStringBase

- (id)retain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_retain(SELF);
  return self;
}
- (oneway void)release {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_release(SELF);
}
- (id)autorelease {
  return _objc_rootAutorelease(self);
}
- (NSUInteger)retainCount {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return swift_retainCount(SELF);
}

- (BOOL)_tryRetain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return (bool)swift_tryRetain(SELF);
}
- (BOOL)_isDeallocating {
  return swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)allowsWeakReference {
  return !swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)retainWeakReference {
  return swift_tryRetain(reinterpret_cast<HeapObject*>(self)) != nullptr;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)dealloc {
  swift_rootObjCDealloc(reinterpret_cast<HeapObject *>(self));
}
#pragma clang diagnostic pop

@end
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/stubs/SwiftNativeNSXXXBase.mm.gyb", line: 53)
SWIFT_RUNTIME_STDLIB_INTERFACE
@interface _SwiftNativeNSEnumeratorBase : NSEnumerator
{
 @private
  SWIFT_HEAPOBJECT_NON_OBJC_MEMBERS;
}
@end


@implementation _SwiftNativeNSEnumeratorBase

- (id)retain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_retain(SELF);
  return self;
}
- (oneway void)release {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_release(SELF);
}
- (id)autorelease {
  return _objc_rootAutorelease(self);
}
- (NSUInteger)retainCount {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return swift_retainCount(SELF);
}

- (BOOL)_tryRetain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return (bool)swift_tryRetain(SELF);
}
- (BOOL)_isDeallocating {
  return swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)allowsWeakReference {
  return !swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)retainWeakReference {
  return swift_tryRetain(reinterpret_cast<HeapObject*>(self)) != nullptr;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)dealloc {
  swift_rootObjCDealloc(reinterpret_cast<HeapObject *>(self));
}
#pragma clang diagnostic pop

@end
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/stubs/SwiftNativeNSXXXBase.mm.gyb", line: 53)
SWIFT_RUNTIME_STDLIB_INTERFACE
@interface _SwiftNativeNSDataBase : NSData
{
 @private
  SWIFT_HEAPOBJECT_NON_OBJC_MEMBERS;
}
@end


@implementation _SwiftNativeNSDataBase

- (id)retain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_retain(SELF);
  return self;
}
- (oneway void)release {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_release(SELF);
}
- (id)autorelease {
  return _objc_rootAutorelease(self);
}
- (NSUInteger)retainCount {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return swift_retainCount(SELF);
}

- (BOOL)_tryRetain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return (bool)swift_tryRetain(SELF);
}
- (BOOL)_isDeallocating {
  return swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)allowsWeakReference {
  return !swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)retainWeakReference {
  return swift_tryRetain(reinterpret_cast<HeapObject*>(self)) != nullptr;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)dealloc {
  swift_rootObjCDealloc(reinterpret_cast<HeapObject *>(self));
}
#pragma clang diagnostic pop

@end
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/stubs/SwiftNativeNSXXXBase.mm.gyb", line: 53)
SWIFT_RUNTIME_STDLIB_INTERFACE
@interface _SwiftNativeNSIndexSetBase : NSIndexSet
{
 @private
  SWIFT_HEAPOBJECT_NON_OBJC_MEMBERS;
}
@end


@implementation _SwiftNativeNSIndexSetBase

- (id)retain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_retain(SELF);
  return self;
}
- (oneway void)release {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  swift_release(SELF);
}
- (id)autorelease {
  return _objc_rootAutorelease(self);
}
- (NSUInteger)retainCount {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return swift_retainCount(SELF);
}

- (BOOL)_tryRetain {
  auto SELF = reinterpret_cast<HeapObject *>(self);
  return (bool)swift_tryRetain(SELF);
}
- (BOOL)_isDeallocating {
  return swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)allowsWeakReference {
  return !swift_isDeallocating(reinterpret_cast<HeapObject *>(self));
}
- (BOOL)retainWeakReference {
  return swift_tryRetain(reinterpret_cast<HeapObject*>(self)) != nullptr;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)dealloc {
  swift_rootObjCDealloc(reinterpret_cast<HeapObject *>(self));
}
#pragma clang diagnostic pop

@end
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/stubs/SwiftNativeNSXXXBase.mm.gyb", line: 104)

SWIFT_CC(swift) SWIFT_RUNTIME_STDLIB_INTERNAL
bool
swift_stdlib_NSObject_isEqual(NSObject *SWIFT_NS_RELEASES_ARGUMENT lhs,
                              NSObject *SWIFT_NS_RELEASES_ARGUMENT rhs) {
  bool Result = (lhs == rhs) || [lhs isEqual:rhs];
  SWIFT_CC_PLUSONE_GUARD(swift_unknownRelease(lhs));
  SWIFT_CC_PLUSONE_GUARD(swift_unknownRelease(rhs));
  return Result;
}

SWIFT_CC(swift) SWIFT_RUNTIME_STDLIB_INTERFACE
int32_t swift_stdlib_compareNSStringDeterministicUnicodeCollation(
    NSString *SWIFT_NS_RELEASES_ARGUMENT lhs, NSString *SWIFT_NS_RELEASES_ARGUMENT rhs) {
  // 'kCFCompareNonliteral' actually means "normalize to NFD".
  int Result = CFStringCompare((__bridge CFStringRef)lhs,
                               (__bridge CFStringRef)rhs, kCFCompareNonliteral);
  SWIFT_CC_PLUSONE_GUARD(swift_unknownRelease(lhs));
  SWIFT_CC_PLUSONE_GUARD(swift_unknownRelease(rhs));
  return Result;
}

SWIFT_CC(swift) SWIFT_RUNTIME_STDLIB_INTERFACE
int32_t
swift_stdlib_compareNSStringDeterministicUnicodeCollationPtr(void *Lhs,
                                                             void *Rhs) {
  NSString *lhs = (NSString *)Lhs;
  NSString *rhs = (NSString *)Rhs;

  // 'kCFCompareNonliteral' actually means "normalize to NFD".
  int Result = CFStringCompare((__bridge CFStringRef)lhs,
                               (__bridge CFStringRef)rhs, kCFCompareNonliteral);
  return Result;
}

SWIFT_CC(swift) SWIFT_RUNTIME_STDLIB_INTERFACE
size_t
swift_stdlib_CFStringHashCString(const uint8_t *bytes, CFIndex len) {
  CFHashCode Result = CFStringHashCString(bytes, len);

  return Result;
}

SWIFT_CC(swift) SWIFT_RUNTIME_STDLIB_INTERNAL
void swift_stdlib_CFSetGetValues(NSSet *SWIFT_NS_RELEASES_ARGUMENT set,
                                 const void **values) {
  CFSetGetValues((__bridge CFSetRef)set, values);
  SWIFT_CC_PLUSONE_GUARD(swift_unknownRelease(set));
}
#endif

// Local Variables:
// eval: (read-only-mode 1)
// End:
