import CoreGraphics

struct AbsoluteRotation: RawRepresentable {  
  static let zero = Self(uncheckedRawValue: .zero)
  
  typealias RawValue = Float
  
  private(set) var rawValue: Float
  
  var positiveHalfRotations: Float {
    rawValue.positiveRepresentation(forModuloBy: 2.0)
  }
  
  var balancedHalfRotations: Float {
    let positiveHalfRotations = self.positiveHalfRotations
    return switch positiveHalfRotations > 1.0  {
    case false:
      positiveHalfRotations
    case true:
      -1.0 + (positiveHalfRotations - 1.0)
    }
  }
  
  init?(rawValue: RawValue) {
    assert(rawValue.isFinite)
    guard (0.0..<2.0).contains(rawValue) else {
      return nil
    }
    self.rawValue = rawValue
  }
  
  init(uncheckedRawValue rawValue: RawValue) {
    assert(rawValue.isFinite)
    assert((0.0..<2.0).contains(rawValue))
    self.rawValue = rawValue
  }
    
}

extension AbsoluteRotation: Sendable { }
extension AbsoluteRotation: Equatable { }
extension AbsoluteRotation: Hashable { }

extension AbsoluteRotation {
  
  func rotated(by relativeRotation: RelativeRotation) -> AbsoluteRotation {
    AbsoluteRotation(
      uncheckedRawValue: (rawValue + relativeRotation.rawValue).positiveRepresentation(forModuloBy: 2.0)
    )
  }
  
  var sineCosine: (sine: Float, cosine: Float) {
    let values = __sincospif_stret(rawValue)
    return (
      sine: values.__sinval,
      cosine: values.__cosval
    )
  }
  
}

extension FloatingPoint {
  
  func positiveRepresentation(forModuloBy modulus: Self) -> Self {
    assert(modulus > 0)
    let remainder = self.remainder(dividingBy: modulus)
    return switch remainder >= 0  {
    case true:
      remainder
    case false:
      modulus + remainder
    }
  }
  
}
