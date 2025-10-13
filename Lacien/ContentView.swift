import SwiftUI

struct ContentView: View {
    @State private var isFirstDetailViewPadded = false
    @State private var isSecondDetailViewPadded = true
    @State private var isThirdDetailViewPadded = true
    @State private var isForthDetailViewPadded = true

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    DetailView(hasPadding: $isFirstDetailViewPadded)
                        .frame(width: isFirstDetailViewPadded ? geometry.size.width - 40 : geometry.size.width)
                    DetailView(hasPadding: $isSecondDetailViewPadded)
                        .frame(width: geometry.size.width - 40)
                    DetailView(hasPadding: $isThirdDetailViewPadded)
                        .frame(width: geometry.size.width - 40)
                    DetailView(hasPadding: $isForthDetailViewPadded)
                        .frame(width: geometry.size.width - 40)
                }
                .padding(.horizontal, isFirstDetailViewPadded ? 20 : 0)
                .scrollTargetLayout()
            }
            .scrollClipDisabled()
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .background(.black)
            .scrollDisabled(!isFirstDetailViewPadded)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder public func `if`<Content: View>(
        _ condition: @autoclosure () -> Bool,
        transform: (Self) -> Content
    )
        -> some View
    {
        if condition() {
            transform(self)
        }
        else {
            self
        }
    }
}
