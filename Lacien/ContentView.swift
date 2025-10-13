import SwiftUI

struct ContentView: View {
    @State private var isFirstDetailViewPadded = false
    @State private var isSecondDetailViewPadded = true
    @State private var isThirdDetailViewPadded = true
    @State private var isForthDetailViewPadded = true
    
    @State private var scrollIndex: Int? = 0
    var images = ["me", "keyboard", "me", "me"]
    var backgroundImage: String {
        images[scrollIndex ?? 0]
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    DetailView(hasPadding: $isFirstDetailViewPadded, backgroundImage: "me")
                        .id(0)
                        .frame(width: isFirstDetailViewPadded ? geometry.size.width - 40 : geometry.size.width)
                    DetailView(hasPadding: $isSecondDetailViewPadded, backgroundImage: "keyboard")
                        .id(1)
                        .frame(width: geometry.size.width - 40)
                    DetailView(hasPadding: $isThirdDetailViewPadded, backgroundImage: "me")
                        .id(2)
                        .frame(width: geometry.size.width - 40)
                    DetailView(hasPadding: $isForthDetailViewPadded, backgroundImage: "keyboard")
                        .id(3)
                        .frame(width: geometry.size.width - 40)
                }
                .padding(.horizontal, isFirstDetailViewPadded ? 20 : 0)
                .scrollTargetLayout()
            }
            .background(
                GeometryReader { geometry in
                    Image("me")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width * 1.3,
                               height: geometry.size.height * 1.3)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .blur(radius: 10)
                        .ignoresSafeArea()
                }
            )
            .scrollPosition(id: $scrollIndex)
            .scrollClipDisabled()
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
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
