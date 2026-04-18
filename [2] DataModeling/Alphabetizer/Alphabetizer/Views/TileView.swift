import SwiftUI

struct TileView: View {
    var tile: Tile

    private let borderWidth = 16.0

    var body: some View {
        VStack {
            if tile.flipped {
                Image(systemName: "checkmark")
                    .font(Font.system(size: 120))
                    .foregroundStyle(Color.green)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            } else {
                Text(tile.icon)
                    .font(Font.system(size: 80))
                Text(tile.word)
                    .font(.title)
            }
        }
        .frame(width: Tile.size - borderWidth * 2, height: Tile.size - borderWidth * 2)
        .overlay(RoundedRectangle(cornerRadius: 36).stroke(borderStyle(), lineWidth: borderWidth))
        .background(Color.blue.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 36))
        .rotation3DEffect(.degrees(tile.flipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        .animation(.default, value: tile.flipped)

    }

    func borderStyle() -> some ShapeStyle {
        return LinearGradient(colors: [
            Color(.red),
            Color(.orange),
            Color(.yellow),
            Color(.green),
            Color(.blue),
            Color(.purple),
        ], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

#Preview {
    let tile = Tile(word: "Bear")
    return TileView(tile: tile)
        .onTapGesture {
            tile.flipped.toggle()
        }
}
