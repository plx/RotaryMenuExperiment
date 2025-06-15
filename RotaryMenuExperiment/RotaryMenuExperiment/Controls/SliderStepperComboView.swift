import SwiftUI

extension Binding {
  
  func bidirectionalMap<V>(
    forward transform: @escaping (Value) -> V,
    reverse inverseTransform: @escaping (V) -> Value
  ) -> Binding<V> {
    .init(
      get: { transform(wrappedValue) },
      set: { wrappedValue = inverseTransform($0) }
    )
  }
}

struct SliderStepperComboView<T:BinaryFloatingPoint, V: Comparable & AdditiveArithmetic>: View where T.Stride: BinaryFloatingPoint {
  
  private let titleKey: LocalizedStringKey
  private let value: Binding<V>
  private let increment: V
  private let validRange: ClosedRange<V>
  private let mappedValidRange: ClosedRange<T>
  private let formatting: (V) -> String
  private let mappedBinding: Binding<T>

  init(
    titleKey: LocalizedStringKey,
    value: Binding<V>,
    increment: V,
    validRange: ClosedRange<V>,
    formatting: @escaping (V) -> String,
    forward: @escaping (V) -> T,
    reverse: @escaping (T) -> V
  ) {
    self.titleKey = titleKey
    self.value = value
    self.increment = increment
    self.validRange = validRange
    self.formatting = formatting
    self.mappedBinding = value.bidirectionalMap(
      forward: forward,
      reverse: reverse
    )
    self.mappedValidRange = forward(validRange.lowerBound)...forward(validRange.upperBound)
  }
  
  var body: some View {
    LabeledContent(titleKey) {
      HStack(alignment: .firstTextBaseline) {
        Slider(
          value: mappedBinding,
          in: mappedValidRange,
        )
        Stepper {
          Text(verbatim: formatting(value.wrappedValue))
        } onIncrement: {
          withAnimation {
            let nextValue = value.wrappedValue + increment
            guard
              validRange.contains(nextValue)
            else {
              return
            }
            value.wrappedValue = nextValue
          }
        } onDecrement: {
          withAnimation {
            let nextValue = value.wrappedValue - increment
            guard
              validRange.contains(nextValue)
            else {
              return
            }
            value.wrappedValue = nextValue
          }
        }.alignmentGuide(.rangePairStepperAlignment) {
          $0[.trailing]
        }
      }
    }
  }
  
}

extension SliderStepperComboView where V == RelativeRotation, V.RawValue == T {
  
  init(
    titleKey: LocalizedStringKey,
    value: Binding<RelativeRotation>,
    increment: RelativeRotation,
    validRange: ClosedRange<RelativeRotation>,
    formatting: @escaping (V) -> String
  ) {
    self.init(
      titleKey: titleKey,
      value: value,
      increment: increment,
      validRange: validRange,
      formatting: formatting,
      forward: {$0.rawValue},
      reverse: { RelativeRotation(rawValue: $0) }
    )
  }

}


extension SliderStepperComboView where T == V {
  
  init(
    titleKey: LocalizedStringKey,
    value: Binding<V>,
    increment: V,
    validRange: ClosedRange<V>,
    formatting: @escaping (V) -> String
  ) {
    self.init(
      titleKey: titleKey,
      value: value,
      increment: increment,
      validRange: validRange,
      formatting: formatting,
      forward: { $0 },
      reverse: { $0 }
    )
  }
  
}
