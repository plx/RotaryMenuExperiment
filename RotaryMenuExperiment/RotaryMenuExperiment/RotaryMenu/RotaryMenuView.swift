import SwiftUI

@Animatable
struct RotaryMenuView<
  CenterItemView: View,
  RingItemView: View,
  RingItems,
  RingItem,
  RingItemIdentifier: Hashable
>: View where
  RingItems: RandomAccessCollection<RingItem>
{

  let windCount: CGFloat
  var layoutParameters: RotaryMenuLayoutParameters
  var expansionLevel: CGFloat
  
  let centerItemView: () -> CenterItemView
  let ringItems: RingItems
  let ringItemToIdentifier: KeyPath<RingItem, RingItemIdentifier>
  let ringItemToView: (RingItem) -> RingItemView
  
  @AnimatableIgnored
  @Namespace
  private var namespace
  
  private init(
    windCount: CGFloat,
    layoutParameters: RotaryMenuLayoutParameters,
    expansionLevel: CGFloat,
    centerItemView: @escaping () -> CenterItemView,
    ringItems: RingItems,
    ringItemToIdentifier: KeyPath<RingItem, RingItemIdentifier>,
    ringItemToView: @escaping (RingItem) -> RingItemView
  ) {
    self.windCount = windCount
    self.layoutParameters = layoutParameters
    self.expansionLevel = expansionLevel
    
    self.centerItemView = centerItemView
    self.ringItems = ringItems
    self.ringItemToIdentifier = ringItemToIdentifier
    self.ringItemToView = ringItemToView
  }
  
  init(
    windCount: CGFloat,
    layoutParameters: RotaryMenuLayoutParameters,
    expansionLevel: CGFloat,
    ringItems: RingItems,
    ringItemToIdentifier: KeyPath<RingItem, RingItemIdentifier>,
    @ViewBuilder centerItem: @escaping () -> CenterItemView,
    @ViewBuilder ringItem: @escaping (RingItem) -> RingItemView
  ) {
    self.init(
      windCount: windCount,
      layoutParameters: layoutParameters,
      expansionLevel: expansionLevel,
      centerItemView: centerItem,
      ringItems: ringItems,
      ringItemToIdentifier: ringItemToIdentifier,
      ringItemToView: ringItem
    )
  }
  
  init(
    windCount: CGFloat,
    layoutParameters: RotaryMenuLayoutParameters,
    expansionLevel: CGFloat,
    ringItems: RingItems,
    @ViewBuilder centerItem: @escaping () -> CenterItemView,
    @ViewBuilder ringItem: @escaping (RingItem) -> RingItemView
  ) where RingItem: Identifiable, RingItem.ID == RingItemIdentifier {
    self.init(
      windCount: windCount,
      layoutParameters: layoutParameters,
      expansionLevel: expansionLevel,
      centerItemView: centerItem,
      ringItems: ringItems,
      ringItemToIdentifier: \.id,
      ringItemToView: ringItem
    )
  }
  
  // note sure how many distinct IDs we atually need;
  // currently I use:
  //
  // - tag: gets read by the layout (but only for center-item view ATM)
  // - id: not sure it's even needed?
  // - matchedGeometryEffect: not sure it's even needed?
  // - glassEffectID:
  //   - AIUI, this plays 1, maybe 2 distinct roles:
  //   - definitely: identifies *which* "glass-effect" this view is a part of
  //   - maybe: identifies "the same view' across view-hierarchy updates (which happen a lot due to the layout getting rebuilt)?
  var body: some View {
    GlassEffectContainer(spacing: 16.0) {
      RotaryMenuLayout<RingItemIdentifier>(
        windingCount: windCount,
        parameters: layoutParameters,
        expansionLevel: expansionLevel
      ) {
        centerItemView()
          .tag(RotaryMenuComponentIdentifier<RingItemIdentifier>.center)
          .id(RotaryMenuComponentIdentifier<RingItemIdentifier>.center)
//          .matchedGeometryEffect(
//            id: RotaryMenuComponentIdentifier<RingItemIdentifier>.center,
//            in: namespace
//          )
          .padding()
          .glassEffect(
            .regular.interactive(),
            in: .circle
          )
          .glassEffectID(
            RotaryMenuComponentIdentifier<RingItemIdentifier>.center,
            in: namespace
          )
          .glassEffectTransition(.identity)
        
        ForEach(
          ringItems,
          id: ringItemToIdentifier
        ) { ringItem in
          ringItemToView(ringItem)
            .tag(RotaryMenuComponentIdentifier<RingItemIdentifier>.ringItem(ringItem[keyPath: ringItemToIdentifier]))
            .id(RotaryMenuComponentIdentifier<RingItemIdentifier>.ringItem(ringItem[keyPath: ringItemToIdentifier]))
//            .matchedGeometryEffect(
//              id: RotaryMenuComponentIdentifier<RingItemIdentifier>.ringItem(ringItem[keyPath: ringItemToIdentifier]),
//              in: namespace
//            )
            .padding()
            .glassEffect(
              .regular.interactive(),
              in: .circle
            )
            .glassEffectID(
              RotaryMenuComponentIdentifier<RingItemIdentifier>.ringItem(ringItem[keyPath: ringItemToIdentifier]),
              in: namespace
            )
            .glassEffectTransition(.identity)
        }
      }
    }
  }
}
