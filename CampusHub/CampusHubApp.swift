//
//  CampusHubApp.swift
//  CampusHub
//
//  Created by iMac1 on 02/04/26.
//

//import SwiftUI
//
//@main
//struct CampusHubApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

import SwiftUI

// ─────────────────────────────────────────────
// MARK: - App Entry Point
// ─────────────────────────────────────────────
// Replace the default generated App struct in your project with this file.
// Make sure ONLY this file has @main attribute.

@main
struct CampusHubApp: App {
    @StateObject private var store = UserProfileStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .preferredColorScheme(.dark)
        }
    }
}
