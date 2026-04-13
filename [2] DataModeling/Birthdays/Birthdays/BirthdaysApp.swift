//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by 태원진 on 4/9/26.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
