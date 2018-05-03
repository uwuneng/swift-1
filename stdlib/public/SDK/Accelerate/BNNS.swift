// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/Accelerate/BNNS.swift.gyb", line: 1)
//===----------------------------------------------------------------------===//
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

import Swift
@_exported import Accelerate
@_exported import Accelerate.vecLib.BNNS

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/Accelerate/BNNS.swift.gyb", line: 57)

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSDataType {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var float16: BNNSDataType {
    return __BNNSDataTypeFloat16
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var float: BNNSDataType {
    return __BNNSDataTypeFloat32
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var int8: BNNSDataType {
    return __BNNSDataTypeInt8
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var int16: BNNSDataType {
    return __BNNSDataTypeInt16
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var int32: BNNSDataType {
    return __BNNSDataTypeInt32
  }
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static var uint8: BNNSDataType {
    return __BNNSDataTypeUInt8
  }
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static var uint16: BNNSDataType {
    return __BNNSDataTypeUInt16
  }
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static var uint32: BNNSDataType {
    return __BNNSDataTypeUInt32
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var indexed8: BNNSDataType {
    return __BNNSDataTypeIndexed8
  }
}
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSDataType.float16")
public var BNNSDataTypeFloat16 = __BNNSDataTypeFloat16
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSDataType.float")
public var BNNSDataTypeFloat32 = __BNNSDataTypeFloat32
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSDataType.int8")
public var BNNSDataTypeInt8 = __BNNSDataTypeInt8
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSDataType.int16")
public var BNNSDataTypeInt16 = __BNNSDataTypeInt16
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSDataType.int32")
public var BNNSDataTypeInt32 = __BNNSDataTypeInt32
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSDataType.indexed8")
public var BNNSDataTypeIndexed8 = __BNNSDataTypeIndexed8
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/Accelerate/BNNS.swift.gyb", line: 69)

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSPoolingFunction {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var max: BNNSPoolingFunction {
    return __BNNSPoolingFunctionMax
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var average: BNNSPoolingFunction {
    return __BNNSPoolingFunctionAverage
  }
}
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSPoolingFunction.max")
public var BNNSPoolingFunctionMax = __BNNSPoolingFunctionMax
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSPoolingFunction.average")
public var BNNSPoolingFunctionAverage = __BNNSPoolingFunctionAverage
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/Accelerate/BNNS.swift.gyb", line: 74)

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSActivationFunction {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var identity: BNNSActivationFunction {
    return __BNNSActivationFunctionIdentity
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var rectifiedLinear: BNNSActivationFunction {
    return __BNNSActivationFunctionRectifiedLinear
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var leakyRectifiedLinear: BNNSActivationFunction {
    return __BNNSActivationFunctionLeakyRectifiedLinear
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var sigmoid: BNNSActivationFunction {
    return __BNNSActivationFunctionSigmoid
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var tanh: BNNSActivationFunction {
    return __BNNSActivationFunctionTanh
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var scaledTanh: BNNSActivationFunction {
    return __BNNSActivationFunctionScaledTanh
  }
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var abs: BNNSActivationFunction {
    return __BNNSActivationFunctionAbs
  }
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static var linear: BNNSActivationFunction {
    return __BNNSActivationFunctionLinear
  }
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static var clamp: BNNSActivationFunction {
    return __BNNSActivationFunctionClamp
  }
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static var integerLinearSaturate: BNNSActivationFunction {
    return __BNNSActivationFunctionIntegerLinearSaturate
  }
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static var integerLinearSaturatePerChannel: BNNSActivationFunction {
    return __BNNSActivationFunctionIntegerLinearSaturatePerChannel
  }
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static var softmax: BNNSActivationFunction {
    return __BNNSActivationFunctionSoftmax
  }
}
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSActivationFunction.identity")
public var BNNSActivationFunctionIdentity = __BNNSActivationFunctionIdentity
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSActivationFunction.rectifiedLinear")
public var BNNSActivationFunctionRectifiedLinear = __BNNSActivationFunctionRectifiedLinear
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSActivationFunction.leakyRectifiedLinear")
public var BNNSActivationFunctionLeakyRectifiedLinear = __BNNSActivationFunctionLeakyRectifiedLinear
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSActivationFunction.sigmoid")
public var BNNSActivationFunctionSigmoid = __BNNSActivationFunctionSigmoid
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSActivationFunction.tanh")
public var BNNSActivationFunctionTanh = __BNNSActivationFunctionTanh
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSActivationFunction.scaledTanh")
public var BNNSActivationFunctionScaledTanh = __BNNSActivationFunctionScaledTanh
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSActivationFunction.abs")
public var BNNSActivationFunctionAbs = __BNNSActivationFunctionAbs
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/Accelerate/BNNS.swift.gyb", line: 89)

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSFlags {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var useClientPointer: BNNSFlags {
    return __BNNSFlagsUseClientPtr
  }
}
@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
@available(*, deprecated, renamed: "BNNSFlags.useClientPointer")
public var BNNSFlagsUseClientPtr = __BNNSFlagsUseClientPtr
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/SDK/Accelerate/BNNS.swift.gyb", line: 91)

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSImageStackDescriptor {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public init(width: Int,
              height: Int,
              channels: Int,
              row_stride: Int,
              image_stride: Int,
              data_type: BNNSDataType) {

    _precondition(data_type != .indexed8,
                  "Image stacks cannot use the indexed8 data type.")

    self.init(width: width,
              height: height,
              channels: channels,
              row_stride: row_stride,
              image_stride: image_stride,
              data_type: data_type,
              data_scale: 1,
              data_bias: 0)
  }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSVectorDescriptor {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public init(size: Int,
              data_type: BNNSDataType) {

    _precondition(data_type != .indexed8,
                  "Vectors cannot use the indexed8 data type.")

    self.init(size: size,
              data_type: data_type,
              data_scale: 1,
              data_bias: 0)
  }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSLayerData {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public init(data: UnsafeRawPointer?,
              data_type: BNNSDataType,
              data_scale: Float = 1,
              data_bias: Float = 0) {

    _precondition(data_type != .indexed8,
                  "This initializer cannot be used with the indexed8 data type; use BNNSLayerData.indexed8 instead.")

    self.init(data: data,
              data_type: data_type,
              data_scale: data_scale,
              data_bias: data_bias,
              data_table: nil)
  }

  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var zero: BNNSLayerData {
    return BNNSLayerData()
  }

  /// A BNNSLayerData object with the indexed8 data type.
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static func indexed8(data: UnsafePointer<Int8>?,
                              data_table: UnsafePointer<Float>)
                              -> BNNSLayerData {
    return BNNSLayerData(data: data,
                         data_type: .indexed8,
                         data_scale: 1, // unused
                         data_bias: 0, // unused
                         data_table: data_table)
  }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSActivation {

  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public init(function: BNNSActivationFunction,
              alpha: Float = .nan,
              beta: Float = .nan) {
    if #available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
      _precondition(function != .integerLinearSaturate,
                    "This initializer cannot be used with the integerLinearSaturate activation function; use BNNSActivation.integerLinearSaturate(scale:Int32, offset:Int32, shift:Int32) instead.")
      _precondition(function != .integerLinearSaturatePerChannel,
                    "This initializer cannot be used with the integerLinearSaturatePerChannel activation function; use BNNSActivation.integerLinearSaturatePerChannel(scale:UnsafePointer<Int32>, offset:UnsafePointer<Int32>, shift:UnsafePointer<Int32>) instead.")
    }
    self.init(function: function,
              alpha: alpha,
              beta: beta,
              iscale: 1,                // unused
              ioffset: 0,               // unused
              ishift: 0,                // unused
              iscale_per_channel: nil,  // unused
              ioffset_per_channel: nil, // unused
              ishift_per_channel: nil)  // unused
  }

  /// A BNNSActivation object that uses the identity activation function.
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public static var identity: BNNSActivation {
    return BNNSActivation(function: .identity)
  }

  /// A BNNSActivation object that uses the integerLinearSaturate
  /// activation function.
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static func integerLinearSaturate(
    scale: Int32 = 1,
    offset: Int32 = 0,
    shift: Int32 = 0)
    -> BNNSActivation {
    return BNNSActivation(function: .integerLinearSaturate,
                          alpha: .nan,     // unused
                          beta: .nan,      // unused
                          iscale: scale,
                          ioffset: offset,
                          ishift: shift,
                          iscale_per_channel: nil, // unused
                          ioffset_per_channel: nil,// unused
                          ishift_per_channel: nil) // unused
  }

  /// A BNNSActivation object that uses the integerLinearSaturatePerChannel
  /// activation function.
  ///
  /// `scale`, `offset`, and `shift` must each point to a buffer with count
  /// equal to the number of channels on which this activation object operates.
  @available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
  public static func integerLinearSaturatePerChannel(
    scale:  UnsafePointer<Int32>,
    offset: UnsafePointer<Int32>,
    shift:  UnsafePointer<Int32>)
    -> BNNSActivation {
    return BNNSActivation(function: .integerLinearSaturatePerChannel,
                          alpha: .nan,     // unused
                          beta: .nan,      // unused
                          iscale: 1,       // unused
                          ioffset: 0,      // unused
                          ishift: 0,       // unused
                          iscale_per_channel: scale,
                          ioffset_per_channel: offset,
                          ishift_per_channel: shift)
  }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSConvolutionLayerParameters {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public init(x_stride: Int,
              y_stride: Int,
              x_padding: Int,
              y_padding: Int,
              k_width: Int,
              k_height: Int,
              in_channels: Int,
              out_channels: Int,
              weights: BNNSLayerData) {
    self.init(x_stride: x_stride,
              y_stride: y_stride,
              x_padding: x_padding,
              y_padding: y_padding,
              k_width: k_width,
              k_height: k_height,
              in_channels: in_channels,
              out_channels: out_channels,
              weights: weights,
              bias: .zero,
              activation: .identity)
  }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSPoolingLayerParameters {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public init(x_stride: Int,
              y_stride: Int,
              x_padding: Int,
              y_padding: Int,
              k_width: Int,
              k_height: Int,
              in_channels: Int,
              out_channels: Int,
              pooling_function: BNNSPoolingFunction) {
    self.init(x_stride: x_stride,
              y_stride: y_stride,
              x_padding: x_padding,
              y_padding: y_padding,
              k_width: k_width,
              k_height: k_height,
              in_channels: in_channels,
              out_channels: out_channels,
              pooling_function: pooling_function,
              bias: .zero,
              activation: .identity)
  }
}

@available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
extension BNNSFullyConnectedLayerParameters {
  @available(macOS 10.12, iOS 10.0, tvOS 10.0, watchOS 3.0, *)
  public init(in_size: Int,
              out_size: Int,
              weights: BNNSLayerData) {
    self.init(in_size: in_size,
              out_size: out_size,
              weights: weights,
              bias: .zero,
              activation: .identity)
  }
}
