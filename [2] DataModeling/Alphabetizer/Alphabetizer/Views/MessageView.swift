import SwiftUI

struct MessageView: View {
    // TODO: Different messages after winning or losing the game
    @Environment(Alphabetizer.self) private var alphabetizer
    
    var body: some View {
        Text(alphabetizer.message.rawValue)
            .foregroundStyle(alphabetizer.message == .instructions ? .secondary : .primary)
            .font(.largeTitle)
    }
}

#Preview {
    let alphabetizer = Alphabetizer()
    alphabetizer.message = .youWin
    return MessageView()
        .environment(alphabetizer)
}
