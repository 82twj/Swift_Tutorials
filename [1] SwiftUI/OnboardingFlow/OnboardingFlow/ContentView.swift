//
//  ContentView.swift
//  OnboardingFlow
//
//  Created by 태원진 on 3/27/26.
//

import SwiftUI

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]


struct ContentView: View {
    var body: some View {
        TabView {
            WelcomePage()
            FeaturesPage()
        }
        .background(Gradient(colors: gradientColors))
        .tabViewStyle(.page)
        .foregroundStyle(.white)

    }
}

#Preview {
    ContentView()
}
