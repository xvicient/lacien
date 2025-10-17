import SwiftUI

enum CardType: CaseIterable, Identifiable {
    case experience, skills, projects
    var id: Self { self }
}

struct ContentView: View {
    @State private var isHomeViewPadded = false
    @State private var scrollPosition: Int? = 0
    @State private var isScrollDisabled: Bool = true
    private let contentPadding: CGFloat = 20
    private var outerPadding: CGFloat {
        contentPadding * 2
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                HStack {
                    let width = geometry.size.width - outerPadding
                    
                    HomeView(hasPadding: $isHomeViewPadded)
                        .cardStyle(
                            index: 0,
                            scrollPosition: scrollPosition,
                            width: isHomeViewPadded ? width : geometry.size.width
                        )
                        .ignoresSafeArea()
                    
                    ForEach(Array(CardType.allCases.enumerated()), id: \.offset) { index, type in
                        ExperienceView(contentPadding: contentPadding) {
                            isScrollDisabled = $0
                        }
                        .cardStyle(
                            index: index + 1,
                            scrollPosition: scrollPosition,
                            width: width
                        )
                    }
                }
                .padding(.horizontal, isHomeViewPadded ? contentPadding : 0)
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollPosition)
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

struct CardStyle: ViewModifier {
    var index: Int
    var scrollPosition: Int?
    var width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .id(index)
            .frame(width: width < 0 ? 0 : width)
            .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 10)
            .zIndex(scrollPosition == index ? 1000 : 0)
            .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                view.scaleEffect(phase.isIdentity ? 1.02 : 0.98)
            }

    }
}

extension View {
    func cardStyle(
        index: Int,
        scrollPosition: Int?,
        width: CGFloat
    ) -> some View {
        self.modifier(
            CardStyle(
                index: index,
                scrollPosition: scrollPosition,
                width: width
            )
        )
    }
}

