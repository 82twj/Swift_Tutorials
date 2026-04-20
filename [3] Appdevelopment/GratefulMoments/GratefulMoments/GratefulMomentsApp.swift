//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by 태원진 on 4/19/26.
//

import SwiftUI
import SwiftData

@main
struct GratefulMomentsApp: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
            MomentsView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
