import SwiftUI

struct ContentView: View {
    
    @State var isSparkle: Bool = false
    
    var body: some View {
        // ZStack을 다른 Stack으로 바꿔보세요.
        ZStack {
            Color.blue
            LinearGradient(colors: [.blue, .green, .yellow], startPoint: .top, endPoint: .bottom)
            VStack {
                Text("고양이가 나타났다!")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
                
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500)
                    .scaleEffect(isSparkle ? 1.0 : 1.08)
                    .opacity(isSparkle ? 0.7 : 1.0)
                    .animation(
                        .easeInOut(duration: 0.5)
                        .repeatCount(5),
                        value: isSparkle
                    )
                
                Button {
                    isSparkle.toggle()
                } label: {
                    Text("안녕?")
                        .font(.largeTitle)
                        .frame(width: 250, height: 50)
                        .tint(.red)
                }
                .buttonStyle(.glass)
                .shadow(radius: 5)
                
            }
        }.ignoresSafeArea()

    }
}

#Preview {
    ContentView()
}
