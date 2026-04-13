//
//  MovieList.swift
//  FriendsFavoriteMovies
//
//  Created by 태원진 on 4/13/26.
//

import SwiftUI
import SwiftData

struct MovieList: View {
    @Query(sort: \Movie.title) private var movies: [Movie]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(movies) { movie in
                    NavigationLink(movie.title) {
                        Text("Detail view for \(movie.title)")
                            .navigationTitle("Movie")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            .navigationTitle("Movies")
        } detail: {
            Text("Select a movie")
                .navigationTitle("Movie")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MovieList()
        .modelContainer(SampleData.shared.modelContainer)
}
