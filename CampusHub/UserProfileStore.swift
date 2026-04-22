import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

// ─────────────────────────────────────────────
// MARK: - Club
// ─────────────────────────────────────────────
struct Club: Identifiable {
    let id = UUID()
    var initials: String; var name: String; var description: String
    var members: Int; var category: String; var isJoined: Bool; var events: [String]

    static var defaults: [Club] = [
        Club(initials:"CS", name:"CS & AI Club",     description:"Explore AI, ML and cutting-edge tech with passionate engineers.",  members:142, category:"Tech",    isJoined:true,  events:["Tech Talk: Apr 3","Hackathon: Apr 20"]),
        Club(initials:"SP", name:"Sports Council",   description:"Organises all inter-college and intra-college sports competitions.", members:89,  category:"Sports", isJoined:true,  events:["Football: Apr 8","Cricket Cup: Apr 15"]),
        Club(initials:"MU", name:"Music Club",       description:"Weekly jam sessions, concerts and open-mic nights for all genres.",  members:67,  category:"Arts",   isJoined:false, events:["Open Mic: Apr 13","Annual Fest: May 2"]),
        Club(initials:"PH", name:"Photography Club", description:"Capture campus life — workshops, photowalks and exhibitions.",       members:54,  category:"Arts",   isJoined:false, events:["Photo Walk: Apr 19"]),
        Club(initials:"RB", name:"Robotics Club",    description:"Build bots, compete in national competitions and learn to code.",    members:38,  category:"Tech",   isJoined:false, events:["Demo Day: Jun 30"]),
        Club(initials:"LT", name:"Literary Society", description:"Book clubs, debates, creative writing and poetry slams.",            members:29,  category:"Arts",   isJoined:false, events:["Book Club: Apr 10"])
    ]
}

// ─────────────────────────────────────────────
// MARK: - SavedEvent
// ─────────────────────────────────────────────
struct SavedEvent: Identifiable {
    let id = UUID(); let icon, title, date, tag: String
}

// ─────────────────────────────────────────────
// MARK: - CalendarBookmark
// ─────────────────────────────────────────────
struct CalendarBookmark: Identifiable {
    let id = UUID(); let day: Int; let month, title: String
}

// ─────────────────────────────────────────────
// MARK: - CustomCalendarEvent
// ─────────────────────────────────────────────
struct CustomCalendarEvent: Identifiable {
    let id = UUID()
    var day: Int; var month: String
    var title: String; var time: String
    var location: String; var tag: String; var icon: String
}

// ─────────────────────────────────────────────
// MARK: - AppNotification
// ─────────────────────────────────────────────
struct AppNotification: Identifiable {
    let id = UUID()
    let icon, title, body, time, category: String
    var isRead: Bool
}

// ─────────────────────────────────────────────
// MARK: - DayEvent
// ─────────────────────────────────────────────
struct DayEvent: Identifiable {
    let id = UUID(); let title, time, tag, icon: String
}

// ─────────────────────────────────────────────
// MARK: - UserProfileStore
// ─────────────────────────────────────────────
final class UserProfileStore: ObservableObject {

    // Basic profile
    @Published var name         = ""
    @Published var department   = ""
    @Published var year         = ""
    @Published var email        = ""
    @Published var bio          = ""
    @Published var interests    = [String]()
    @Published var profileImage: UIImage? = nil

    // Notification prefs
    @Published var notifEvents    = true
    @Published var notifClubs     = true
    @Published var notifRSVP      = false
    @Published var notifReminders = true
    @Published var notifNewClubs  = false
    @Published var notifEmail     = true

    // Privacy / security
    @Published var profilePublic  = true
    @Published var showEmail      = false
    @Published var showAttending  = true
    @Published var twoFactor      = false
    @Published var biometric      = true

    // App data
    @Published var savedEvents:       [SavedEvent]          = []
    @Published var likedEventIDs:     Set<UUID>             = []
    @Published var clubs:             [Club]                = Club.defaults
    @Published var calendarBookmarks: [CalendarBookmark]    = []
    @Published var customEvents:      [CustomCalendarEvent] = []

    // In-app notifications
    @Published var notifications: [AppNotification] = [
        AppNotification(icon:"mic.fill",              title:"Tech Talk Tomorrow!",      body:"Tech Talk: AI in 2025 is tomorrow at 9AM · Hall A. Don't miss it!",          time:"2m ago",    category:"event", isRead:false),
        AppNotification(icon:"person.3.fill",         title:"CS & AI Club Update",      body:"New hackathon announced for Apr 20. Register before Apr 15.",                 time:"1h ago",    category:"club",  isRead:false),
        AppNotification(icon:"bookmark.fill",         title:"Event Reminder",           body:"Inter-College Football starts in 1 hour at the Ground. Get ready!",           time:"3h ago",    category:"event", isRead:true),
        AppNotification(icon:"star.fill",             title:"New Club Joined",          body:"Welcome to Sports Council! You'll now receive updates from this club.",        time:"Yesterday", category:"club",  isRead:true),
        AppNotification(icon:"calendar.badge.clock",  title:"Art Exhibition This Week", body:"Annual Art Exhibition is on Apr 5 at Gallery. RSVP now to confirm your seat.", time:"2d ago",    category:"event", isRead:true),
        AppNotification(icon:"checkmark.circle.fill", title:"RSVP Confirmed",           body:"Your RSVP for Music Fest (Apr 13) is confirmed. See you there! 🎵",           time:"3d ago",    category:"event", isRead:true)
    ]

    // RTDB reference — explicit URL
    private let rtdb = Database.database(url: "https://campushub-e60aa-default-rtdb.firebaseio.com").reference()

    // Computed
    var initials: String {
        let p = name.split(separator: " ")
        return "\(p.first?.prefix(1) ?? "?")\(p.dropFirst().first?.prefix(1) ?? "")".uppercased()
    }
    var unreadCount: Int { notifications.filter { !$0.isRead }.count }

    // MARK: – Load profile (Firestore for signup data, RTDB for profile updates)
    func loadProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        // First load signup data from Firestore
        Firestore.firestore().collection("users").document(uid)
            .getDocument { [weak self] snap, _ in
                guard let self, let data = snap?.data() else { return }
                DispatchQueue.main.async {
                    self.name  = data["fullName"] as? String ?? ""
                    self.email = data["email"]    as? String ?? ""
                }
            }

        // Then load full profile from RTDB (overrides if exists)
        rtdb.child("profiles").child(uid)
            .observeSingleEvent(of: .value) { [weak self] snapshot in
                guard let self,
                      let data = snapshot.value as? [String: Any] else { return }
                DispatchQueue.main.async {
                    if let v = data["fullName"]   as? String  { self.name       = v }
                    if let v = data["email"]      as? String  { self.email      = v }
                    if let v = data["department"] as? String  { self.department = v }
                    if let v = data["year"]       as? String  { self.year       = v }
                    if let v = data["bio"]        as? String  { self.bio        = v }
                    if let v = data["interests"]  as? [String]{ self.interests  = v }
                }
            }
    }

    // MARK: – Save profile to Realtime Database
    func saveProfile(
        name: String, email: String, department: String,
        year: String, bio: String, interests: [String],
        completion: @escaping (Bool) -> Void
    ) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false); return
        }

        let profileData: [String: Any] = [
            "fullName":   name,
            "email":      email,
            "department": department,
            "year":       year,
            "bio":        bio,
            "interests":  interests,
            "updatedAt":  ServerValue.timestamp()
        ]

        // ✅ Write to RTDB → /profiles/{uid}
        rtdb.child("profiles").child(uid).setValue(profileData) { [weak self] error, _ in
            guard let self else { return }
            DispatchQueue.main.async {
                if error == nil {
                    self.name       = name
                    self.email      = email
                    self.department = department
                    self.year       = year
                    self.bio        = bio
                    self.interests  = interests
                }
                completion(error == nil)
            }
        }
    }

    // MARK: – Helpers
    func isEventSaved(title: String) -> Bool { savedEvents.contains { $0.title == title } }

    func toggleSaveEvent(title: String, date: String, icon: String, tag: String) {
        if let i = savedEvents.firstIndex(where: { $0.title == title }) { savedEvents.remove(at: i) }
        else { savedEvents.append(SavedEvent(icon: icon, title: title, date: date, tag: tag)) }
    }

    func isDayBookmarked(day: Int) -> Bool { calendarBookmarks.contains { $0.day == day } }

    func toggleDayBookmark(day: Int, title: String) {
        if let i = calendarBookmarks.firstIndex(where: { $0.day == day }) { calendarBookmarks.remove(at: i) }
        else { calendarBookmarks.append(CalendarBookmark(day: day, month: "April", title: title)) }
    }

    func allEventsForDay(_ day: Int, builtIn: [Int: [DayEvent]]) -> [DayEvent] {
        var list = builtIn[day] ?? []
        for ce in customEvents where ce.day == day {
            list.append(DayEvent(title: ce.title,
                                 time: ce.time.isEmpty ? ce.location : "\(ce.time) · \(ce.location)",
                                 tag: ce.tag, icon: ce.icon))
        }
        return list
    }

    func markAllRead() { for i in notifications.indices { notifications[i].isRead = true } }
}
