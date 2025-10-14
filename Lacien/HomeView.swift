import SwiftUI

struct HomeView: View {
    @Binding var hasPadding: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            // Main content
            VStack(spacing: 10) {
                Text("Hello, I am")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Xavier Vicient")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Text("iOS Engineer")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    hasPadding.toggle()
                }
            }) {
                Text("Meet me")
                    .bold()
                    .frame(minWidth: 0, maxWidth: 200)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .padding()
            
            // Footer
            HStack(spacing: 30) {
                Image("github")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                Image("linkedin")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            ZStack {
                Image.me
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                Color.black.opacity(0.6)
            }
        }
        .cornerRadius(hasPadding ? 20 : 0)
        .safeAreaPadding(.top, hasPadding ? 60 : 0)
        .safeAreaPadding(.bottom, hasPadding ? 20 : 0)
        .ignoresSafeArea()
    }
}

#Preview {
    let contentPadding : CGFloat = 20
    let hasPadding = false
    GeometryReader { geometry in
        ScrollView(.horizontal) {
            HStack(spacing: 4) {
                HomeView(hasPadding: .constant(hasPadding))
                    .id(0)
                    .frame(width: geometry.size.width - 40)
                    .zIndex(1)
                HomeView(hasPadding: .constant(hasPadding))
                    .id(0)
                    .frame(width: geometry.size.width - 40)
                    .zIndex(0)
            }
            .padding(.horizontal, hasPadding ? contentPadding : 0)
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollClipDisabled()
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
    }
}
