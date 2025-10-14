import SwiftUI

struct ContentView: View {
    @State private var isHomeViewPadded = false
    @State private var scrollPosition: Int? = 0
    private let contentPadding: CGFloat = 20
    @State private var isScrollDisabled: Bool = true

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    HomeView(hasPadding: $isHomeViewPadded)
                        .id(0)
                        .frame(width: isHomeViewPadded ? geometry.size.width - 40 : geometry.size.width)
                        .zIndex(scrollPosition == 0 ? 4 : 3)
                    ExperienceView(contentPadding: contentPadding) {
                        isScrollDisabled = $0
                    }
                        .id(1)
                        .frame(width: geometry.size.width - 40)
                        .zIndex(scrollPosition == 1 ? 4 : 2)
                    SkillsView()
                        .id(2)
                        .frame(width: geometry.size.width - 40)
                        .zIndex(scrollPosition == 2 ? 4 : 1)
                    ProjectsView()
                        .id(3)
                        .frame(width: geometry.size.width - 40)
                        .zIndex(scrollPosition == 3 ? 4 : 0)
                }
                .padding(.horizontal, isHomeViewPadded ? contentPadding : 0)
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollPosition)
            .onAppear {
                scrollPosition = 0
            }
            .background(
                GeometryReader { geometry in
                    Image.me
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width * 1.3,
                               height: geometry.size.height * 1.3)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .blur(radius: 10)
                        .ignoresSafeArea()
                }
            )
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollDisabled(isScrollDisabled)
            .onChange(of: isHomeViewPadded) {
                isScrollDisabled = !isHomeViewPadded
            }
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
