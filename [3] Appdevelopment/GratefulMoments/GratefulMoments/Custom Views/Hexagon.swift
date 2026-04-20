//
//  Hexagon.swift
//  GratefulMoments
//
//  Created by 태원진 on 4/19/26.
//

import SwiftUI

struct Hexagon<Content: View>: View {
    private let borderWidth = 10.0
    var borderColor: Color = .ruby
    var layout: HexagonLayout = .standard
    var moment: Moment? = nil
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            if let background = moment?.image {
                Image(uiImage: background)
                    .resizable()
                    .scaledToFill()
            }
            content()
                .frame(width: layout.size, height: layout.size)
        }
        .mask {
            Image(systemName: "heart.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: layout.size - borderWidth, height: layout.size - borderWidth)
        }
        .background {
            Image(systemName: "heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: layout.size, height: layout.size)
                .foregroundStyle(borderColor)
        }
        .frame(width: layout.size, height: layout.size)
    }
}

#Preview {
    Hexagon(moment: Moment.imageSample) {
        Text(Moment.imageSample.title)
            .foregroundStyle(Color.white)
    }
    .sampleDataContainer()
}
