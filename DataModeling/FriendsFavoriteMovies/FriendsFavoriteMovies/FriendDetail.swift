//
//  FriendDetail.swift
//  FriendsFavoriteMovies
//
//  Created by 태원진 on 4/13/26.
//

import SwiftUI

struct FriendDetail: View {
    @Bindable var friend: Friend
    
    var body: some View {
        Form {
            TextField("Name", text: $friend.name)
                .autocorrectionDisabled()
        }
    }
}

#Preview {
    FriendDetail(friend: SampleData.shared.friend)
    
}
