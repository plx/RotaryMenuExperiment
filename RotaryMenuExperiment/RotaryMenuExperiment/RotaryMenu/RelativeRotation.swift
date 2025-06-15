import SwiftUI

struct RelativeRotation: RawRepresentable {
  typealias RawValue = Float
  
  private(set) var rawValue: Float
  
  var halfRotations: Float {
    get { rawValue }
    set { rawValue = newValue }
  }
  
  init(rawValue: RawValue) {
    assert(rawValue.isFinite)
    self.rawValue = rawValue
  }
  
  static func completeRotation(count: some BinaryInteger) -> Self {
    return Self(rawValue: 2.0 * RawValue(count))
  }

  static func completeRotation(count: some BinaryFloatingPoint) -> Self {
    return Self(rawValue: 2.0 * RawValue(count))
  }

  static func incrementalRotation(forStepCount stepCount: Int) -> Self {
    assert(stepCount > 0)
    let completeRotation: RawValue = 2.0
    return Self(rawValue: completeRotation / Float(stepCount))
  }
  
  var equivalentAbsoluteRotation: AbsoluteRotation {
    AbsoluteRotation(uncheckedRawValue: rawValue.positiveRepresentation(forModuloBy: 2.0))
  }
}

extension RelativeRotation: Sendable { }
extension RelativeRotation: Equatable { }
extension RelativeRotation: Hashable { }

extension RelativeRotation: Comparable {
  
  static func < (
    lhs: Self,
    rhs: Self
  ) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
  
}

extension RelativeRotation: AdditiveArithmetic {
  
  static let zero = Self(rawValue: .zero)
  
  static func + (lhs: Self, rhs: Self) -> Self {
    Self(rawValue: lhs.rawValue + rhs.rawValue)
  }
  
  static func += (lhs: inout Self, rhs: Self) {
    lhs.rawValue += rhs.rawValue
  }
  
  static func - (lhs: Self, rhs: Self) -> Self {
    Self(rawValue: lhs.rawValue - rhs.rawValue)
  }
  
  static func -= (lhs: inout Self, rhs: Self) {
    lhs.rawValue -= rhs.rawValue
  }

}

extension RelativeRotation: VectorArithmetic {

  mutating func scale(by rhs: Double) {
    rawValue *= RawValue(rhs)
  }
  
  var magnitudeSquared: Double {
    let doubleRepresentation = Double(rawValue)
    return doubleRepresentation * doubleRepresentation
  }

}

extension RelativeRotation {
  
  static func * <Factor> (lhs: Self, factor: Factor) -> Self where Factor: BinaryFloatingPoint {
    Self(rawValue: lhs.rawValue * RawValue(factor))
  }

  static func * <Factor> (factor: Factor, rhs: Self) -> Self where Factor: BinaryFloatingPoint {
    Self(rawValue: rhs.rawValue * RawValue(factor))
  }

  static func *= <Factor> (lhs: inout Self, factor: Factor) where Factor: BinaryFloatingPoint {
    lhs.rawValue *= RawValue(factor)
  }

  static func / <Factor> (lhs: Self, factor: Factor) -> Self where Factor: BinaryFloatingPoint {
    Self(rawValue: lhs.rawValue / RawValue(factor))
  }
  
  static func /= <Factor> (lhs: inout Self, factor: Factor) where Factor: BinaryFloatingPoint {
    lhs.rawValue /= RawValue(factor)
  }

}

extension RelativeRotation {
  
  static func * <Factor> (lhs: Self, factor: Factor) -> Self where Factor: BinaryInteger {
    Self(rawValue: lhs.rawValue * RawValue(factor))
  }
  
  static func * <Factor> (factor: Factor, rhs: Self) -> Self where Factor: BinaryInteger {
    Self(rawValue: rhs.rawValue * RawValue(factor))
  }

  static func *= <Factor> (lhs: inout Self, factor: Factor) where Factor: BinaryInteger {
    lhs.rawValue *= RawValue(factor)
  }
  
  static func / <Factor> (lhs: Self, factor: Factor) -> Self where Factor: BinaryInteger {
    Self(rawValue: lhs.rawValue / RawValue(factor))
  }
  
  static func /= <Factor> (lhs: inout Self, factor: Factor) where Factor: BinaryInteger {
    lhs.rawValue /= RawValue(factor)
  }
  
}

