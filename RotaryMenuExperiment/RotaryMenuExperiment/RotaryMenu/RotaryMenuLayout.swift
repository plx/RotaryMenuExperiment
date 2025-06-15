import SwiftUI

extension ContainerValues {
  @Entry 
  var centerForRotaryMenuLayout: UnitPoint = .center
}

enum RotaryMenuComponentIdentifier<ItemIdentifier> where ItemIdentifier: Sendable & Hashable {
  case center
  case ringItem(ItemIdentifier)
}

extension RotaryMenuComponentIdentifier: Sendable { }
extension RotaryMenuComponentIdentifier: Equatable { }
extension RotaryMenuComponentIdentifier: Hashable { }

// this is done manually b/c the `@Animatable` macro generated non-compiling
// code when used to synthesize the equivalent -- seems to generate some code
// that trips over the "too complex to typecheck in a reasonable time" problem
struct RotaryMenuLayoutParameters {
  var rotaryOffsetWhenContracted: RelativeRotation = .zero
  var rotaryOffsetWhenExpanded: RelativeRotation = .zero
  var itemRingRadiusWhenExpanded: CGFloat = 80.0
  var itemRingRadiusWhenContracted: CGFloat = 0.0
  var itemRadiusWhenExpanded: CGFloat = 44.0
  var itemRadiusWhenContracted: CGFloat = 11.0
  var centerItemRadiusWhenExpanded: CGFloat = 44.0
  var centerItemRadiuswhenContracted: CGFloat = 56.0
  var neutralRotationFromZero: RelativeRotation = .zero
  
  init() {
    
  }
  
  init(
    rotaryOffsetWhenContracted: RelativeRotation,
    rotaryOffsetWhenExpanded: RelativeRotation,
    itemRingRadiusWhenExpanded: CGFloat,
    itemRingRadiusWhenContracted: CGFloat,
    itemRadiusWhenExpanded: CGFloat,
    itemRadiusWhenContracted: CGFloat,
    centerItemRadiusWhenExpanded: CGFloat,
    centerItemRadiuswhenContracted: CGFloat,
    neutralRotationFromZero: RelativeRotation
  ) {
    self.rotaryOffsetWhenContracted = rotaryOffsetWhenContracted
    self.rotaryOffsetWhenExpanded = rotaryOffsetWhenExpanded
    self.itemRingRadiusWhenExpanded = itemRingRadiusWhenExpanded
    self.itemRingRadiusWhenContracted = itemRingRadiusWhenContracted
    self.itemRadiusWhenExpanded = itemRadiusWhenExpanded
    self.itemRadiusWhenContracted = itemRadiusWhenContracted
    self.centerItemRadiusWhenExpanded = centerItemRadiusWhenExpanded
    self.centerItemRadiuswhenContracted = centerItemRadiuswhenContracted
    self.neutralRotationFromZero = neutralRotationFromZero
  }
}

extension RotaryMenuLayoutParameters: Equatable { }
extension RotaryMenuLayoutParameters: Hashable { }

extension RotaryMenuLayoutParameters: AdditiveArithmetic {
  
  static let zero: RotaryMenuLayoutParameters = RotaryMenuLayoutParameters(
    rotaryOffsetWhenContracted: .zero,
    rotaryOffsetWhenExpanded: .zero,
    itemRingRadiusWhenExpanded: .zero,
    itemRingRadiusWhenContracted: .zero,
    itemRadiusWhenExpanded: .zero,
    itemRadiusWhenContracted: .zero,
    centerItemRadiusWhenExpanded: .zero,
    centerItemRadiuswhenContracted: .zero,
    neutralRotationFromZero: .zero
  )
  
  static func + (lhs: Self, rhs: Self) -> Self {
    Self(
      rotaryOffsetWhenContracted: lhs.rotaryOffsetWhenContracted + rhs.rotaryOffsetWhenContracted,
      rotaryOffsetWhenExpanded: lhs.rotaryOffsetWhenExpanded + rhs.rotaryOffsetWhenExpanded,
      itemRingRadiusWhenExpanded: lhs.itemRingRadiusWhenExpanded + rhs.itemRingRadiusWhenExpanded,
      itemRingRadiusWhenContracted: lhs.itemRingRadiusWhenContracted + rhs.itemRingRadiusWhenContracted,
      itemRadiusWhenExpanded: lhs.itemRadiusWhenExpanded + rhs.itemRadiusWhenExpanded,
      itemRadiusWhenContracted: lhs.itemRadiusWhenContracted + rhs.itemRadiusWhenContracted,
      centerItemRadiusWhenExpanded: lhs.centerItemRadiusWhenExpanded + rhs.centerItemRadiusWhenExpanded,
      centerItemRadiuswhenContracted: lhs.centerItemRadiuswhenContracted + rhs.centerItemRadiuswhenContracted,
      neutralRotationFromZero: lhs.neutralRotationFromZero + rhs.neutralRotationFromZero
    )
  }

  static func += (lhs: inout Self, rhs: Self) {
    lhs.rotaryOffsetWhenContracted += rhs.rotaryOffsetWhenContracted
    lhs.rotaryOffsetWhenExpanded += rhs.rotaryOffsetWhenExpanded
    lhs.itemRingRadiusWhenExpanded += rhs.itemRingRadiusWhenExpanded
    lhs.itemRingRadiusWhenContracted += rhs.itemRingRadiusWhenContracted
    lhs.itemRadiusWhenExpanded += rhs.itemRadiusWhenExpanded
    lhs.itemRadiusWhenContracted += rhs.itemRadiusWhenContracted
    lhs.centerItemRadiusWhenExpanded += rhs.centerItemRadiusWhenExpanded
    lhs.centerItemRadiuswhenContracted += rhs.centerItemRadiuswhenContracted
    lhs.neutralRotationFromZero += rhs.neutralRotationFromZero
  }
  
  static func - (lhs: Self, rhs: Self) -> Self {
    Self(
      rotaryOffsetWhenContracted: lhs.rotaryOffsetWhenContracted - rhs.rotaryOffsetWhenContracted,
      rotaryOffsetWhenExpanded: lhs.rotaryOffsetWhenExpanded - rhs.rotaryOffsetWhenExpanded,
      itemRingRadiusWhenExpanded: lhs.itemRingRadiusWhenExpanded - rhs.itemRingRadiusWhenExpanded,
      itemRingRadiusWhenContracted: lhs.itemRingRadiusWhenContracted - rhs.itemRingRadiusWhenContracted,
      itemRadiusWhenExpanded: lhs.itemRadiusWhenExpanded - rhs.itemRadiusWhenExpanded,
      itemRadiusWhenContracted: lhs.itemRadiusWhenContracted - rhs.itemRadiusWhenContracted,
      centerItemRadiusWhenExpanded: lhs.centerItemRadiusWhenExpanded - rhs.centerItemRadiusWhenExpanded,
      centerItemRadiuswhenContracted: lhs.centerItemRadiuswhenContracted - rhs.centerItemRadiuswhenContracted,
      neutralRotationFromZero: lhs.neutralRotationFromZero - rhs.neutralRotationFromZero
    )
  }
  
  static func -= (lhs: inout Self, rhs: Self) {
    lhs.rotaryOffsetWhenContracted -= rhs.rotaryOffsetWhenContracted
    lhs.rotaryOffsetWhenExpanded -= rhs.rotaryOffsetWhenExpanded
    lhs.itemRingRadiusWhenExpanded -= rhs.itemRingRadiusWhenExpanded
    lhs.itemRingRadiusWhenContracted -= rhs.itemRingRadiusWhenContracted
    lhs.itemRadiusWhenExpanded -= rhs.itemRadiusWhenExpanded
    lhs.itemRadiusWhenContracted -= rhs.itemRadiusWhenContracted
    lhs.centerItemRadiusWhenExpanded -= rhs.centerItemRadiusWhenExpanded
    lhs.centerItemRadiuswhenContracted -= rhs.centerItemRadiuswhenContracted
    lhs.neutralRotationFromZero -= rhs.neutralRotationFromZero
  }

}

extension RotaryMenuLayoutParameters: VectorArithmetic {
  
  var magnitudeSquared: Double {
    var magnitudeSquared: Double = 0
    magnitudeSquared += rotaryOffsetWhenContracted.magnitudeSquared
    magnitudeSquared += rotaryOffsetWhenExpanded.magnitudeSquared
    magnitudeSquared += itemRingRadiusWhenExpanded.magnitudeSquared
    magnitudeSquared += itemRingRadiusWhenContracted.magnitudeSquared
    magnitudeSquared += itemRadiusWhenExpanded.magnitudeSquared
    magnitudeSquared += itemRadiusWhenContracted.magnitudeSquared
    magnitudeSquared += centerItemRadiusWhenExpanded.magnitudeSquared
    magnitudeSquared += centerItemRadiuswhenContracted.magnitudeSquared
    magnitudeSquared += neutralRotationFromZero.magnitudeSquared
    return magnitudeSquared
  }
  
  mutating func scale(by rhs: Double) {
    rotaryOffsetWhenContracted.scale(by: rhs)
    rotaryOffsetWhenExpanded.scale(by: rhs)
    itemRingRadiusWhenExpanded.scale(by: rhs)
    itemRingRadiusWhenContracted.scale(by: rhs)
    itemRadiusWhenExpanded.scale(by: rhs)
    itemRadiusWhenContracted.scale(by: rhs)
    centerItemRadiusWhenExpanded.scale(by: rhs)
    centerItemRadiuswhenContracted.scale(by: rhs)
    neutralRotationFromZero.scale(by: rhs)
  }
  
}

@Animatable
struct RotaryMenuLayout<Identifier>: Layout where Identifier: Hashable {
  typealias ComponentIdentifier = RotaryMenuComponentIdentifier<Identifier>

  var rotaryOffsetWhenContracted: RelativeRotation {
    rotaryMenuLayoutParameters.rotaryOffsetWhenContracted
  }
  
  var rotaryOffsetWhenExpanded: RelativeRotation {
    rotaryMenuLayoutParameters.rotaryOffsetWhenExpanded
  }
  
  var itemRingRadiusWhenExpanded: CGFloat {
    rotaryMenuLayoutParameters.itemRingRadiusWhenExpanded
  }
  
  var itemRingRadiusWhenContracted: CGFloat {
    rotaryMenuLayoutParameters.itemRingRadiusWhenContracted
  }
  
  var itemRadiusWhenExpanded: CGFloat {
    rotaryMenuLayoutParameters.itemRadiusWhenExpanded
  }
  
  var itemRadiusWhenContracted: CGFloat {
    rotaryMenuLayoutParameters.itemRadiusWhenContracted
  }
  
  var centerItemRadiusWhenExpanded: CGFloat {
    rotaryMenuLayoutParameters.centerItemRadiusWhenExpanded
  }
  
  var centerItemRadiuswhenContracted: CGFloat {
    rotaryMenuLayoutParameters.centerItemRadiuswhenContracted
  }
  
  var neutralRotationFromZero: RelativeRotation {
    rotaryMenuLayoutParameters.neutralRotationFromZero
  }
  
  var neutralRotation: AbsoluteRotation {
    neutralRotationFromZero.equivalentAbsoluteRotation
  }

  @AnimatableIgnored
  var rotaryWindingCount: CGFloat
  var rotaryExpansionLevel: CGFloat
  var rotaryMenuLayoutParameters: RotaryMenuLayoutParameters

  init(
    windingCount: CGFloat,
    parameters: RotaryMenuLayoutParameters,
    expansionLevel: CGFloat
  ) {
    self.rotaryWindingCount = windingCount
    self.rotaryMenuLayoutParameters = parameters
    self.rotaryExpansionLevel = expansionLevel
  }

  typealias Cache = Void
  
  func rotaryExpansionInterpolation(
    start: CGFloat,
    limit: CGFloat
  ) -> CGFloat {
    lerp(
      start: start,
      limit: limit,
      position: rotaryExpansionLevel
    )
  }
  
  func rotaryExpansionInterpolation(
    start: RelativeRotation,
    limit: RelativeRotation
  ) -> RelativeRotation {
    lerp(
      start: start,
      limit: limit,
      position: rotaryExpansionLevel
    )
  }
  

  var centerItemRadius: CGFloat {
    rotaryExpansionInterpolation(
      start: centerItemRadiuswhenContracted,
      limit: centerItemRadiusWhenExpanded
    )
  }
  
  var innerRingRadius: CGFloat {
    rotaryExpansionInterpolation(
      start: itemRingRadiusWhenContracted,
      limit: itemRingRadiusWhenExpanded
    )
  }
  
  var ringItemRadius: CGFloat {
    rotaryExpansionInterpolation(
      start: itemRadiusWhenContracted,
      limit: itemRadiusWhenExpanded
    )
  }
  
  var outerRingRadius: CGFloat {
    innerRingRadius + 2.0 * ringItemRadius
  }
  
  var itemPlacementRadius: CGFloat {
    innerRingRadius + ringItemRadius
  }
  
  var windingRotationContribution: RelativeRotation {
    rotaryExpansionInterpolation(
      start: .zero,
      limit: .completeRotation(
        count: rotaryWindingCount
      )
    )
  }

  var offsetRotationContribution: RelativeRotation {
    rotaryExpansionInterpolation(
      start: rotaryOffsetWhenContracted,
      limit: rotaryOffsetWhenExpanded
    )
  }
  
  var commonRingItemRotation: RelativeRotation {
    windingRotationContribution + offsetRotationContribution
  }
  
  func sizeThatFits(
    proposal: ProposedViewSize,
    subviews: Subviews,
    cache: inout Cache
  ) -> CGSize {
    let effectiveRadius = Swift.max(
      centerItemRadiusWhenExpanded,
      centerItemRadiuswhenContracted,
      itemRadiusWhenExpanded + itemRingRadiusWhenExpanded
    )
    
    return CGSize(
      width: 3.0 * effectiveRadius,
      height: 3.0 * effectiveRadius
    )
  }
  
  func placeSubviews(
    in bounds: CGRect,
    proposal: ProposedViewSize,
    subviews: Self.Subviews,
    cache: inout Self.Cache
  ) {
    guard
      let ringMenuLayoutSubviews = RingMenuLayoutSubviews<Identifier>(layoutSubviews: subviews)
    else {
      return // lol
    }
    let centerPoint = CGPoint(
      x: bounds.midX,
      y: bounds.midY
    )
    
    placeLayoutSubview(
      ringMenuLayoutSubviews.centerItemSubview,
      center: centerPoint,
      radius: centerItemRadius
    )
    
    guard !ringMenuLayoutSubviews.ringItemSubviews.isEmpty else {
      return
    }
    
    let interItemRadialStep = RelativeRotation.incrementalRotation(forStepCount: ringMenuLayoutSubviews.ringItemSubviews.count)
    let commonRingItemRotation = self.commonRingItemRotation
    let ringItemRadius = self.ringItemRadius
    let innerRingRadius = self.innerRingRadius
    let ringItemCenterRadius = ringItemRadius + innerRingRadius
    for (index, ringItemSubview) in ringMenuLayoutSubviews.ringItemSubviews.enumerated() {
      placeLayoutSubview(
        ringItemSubview,
        center: CGPoint(
          radiallyOffsetFrom: centerPoint,
          radius: ringItemCenterRadius,
          rotatedFrom: neutralRotation,
          by: commonRingItemRotation + (index * interItemRadialStep)
        ),
        radius: ringItemRadius
      )
    }
  }
  
  func placeLayoutSubview(
    _ layoutSubview: LayoutSubview,
    center: CGPoint,
    radius: CGFloat
  ) {
    layoutSubview.place(
      at: center,
      anchor: layoutSubview.containerValues.centerForRotaryMenuLayout,
      proposal: ProposedViewSize(
        width: 2.0 * radius,
        height: 2.0 * radius
      )
    )
  }
  
}

extension LayoutSubviews {
  
  func centerItemForRotaryMenu<ItemIdentifier>(
    itemIdentifier: ItemIdentifier.Type
  ) -> LayoutSubview? where ItemIdentifier: Hashable {
    first(
      where: { layoutSubview in
        .center ==  layoutSubview
          .containerValues
          .tag(for: RotaryMenuComponentIdentifier<ItemIdentifier>.self)
      }
    )
  }
  
}

struct RingMenuLayoutSubviews<ItemIdentifier> where ItemIdentifier: Hashable {
  var centerItemSubview: LayoutSubview
  var ringItemSubviews: [LayoutSubview]
  
  init(centerItemSubview: LayoutSubview, ringItemSubviews: [LayoutSubview]) {
    self.centerItemSubview = centerItemSubview
    self.ringItemSubviews = ringItemSubviews
  }
  
  init?(layoutSubviews: LayoutSubviews) {
    var centerItemSubview: LayoutSubview?
    var ringItemSubviews: [LayoutSubview] = []
    for layoutSubview in layoutSubviews {
      guard
        let componentIdentifier = layoutSubview.containerValues.tag(for: RotaryMenuComponentIdentifier<ItemIdentifier>.self)
      else {
        continue
      }
      
      switch componentIdentifier {
      case .center:
        centerItemSubview = layoutSubview
      case .ringItem:
        ringItemSubviews.append(layoutSubview)
      }
    }
    
    guard let centerItemSubview else {
      return nil
    }
    
    self.init(
      centerItemSubview: centerItemSubview,
      ringItemSubviews: ringItemSubviews
    )
  }
}

func lerp<T>(
  start: T,
  limit: T,
  position: T
) -> T where T: BinaryFloatingPoint {
  start + ((limit - start) * position)
}

func lerp<T>(
  start: RelativeRotation,
  limit: RelativeRotation,
  position: T
) -> RelativeRotation where T: BinaryFloatingPoint {
  start + ((limit - start) * position)
}
