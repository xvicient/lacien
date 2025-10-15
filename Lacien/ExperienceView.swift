import SwiftUI

struct ExperienceView: View {
    var contentPadding: CGFloat
    var isScrolled: (Bool) -> ()
    @State private var isPageScrolled: Bool = false
    
    @State private var scrollProperties: ScrollGeometry = .init(
        contentOffset: .zero,
        contentSize: .zero,
        contentInsets: .init(),
        containerSize: .zero
    )
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ac blandit eros, nec luctus nulla. Quisque ante nulla, pulvinar eu sem a, vulputate accumsan dui. Fusce mattis ex vel purus sodales rutrum. Integer fringilla egestas diam luctus aliquam. Mauris ut massa ut ipsum porttitor porta non nec lectus. Phasellus a gravida erat, a varius purus. Maecenas tincidunt nibh a arcu elementum suscipit. Maecenas vel efficitur sapien. Phasellus malesuada, sem id malesuada feugiat, felis lacus interdum lorem, sed tincidunt arcu massa et enim. Vivamus fringilla aliquet nulla malesuada convallis. Cras iaculis pulvinar leo.\n\nDonec auctor sapien a eros porttitor, at rhoncus neque semper. Morbi lobortis et purus eu dictum. Donec consequat interdum fermentum. Pellentesque massa ex, auctor at semper nec, cursus nec nisi. Praesent tincidunt velit id ex ultricies lacinia. Duis vitae suscipit elit. Integer non est blandit, sollicitudin ex nec, mollis tortor. Curabitur tincidunt interdum bibendum. In eu varius libero, vel placerat tellus.\n\nCras id interdum metus. Nullam interdum, ligula ac finibus bibendum, risus metus luctus leo, maximus volutpat libero mi eget elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean sed facilisis neque, et ullamcorper neque. Vivamus accumsan ullamcorper metus vel mollis. Aliquam maximus porta nunc ut dignissim. Donec id magna congue, elementum tellus eget, malesuada nisl. Mauris dui mi, tincidunt at leo sed, tempor tempus ante. Curabitur in efficitur erat.\n\nCras id interdum metus. Nullam interdum, ligula ac finibus bibendum, risus metus luctus leo, maximus volutpat libero mi eget elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean sed facilisis neque, et ullamcorper neque. Vivamus accumsan ullamcorper metus vel mollis. Aliquam maximus porta nunc ut dignissim. Donec id magna congue, elementum tellus eget, malesuada nisl. Mauris dui mi, tincidunt at leo sed, tempor tempus ante. Curabitur in efficitur erat.\n\nCras id interdum metus. Nullam interdum, ligula ac finibus bibendum, risus metus luctus leo, maximus volutpat libero mi eget elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean sed facilisis neque, et ullamcorper neque. Vivamus accumsan ullamcorper metus vel mollis. Aliquam maximus porta nunc ut dignissim. Donec id magna congue, elementum tellus eget, malesuada nisl. Mauris dui mi, tincidunt at leo sed, tempor tempus ante. Curabitur in efficitur erat.")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal, contentPadding + (contentPadding * scrollProperties.topInsetProgress))
            }
            .background {
                Image.keyboard
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .allowsHitTesting(false)
            }
            .cornerRadius(20)
            .padding(.horizontal, -contentPadding * scrollProperties.topInsetProgress)
        }
        .scrollClipDisabled()
        .onScrollGeometryChange(for: ScrollGeometry.self, of: {
            $0
        }, action: { oldValue, newValue in
            scrollProperties = newValue
            isPageScrolled = newValue.offsetY > 0
        })
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(ScrollTargetEnd(topInset: scrollProperties.contentInsets.top))
        .onChange(of: isPageScrolled) {
            isScrolled(isPageScrolled)
        }
        .safeAreaPadding(.top, 60)
        .safeAreaPadding(.bottom, 20)
        .ignoresSafeArea()
    }
}

extension ScrollGeometry {
    var offsetY: CGFloat {
        contentOffset.y + contentInsets.top
    }
    
    var topInsetProgress: CGFloat {
        guard contentInsets.top > 0 else { return 0 }
        return max(min(offsetY / contentInsets.top, 1), 0)
    }
}

struct ScrollTargetEnd: ScrollTargetBehavior {
    var topInset: CGFloat
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < topInset {
            target.rect.origin = .zero
        }
    }
}

#Preview {
    let contentPadding : CGFloat = 20
    GeometryReader { geometry in
        ScrollView(.horizontal) {
            HStack(spacing: 4) {
                ExperienceView(contentPadding: contentPadding) { _ in }
                    .id(0)
                    .frame(width: geometry.size.width - 40)
                    .zIndex(1)
                ExperienceView(contentPadding: contentPadding) { _ in }
                    .id(0)
                    .frame(width: geometry.size.width - 40)
                    .zIndex(0)
            }
            .padding(.horizontal, contentPadding)
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
    }
}
