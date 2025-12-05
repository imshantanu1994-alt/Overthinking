// ThoughtGardenApp.swift
import SwiftUI

@main
struct ThoughtGardenApp: App {
    var gardenVM = GardenViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(gardenVM)
        }
    }
}

