import CoreGraphics

extension CGPoint {
  
  init(
    radiallyOffsetFrom center: CGPoint,
    radius: CGFloat,
    absoluteRotation: AbsoluteRotation
  ) {
    let (sine, cosine) = absoluteRotation.sineCosine
    self.init(
      x: center.x + radius * CGFloat(cosine),
      y: center.y + radius * CGFloat(sine)
    )
  }
  
  init(
    radiallyOffsetFrom center: CGPoint,
    radius: CGFloat,
    rotatedFrom neutralRotation: AbsoluteRotation,
    by relativeRotation: RelativeRotation
  ) {
    self.init(
      radiallyOffsetFrom: center,
      radius: radius,
      absoluteRotation: neutralRotation.rotated(by: relativeRotation)
    )
  }
  
}
