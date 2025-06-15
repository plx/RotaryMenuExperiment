import SwiftUI

extension HorizontalAlignment {
  private enum RangePairStepperAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
      context[.trailing]
    }
  }
  
  
  /// A guide for aligning titles.
  static let rangePairStepperAlignment = HorizontalAlignment(
    RangePairStepperAlignment.self
  )
}

struct RangePairControlView<T:Comparable & AdditiveArithmetic>: View {
  
  private let titleKey: LocalizedStringKey
  private let lowerBoundTitle: LocalizedStringKey
  private let upperBoundTitle: LocalizedStringKey
  private let lowerBound: Binding<T>
  private let upperBound: Binding<T>
  private let increment: T
  private let validRange: ClosedRange<T>
  private let formatting: (T) -> String
  
  init(
    titleKey: LocalizedStringKey,
    lowerBoundTitle: LocalizedStringKey = "Contracted:",
    upperBoundTitle: LocalizedStringKey = "Expanded:",
    lowerBound: Binding<T>,
    upperBound: Binding<T>,
    increment: T,
    validRange: ClosedRange<T>,
    formatting: @escaping (T) -> String
  ) {
    self.titleKey = titleKey
    self.lowerBoundTitle = lowerBoundTitle
    self.upperBoundTitle = upperBoundTitle
    self.lowerBound = lowerBound
    self.upperBound = upperBound
    self.increment = increment
    self.validRange = validRange
    self.formatting = formatting
  }
  
  var body: some View {
    GroupBox(titleKey) {
      VStack(alignment: .rangePairStepperAlignment) {
        LabeledContent {
          Stepper {
            Text(verbatim: formatting(lowerBound.wrappedValue))
          } onIncrement: {
            withAnimation {
              let nextValue = lowerBound.wrappedValue + increment
              guard
                nextValue <= upperBound.wrappedValue,
                validRange.contains(nextValue)
              else {
                return
              }
              lowerBound.wrappedValue = nextValue
            }
          } onDecrement: {
            withAnimation {
              let nextValue = lowerBound.wrappedValue - increment
              guard
                nextValue <= upperBound.wrappedValue,
                validRange.contains(nextValue)
              else {
                return
              }
              lowerBound.wrappedValue = nextValue
            }
          }.alignmentGuide(.rangePairStepperAlignment) {
            $0[.trailing]
          }
        } label: {
          Text(lowerBoundTitle)
        }
        LabeledContent {
          Stepper {
            Text(verbatim: formatting(upperBound.wrappedValue))
          } onIncrement: {
            withAnimation {
              let nextValue = upperBound.wrappedValue + increment
              guard
                lowerBound.wrappedValue <= nextValue,
                validRange.contains(nextValue)
              else {
                return
              }
              upperBound.wrappedValue = nextValue
            }
          } onDecrement: {
            withAnimation {
              let nextValue = upperBound.wrappedValue - increment
              guard
                lowerBound.wrappedValue <= nextValue,
                validRange.contains(nextValue)
              else {
                return
              }
              upperBound.wrappedValue = nextValue
            }
          }.alignmentGuide(.rangePairStepperAlignment) {
            $0[.trailing]
          }
        } label: {
          Text(upperBoundTitle)
        }
      }
    }
  }
  
}


