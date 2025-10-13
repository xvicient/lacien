import SwiftUI

struct DetailView: View {
    @Binding var hasPadding: Bool
    var backgroundImage: String
    
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Image(backgroundImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(
                            width: hasPadding ? geometry.size.width - 5 : geometry.size.width,
                            height: hasPadding ? geometry.size.height - 40 : geometry.size.height
                        )
                        .allowsHitTesting(false)
                    
                    Color.black.opacity(0.6)
                        .frame(
                            width: hasPadding ? geometry.size.width - 5 : geometry.size.width,
                            height: hasPadding ? geometry.size.height - 40 : geometry.size.height
                        )
                        .allowsHitTesting(false)
                    
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
    DetailView(hasPadding: .constant(true), backgroundImage: "me")
}
