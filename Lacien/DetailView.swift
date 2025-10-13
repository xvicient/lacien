import SwiftUI

struct DetailView: View {
    @Binding var hasPadding: Bool
    
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Image("me")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: hasPadding ? geometry.size.width - 5 : geometry.size.width,
                            height: hasPadding ? geometry.size.height - 40 : geometry.size.height
                        )
                    
                    Color.black.opacity(0.6)
                        .frame(
                            width: hasPadding ? geometry.size.width - 5 : geometry.size.width,
                            height: hasPadding ? geometry.size.height - 40 : geometry.size.height
                        )
                    
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
                            Image(systemName: "tortoise") // Placeholder for Twitter
                            Image(systemName: "ant") // Placeholder for Facebook
                            Image(systemName: "ladybug") // Placeholder for Instagram
                            Image(systemName: "leaf") // Placeholder for Dribbble
                            Image(systemName: "lasso") // Placeholder for Behance
                        }
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                    }
                }
                .clipped()
                .cornerRadius(hasPadding ? 20 : 0)
                .padding(.vertical, hasPadding ? 20 : 0)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
            .ignoresSafeArea()
    }
}

#Preview {
    DetailView(hasPadding: .constant(true))
}
