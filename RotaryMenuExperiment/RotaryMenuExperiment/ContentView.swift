import SwiftUI

//struct RotaryMenuItem: Hashable, Identifiable {
//  var icon: Image
//}

/*
 var rotaryOffsetWhenContracted: RelativeRotation = .zero
 var rotaryOffsetWhenExpanded: RelativeRotation = .zero
 var itemRingRadiusWhenExpanded: CGFloat = 44.0
 var itemRingRadiusWhenContracted: CGFloat = 16.0
 var itemRadiusWhenExpanded: CGFloat = 26.0
 var itemRadiusWhenContracted: CGFloat = 12.0
 var centerItemRadiusWhenExpanded: CGFloat = 22.0
 var centerItemRadiuswhenContracted: CGFloat = 32.0
 var neutralRotationFromZero: RelativeRotation = .zero
 */


@Animatable
struct ContentView: View {
  
  @State
  private var rotaryMenuParameters: RotaryMenuLayoutParameters
  
  init(rotaryMenuParameters: RotaryMenuLayoutParameters = RotaryMenuLayoutParameters()) {
    self.rotaryMenuParameters = rotaryMenuParameters
  }
  
  @State
  private var expansionLevel: CGFloat = 0.0
  
  @AnimatableIgnored
  @State
  private var windingCount: CGFloat = 1.0
  
  @AnimatableIgnored
  @State
  private var itemCount: Int = 7

  @AnimatableIgnored
  @State
  private var isAnimatingLoop: Bool = false
  
  @AnimatableIgnored
  @State
  private var activeAnimationTask: Task<Void, Never>? = nil

  var body: some View {
    Group {
      VStack(alignment: .center) {
        HStack(alignment: .firstTextBaseline) {
          GroupBox("Item Parameters") {
            LabeledContent(
              "Item Count"
            ) {
              Stepper(
                value: $itemCount,
                in: 1...12
              ) {
                Text(verbatim: "\(itemCount)")
              }
            }
            LabeledContent(
              "Wind Count"
            ) {
              Stepper(
                value: $windingCount,
                in: 1.0...7.0
              ) {
                Text(verbatim: "\(Int(windingCount))")
              }
            }
          }
          RangePairControlView<CGFloat>(
            titleKey: "Ring Radius",
            lowerBound: $rotaryMenuParameters.itemRingRadiusWhenContracted,
            upperBound: $rotaryMenuParameters.itemRingRadiusWhenExpanded,
            increment: 1.0,
            validRange: 0.0...256.0,
            formatting: { String(format: "%.1f", $0) }
          )
          RangePairControlView<CGFloat>(
            titleKey: "Center Item Radius",
            lowerBoundTitle: "Expanded:",
            upperBoundTitle: "Contracted:",
            lowerBound: $rotaryMenuParameters.centerItemRadiusWhenExpanded,
            upperBound: $rotaryMenuParameters.centerItemRadiuswhenContracted,
            increment: 1.0,
            validRange: 0.0...256.0,
            formatting: { String(format: "%.1f", $0) }
          )
          RangePairControlView<CGFloat>(
            titleKey: "Ring Item Radius",
            lowerBound: $rotaryMenuParameters.itemRadiusWhenContracted,
            upperBound: $rotaryMenuParameters.itemRadiusWhenExpanded,
            increment: 1.0,
            validRange: 0.0...256.0,
            formatting: { String(format: "%.1f", $0) }
          )
        }
        GroupBox("Expansion State") {
          VStack {
            HStack(alignment: .firstTextBaseline) {
              Button("Contract") {
                withAnimation(.interpolatingSpring(duration: 2.0)) {
                  expansionLevel = 0.0
                }
              }
              Spacer()
              VStack {
                Text("Expansion Level: \(expansionLevel)")
              }
              Spacer()
              Button("Expand") {
                withAnimation(.interpolatingSpring(duration: 2.0)) {
                  expansionLevel = 1.0
                }
              }
            }
            Slider(value: $expansionLevel, in: 0...1)
          }.scaledToFit()
        }
        ZStack {
          Color.pink
          RotaryMenuView(
            windCount: windingCount,
            layoutParameters: rotaryMenuParameters,
            expansionLevel: expansionLevel,
            ringItems: (1...itemCount),
            ringItemToIdentifier: \.self
          ) {
            Image(systemName: "xmark.circle")
              .resizable()
          } ringItem: { itemIndex in
            Image(systemName: "person")
              .resizable()
          }
        }.fixedSize()
        Spacer()
        Button {
          switch isAnimatingLoop {
          case true:
            isAnimatingLoop = false
            activeAnimationTask = nil
          case false:
            isAnimatingLoop = true
            activeAnimationTask = nil
            enqueueNextAnimationIfNecessary()
          }
        } label: {
          switch isAnimatingLoop {
          case true:
            Text("Stop Looping")
          case false:
            Text("Start Looping")
          }
        }
      }
      .scaledToFill()
    }
    .id("root")
    .padding()
  }
  
  private func enqueueNextAnimationIfNecessary() {
    guard
      isAnimatingLoop,
      activeAnimationTask == nil
    else {
      return
    }
        
    let taskName: String
    let targetExpansionLevel: CGFloat
    switch expansionLevel < 0.5 {
    case true:
      taskName = "Expand (loop)"
      targetExpansionLevel = 1.0
    case false:
      taskName = "Contract (loop)"
      targetExpansionLevel = 0.0
    }
    
    activeAnimationTask = Task(name: taskName) {
      withAnimation(.interactiveSpring(duration: TimeInterval.random(in: 0.25...3.0))) {
        expansionLevel = targetExpansionLevel
      } completion: {
        activeAnimationTask = nil
        enqueueNextAnimationIfNecessary()
      }
    }
  }
}

#Preview {
  ContentView()
}

