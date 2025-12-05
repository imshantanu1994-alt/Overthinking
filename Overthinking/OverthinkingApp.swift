//
//  ThoughtGardenApp.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

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

