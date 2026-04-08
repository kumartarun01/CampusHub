
import SwiftUI
import Combine

// ─────────────────────────────────────────────
// MARK: - Club Model
// ─────────────────────────────────────────────
struct Club: Identifiable {
    let id     = UUID()
    var initials:    String
    var name:        String
    var description: String
    var members:     Int
    var category:    String
    var isJoined:    Bool
    var events:      [String]

    static var defaults: [Club] = [
        Club(initials:"CS", name:"CS & AI Club",      description:"Explore AI, ML and cutting-edge tech with passionate engineers.",  members:142, category:"Tech",    isJoined:true,  events:["Tech Talk: Apr 3","Hackathon: Apr 20"]),
        Club(initials:"SP", name:"Sports Council",    description:"Organises all inter-college and intra-college sports competitions.", members:89,  category:"Sports", isJoined:true,  events:["Football: Apr 1","Cricket Cup: Apr 15"]),
        Club(initials:"MU", name:"Music Club",        description:"Weekly jam sessions, concerts and open-mic nights for all genres.",  members:67,  category:"Arts",   isJoined:false, events:["Open Mic: Apr 13","Annual Fest: May 2"]),
        Club(initials:"PH", name:"Photography Club",  description:"Capture campus life — workshops, photowalks and exhibitions.",       members:54,  category:"Arts",   isJoined:false, events:["Photo Walk: Apr 19"]),
        Club(initials:"RB", name:"Robotics Club",     description:"Build bots, compete in national competitions and learn to code.",    members:38,  category:"Tech",   isJoined:false, events:["Demo Day: Jun 30"]),
        Club(initials:"LT", name:"Literary Society",  description:"Book clubs, debates, creative writing and poetry slams.",            members:29,  category:"Arts",   isJoined:false, events:["Book Club: Apr 10"])
    ]
}

// ─────────────────────────────────────────────
// MARK: - SavedEvent Model
// ─────────────────────────────────────────────
struct SavedEvent: Identifiable {
    let id    = UUID()
    let icon:  String
    let title: String
    let date:  String
    let tag:   String
}

// ─────────────────────────────────────────────
// MARK: - CalendarBookmark Model
// ─────────────────────────────────────────────
struct CalendarBookmark: Identifiable {
    let id    = UUID()
    let day:   Int
    let month: String
    let title: String
}

// ─────────────────────────────────────────────
// MARK: - UserProfileStore
// ─────────────────────────────────────────────
final class UserProfileStore: ObservableObject {

    // ── Basic info ────────────────────────────
    @Published var name:         String   = "Arjun Kumar"
    @Published var department:   String   = "CS Engineering"
    @Published var year:         String   = "3rd Year"
    @Published var email:        String   = "arjun.kumar@campus.edu"
    @Published var bio:          String   = "Passionate about AI and building cool things 🚀"
    @Published var interests:    [String] = ["AI/ML", "Photography", "Music", "Football", "Coding"]
    @Published var profileImage: UIImage? = nil

    // ── Notification prefs ────────────────────
    @Published var notifEvents:    Bool = true
    @Published var notifClubs:     Bool = true
    @Published var notifRSVP:      Bool = false
    @Published var notifReminders: Bool = true
    @Published var notifNewClubs:  Bool = false
    @Published var notifEmail:     Bool = true

    // ── Privacy / security ────────────────────
    @Published var profilePublic:  Bool = true
    @Published var showEmail:      Bool = false
    @Published var showAttending:  Bool = true
    @Published var twoFactor:      Bool = false
    @Published var biometric:      Bool = true

    // ── Saved events ──────────────────────────
    @Published var savedEvents: [SavedEvent] = []

    // ── Liked event IDs ───────────────────────
    @Published var likedEventIDs: Set<UUID> = []

    // ── Clubs ─────────────────────────────────
    @Published var clubs: [Club] = Club.defaults

    // ── Calendar bookmarks ────────────────────
    @Published var calendarBookmarks: [CalendarBookmark] = []

    // ── Computed ──────────────────────────────
    var initials: String {
        let parts = name.split(separator: " ")
        let f = parts.first?.prefix(1) ?? "?"
        let l = parts.dropFirst().first?.prefix(1) ?? ""
        return "\(f)\(l)".uppercased()
    }

    // ── Helpers ───────────────────────────────
    func isEventSaved(title: String) -> Bool {
        savedEvents.contains(where: { $0.title == title })
    }

    func toggleSaveEvent(title: String, date: String, icon: String, tag: String) {
        if let idx = savedEvents.firstIndex(where: { $0.title == title }) {
            savedEvents.remove(at: idx)
        } else {
            savedEvents.append(SavedEvent(icon: icon, title: title, date: date, tag: tag))
        }
    }

    func isDayBookmarked(day: Int) -> Bool {
        calendarBookmarks.contains(where: { $0.day == day })
    }

    func toggleDayBookmark(day: Int, title: String) {
        if let idx = calendarBookmarks.firstIndex(where: { $0.day == day }) {
            calendarBookmarks.remove(at: idx)
        } else {
            calendarBookmarks.append(CalendarBookmark(day: day, month: "April", title: title))
        }
    }
}
