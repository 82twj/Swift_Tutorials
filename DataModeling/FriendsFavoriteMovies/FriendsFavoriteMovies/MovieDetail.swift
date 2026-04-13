//
//  MovieDetail.swift
//  FriendsFavoriteMovies
//
//  Created by 태원진 on 4/13/26.
//

import SwiftUI

struct MovieDetail: View {
    @Bindable var movie: Movie
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MovieDetail(movie: SampleData.shared.movie)
}
