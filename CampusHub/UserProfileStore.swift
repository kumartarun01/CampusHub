////
////  UserProfileStore.swift
////  CampusHub
////
////  Created by iMac1 on 06/04/26.
////
//
//import SwiftUI
//import PhotosUI
//import Combine
//
//// ─────────────────────────────────────────────
//// MARK: - Shared Data Store
//// ─────────────────────────────────────────────
//class UserProfileStore: ObservableObject {
//
//    // Basic info
//    @Published var name:         String   = "Arjun Kumar"
//    @Published var department:   String   = "CS Engineering"
//    @Published var year:         String   = "3rd Year"
//    @Published var email:        String   = "arjun.kumar@campus.edu"
//    @Published var bio:          String   = "Passionate about AI and building cool things 🚀"
//    @Published var interests:    [String] = ["AI/ML", "Photography", "Music", "Football", "Coding"]
//    @Published var profileImage: UIImage? = nil
//
//    // Notification prefs
//    @Published var notifEvents:    Bool = true
//    @Published var notifClubs:     Bool = true
//    @Published var notifRSVP:      Bool = false
//    @Published var notifReminders: Bool = true
//    @Published var notifNewClubs:  Bool = false
//    @Published var notifEmail:     Bool = true
//
//    // Privacy / security
//    @Published var profilePublic:  Bool = true
//    @Published var showEmail:      Bool = false
//    @Published var showAttending:  Bool = true
//    @Published var twoFactor:      Bool = false
//    @Published var biometric:      Bool = true
//
//    // Saved events
//    @Published var savedEvents: [SavedEvent] = [
//        SavedEvent(icon: "mic.fill",         title: "Tech Talk: AI in 2025",  date: "Apr 3 · 9AM · Hall A",   tag: "Free"),
//        SavedEvent(icon: "paintpalette.fill", title: "Annual Art Exhibition",  date: "Apr 5 · 10AM · Gallery",  tag: "Cultural"),
//        SavedEvent(icon: "music.note",        title: "Music Fest",             date: "Apr 13 · 6PM · Grounds",  tag: "Free"),
//        SavedEvent(icon: "camera.fill",       title: "Photo Walk",             date: "Apr 19 · 6AM · Campus",   tag: "Club"),
//        SavedEvent(icon: "desktopcomputer",   title: "Robotics Demo",          date: "Jun 30 · 2PM · Lab B",    tag: "Tech")
//    ]
//
//    var initials: String {
//        let parts = name.split(separator: " ")
//        let f = parts.first?.prefix(1) ?? "?"
//        let l = parts.dropFirst().first?.prefix(1) ?? ""
//        return "\(f)\(l)".uppercased()
//    }
//}
//
//struct SavedEvent: Identifiable {
//    let id    = UUID()
//    let icon:  String
//    let title: String
//    let date:  String
//    let tag:   String
//}


import SwiftUI
import Combine

// ─────────────────────────────────────────────
// MARK: - Shared Data Store
// ─────────────────────────────────────────────
final class UserProfileStore: ObservableObject {

    // Basic info
    @Published var name:         String   = "Arjun Kumar"
    @Published var department:   String   = "CS Engineering"
    @Published var year:         String   = "3rd Year"
    @Published var email:        String   = "arjun.kumar@campus.edu"
    @Published var bio:          String   = "Passionate about AI and building cool things 🚀"
    @Published var interests:    [String] = ["AI/ML", "Photography", "Music", "Football", "Coding"]
    @Published var profileImage: UIImage? = nil

    // Notification prefs
    @Published var notifEvents:    Bool = true
    @Published var notifClubs:     Bool = true
    @Published var notifRSVP:      Bool = false
    @Published var notifReminders: Bool = true
    @Published var notifNewClubs:  Bool = false
    @Published var notifEmail:     Bool = true

    // Privacy / security
    @Published var profilePublic:  Bool = true
    @Published var showEmail:      Bool = false
    @Published var showAttending:  Bool = true
    @Published var twoFactor:      Bool = false
    @Published var biometric:      Bool = true

    // Saved events
    @Published var savedEvents: [SavedEvent] = [
        SavedEvent(icon: "mic.fill",         title: "Tech Talk: AI in 2025",  date: "Apr 3 · 9AM · Hall A",   tag: "Free"),
        SavedEvent(icon: "paintpalette.fill", title: "Annual Art Exhibition",  date: "Apr 5 · 10AM · Gallery",  tag: "Cultural"),
        SavedEvent(icon: "music.note",        title: "Music Fest",             date: "Apr 13 · 6PM · Grounds",  tag: "Free"),
        SavedEvent(icon: "camera.fill",       title: "Photo Walk",             date: "Apr 19 · 6AM · Campus",   tag: "Club"),
        SavedEvent(icon: "desktopcomputer",   title: "Robotics Demo",          date: "Jun 30 · 2PM · Lab B",    tag: "Tech")
    ]

    var initials: String {
        let parts = name.split(separator: " ")
        let f = parts.first?.prefix(1) ?? "?"
        let l = parts.dropFirst().first?.prefix(1) ?? ""
        return "\(f)\(l)".uppercased()
    }
}

// ─────────────────────────────────────────────
// MARK: - SavedEvent model
// ─────────────────────────────────────────────
struct SavedEvent: Identifiable {
    let id    = UUID()
    let icon:  String
    let title: String
    let date:  String
    let tag:   String
}
