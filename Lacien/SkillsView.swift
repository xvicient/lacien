import SwiftUI

struct SkillsView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image.keyboard
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: geometry.size.width - 5,
                        height: geometry.size.height - 40
                    )
                    .allowsHitTesting(false)
                
                Color.black.opacity(0.6)
                    .frame(
                        width: geometry.size.width - 5,
                        height: geometry.size.height - 40
                    )
                    .allowsHitTesting(false)
                
                VStack {
                    Spacer()
                    
                    // Main content
                    VStack(spacing: 10) {
                        Text("My skills")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .clipped()
            .cornerRadius(20)
            .padding(.vertical, 20)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SkillsView()
}
