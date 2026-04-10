//
//import SwiftUI
//
//// ─────────────────────────────────────────────
//// MARK: - HomeFeedScreen
//// ─────────────────────────────────────────────
//struct HomeFeedScreen: View {
//    @Binding var selectedTab: String
//    @EnvironmentObject var store: UserProfileStore
//    @State private var selectedFilter = "All"
//
//    private let filters = ["All", "Today", "Free"]
//
//    var filteredEvents: [HomeFeedEvent] {
//        switch selectedFilter {
//        case "Today":   return HomeFeedEvent.samples.filter { $0.isToday }
//        case "Free":    return HomeFeedEvent.samples.filter { $0.tag == "Free" }
//        default:        return HomeFeedEvent.samples
//        }
//    }
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            VStack(spacing: 0) {
//
//                // Header
//                HStack {
//                    Text("Home Feed").font(.system(size: 26, weight: .bold)).foregroundColor(.white)
//                    Spacer()
//                    Button {} label: {
//                        Image(systemName: "bell").font(.system(size: 20)).foregroundColor(.white)
//                    }
//                }
//                .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 14)
//
//                // Filters
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 10) {
//                        ForEach(filters, id: \.self) { f in
//                            Button { selectedFilter = f } label: {
//                                Text(f)
//                                    .font(.system(size: 14, weight: .medium))
//                                    .foregroundColor(selectedFilter == f ? .black : .white)
//                                    .padding(.horizontal, 18).padding(.vertical, 9)
//                                    .background(selectedFilter == f ? Color.white : Color(white: 0.15))
//                                    .cornerRadius(20)
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                }
//                .padding(.bottom, 20)
//
//                // Events
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 14) {
//                        ForEach(filteredEvents) { event in
//                            HomeFeedCard(event: event)
//                                .environmentObject(store)
//                        }
//                        if filteredEvents.isEmpty {
//                            VStack(spacing: 12) {
//                                Image(systemName: "calendar.badge.exclamationmark")
//                                    .font(.system(size: 40)).foregroundColor(Color(white: 0.25))
//                                Text("No events found").font(.system(size: 16)).foregroundColor(Color(white: 0.4))
//                            }
//                            .frame(maxWidth: .infinity).padding(.top, 60)
//                        }
//                    }
//                    .padding(.horizontal, 20).padding(.bottom, 110)
//                }
//            }
//        }
//    }
//}
//
//// ─────────────────────────────────────────────
//// MARK: - HomeFeedEvent Model
//// ─────────────────────────────────────────────
//struct HomeFeedEvent: Identifiable {
//    let id        = UUID()
//    let title:      String
//    let date:       String
//    let attendees:  String
//    let tag:        String
//    let icon:       String
//    let isToday:    Bool
//
//    static let samples: [HomeFeedEvent] = [
//        HomeFeedEvent(title:"Tech Talk: AI in 2025",  date:"Apr 3 · 9AM · Hall A",    attendees:"39 attending",  tag:"Free",     icon:"mic.fill",          isToday:false),
//        HomeFeedEvent(title:"Inter-College Football",  date:"Apr 8 · 1PM · Ground",     attendees:"18 attending",  tag:"Cultural", icon:"soccerball",        isToday:true),
//        HomeFeedEvent(title:"Annual Art Exhibition",   date:"Apr 5 · 10AM · Gallery",   attendees:"52 attending",  tag:"Cultural", icon:"paintpalette.fill",  isToday:false),
//        HomeFeedEvent(title:"Coding Marathon",         date:"Apr 7 · 9AM · Lab 3",      attendees:"24 attending",  tag:"Free",     icon:"laptopcomputer",    isToday:false),
//        HomeFeedEvent(title:"Music Fest",              date:"Apr 13 · 6PM · Grounds",   attendees:"120 attending", tag:"Free",     icon:"music.note",        isToday:false),
//        HomeFeedEvent(title:"Photo Walk",              date:"Apr 19 · 6AM · Campus",    attendees:"32 attending",  tag:"Club",     icon:"camera.fill",       isToday:false)
//    ]
//}
//
//// ─────────────────────────────────────────────
//// MARK: - HomeFeedCard
//// ─────────────────────────────────────────────
//struct HomeFeedCard: View {
//    let event: HomeFeedEvent
//    @EnvironmentObject var store: UserProfileStore
//    @State private var showRSVPAlert = false
//
//    var isLiked: Bool { store.likedEventIDs.contains(event.id) }
//    var isSaved: Bool { store.isEventSaved(title: event.title) }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//
//            // Image area
//            ZStack(alignment: .top) {
//                Rectangle()
//                    .fill(Color(white: 0.12))
//                    .frame(height: 160)
//                    .overlay(Image(systemName: event.icon).font(.system(size: 48)).foregroundColor(Color(white: 0.28)))
//                    .clipShape(FeedTopRounded(radius: 14))
//
//                HStack {
//                    // Tag
//                    Text(event.tag)
//                        .font(.system(size: 11, weight: .medium)).foregroundColor(.white)
//                        .padding(.horizontal, 10).padding(.vertical, 5)
//                        .background(Color.black.opacity(0.65)).cornerRadius(6)
//
//                    Spacer()
//
//                    // Like button ❤️
//                    Button {
//                        withAnimation(.spring(response: 0.3)) {
//                            if isLiked { store.likedEventIDs.remove(event.id) }
//                            else { store.likedEventIDs.insert(event.id) }
//                        }
//                    } label: {
//                        Image(systemName: isLiked ? "heart.fill" : "heart")
//                            .foregroundColor(isLiked ? .red : .white)
//                            .font(.system(size: 18))
//                            .scaleEffect(isLiked ? 1.2 : 1.0)
//                            .animation(.spring(response: 0.25), value: isLiked)
//                    }
//
//                    // Bookmark / Save button
//                    Button {
//                        store.toggleSaveEvent(title: event.title, date: event.date, icon: event.icon, tag: event.tag)
//                    } label: {
//                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
//                            .foregroundColor(isSaved ? .white : .white)
//                            .font(.system(size: 17))
//                            .scaleEffect(isSaved ? 1.15 : 1.0)
//                            .animation(.spring(response: 0.25), value: isSaved)
//                    }
//                }
//                .padding(.horizontal, 10).padding(.top, 10)
//            }
//
//            // Info area
//            HStack {
//                VStack(alignment: .leading, spacing: 5) {
//                    Text(event.title).font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
//                    HStack(spacing: 5) {
//                        Image(systemName: "calendar").font(.system(size: 11)).foregroundColor(Color(white: 0.45))
//                        Text(event.date).font(.system(size: 12)).foregroundColor(Color(white: 0.45))
//                    }
//                    HStack(spacing: 5) {
//                        Image(systemName: "person.2.fill").font(.system(size: 11)).foregroundColor(Color(white: 0.38))
//                        Text(event.attendees).font(.system(size: 12)).foregroundColor(Color(white: 0.38))
//                    }
//                }
//                Spacer()
//                Button { showRSVPAlert = true } label: {
//                    Text("RSVP")
//                        .font(.system(size: 12, weight: .bold)).foregroundColor(.black)
//                        .padding(.horizontal, 14).padding(.vertical, 8)
//                        .background(Color.white).cornerRadius(8)
//                }
//            }
//            .padding(14).background(Color(white: 0.1)).clipShape(FeedBottomRounded(radius: 14))
//        }
//        .alert("RSVP Confirmed! 🎉", isPresented: $showRSVPAlert) {
//            Button("OK", role: .cancel) {}
//        } message: { Text("You're registered for \(event.title).") }
//    }
//}
//
//// ─────────────────────────────────────────────
//// MARK: - Shapes
//// ─────────────────────────────────────────────
//struct FeedTopRounded: Shape {
//    var radius: CGFloat
//    func path(in rect: CGRect) -> Path {
//        Path(UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath)
//    }
//}
//struct FeedBottomRounded: Shape {
//    var radius: CGFloat
//    func path(in rect: CGRect) -> Path {
//        Path(UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath)
//    }
//}
//
//#Preview {
//    struct W: View {
//        @State var tab = "home"
//        var body: some View { HomeFeedScreen(selectedTab: $tab).environmentObject(UserProfileStore()) }
//    }
//    return W()
//}


import SwiftUI

// ─────────────────────────────────────────────
// MARK: - HomeFeedScreen
// ─────────────────────────────────────────────
struct HomeFeedScreen: View {
    @Binding var selectedTab: String
    @EnvironmentObject var store: UserProfileStore

    @State private var selectedFilter   = "All"
    @State private var showNotifications = false

    private let filters = ["All", "Today", "Free"]

    var filteredEvents: [HomeFeedEvent] {
        switch selectedFilter {
        case "Today": return HomeFeedEvent.samples.filter { $0.isToday }
        case "Free":  return HomeFeedEvent.samples.filter { $0.tag == "Free" }
        default:      return HomeFeedEvent.samples
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {

                // ── Header ───────────────────────────────
                HStack {
                    Text("Home Feed").font(.system(size: 26, weight: .bold)).foregroundColor(.white)
                    Spacer()

                    // 🔔 Notification bell with badge
                    Button { showNotifications = true } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bell").font(.system(size: 22)).foregroundColor(.white)
                            if store.unreadCount > 0 {
                                ZStack {
                                    Circle().fill(Color.red).frame(width: 18, height: 18)
                                    Text(store.unreadCount > 9 ? "9+" : "\(store.unreadCount)")
                                        .font(.system(size: 10, weight: .bold)).foregroundColor(.white)
                                }
                                .offset(x: 8, y: -8)
                            }
                        }
                        .frame(width: 44, height: 44)
                    }
                }
                .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 14)

                // ── Filters ───────────────────────────────
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(filters, id: \.self) { f in
                            Button { selectedFilter = f } label: {
                                Text(f)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedFilter == f ? .black : .white)
                                    .padding(.horizontal, 18).padding(.vertical, 9)
                                    .background(selectedFilter == f ? Color.white : Color(white: 0.15))
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)

                // ── Events list ───────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        ForEach(filteredEvents) { event in
                            HomeFeedCard(event: event).environmentObject(store)
                        }
                        if filteredEvents.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "calendar.badge.exclamationmark")
                                    .font(.system(size: 40)).foregroundColor(Color(white: 0.25))
                                Text("No events found").font(.system(size: 16)).foregroundColor(Color(white: 0.4))
                            }
                            .frame(maxWidth: .infinity).padding(.top, 60)
                        }
                    }
                    .padding(.horizontal, 20).padding(.bottom, 110)
                }
            }
        }
        .sheet(isPresented: $showNotifications) {
            NotificationCenterSheet().environmentObject(store)
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - NotificationCenterSheet
// ─────────────────────────────────────────────
struct NotificationCenterSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: UserProfileStore
    @State private var filter = "All"

    private let filters = ["All", "Events", "Clubs"]

    var filtered: [AppNotification] {
        switch filter {
        case "Events": return store.notifications.filter { $0.category == "event" }
        case "Clubs":  return store.notifications.filter { $0.category == "club" }
        default:       return store.notifications
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {

                // Header
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark").font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                    }
                    Spacer()
                    Text("Notifications").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
                    Spacer()
                    if store.unreadCount > 0 {
                        Button {
                            withAnimation { store.markAllRead() }
                        } label: {
                            Text("Mark all read").font(.system(size: 12, weight: .medium)).foregroundColor(Color(white: 0.5))
                        }
                    } else {
                        Color.clear.frame(width: 80)
                    }
                }
                .padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 16)

                // Unread badge
                if store.unreadCount > 0 {
                    HStack(spacing: 8) {
                        Circle().fill(Color.red).frame(width: 8, height: 8)
                        Text("\(store.unreadCount) unread notification\(store.unreadCount == 1 ? "" : "s")")
                            .font(.system(size: 13)).foregroundColor(Color(white: 0.5))
                        Spacer()
                    }
                    .padding(.horizontal, 20).padding(.bottom, 12)
                }

                // Filter chips
                HStack(spacing: 10) {
                    ForEach(filters, id: \.self) { f in
                        Button { filter = f } label: {
                            Text(f)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(filter == f ? .black : .white)
                                .padding(.horizontal, 16).padding(.vertical, 8)
                                .background(filter == f ? Color.white : Color(white: 0.15))
                                .cornerRadius(20)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20).padding(.bottom, 16)

                Divider().background(Color(white: 0.12))

                // Notifications list
                if filtered.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "bell.slash").font(.system(size: 44)).foregroundColor(Color(white: 0.2))
                        Text("No notifications").font(.system(size: 16)).foregroundColor(Color(white: 0.4))
                    }
                    Spacer()
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            ForEach(filtered) { notif in
                                notifRow(notif)
                                Divider().background(Color(white: 0.1))
                            }
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }

    @ViewBuilder
    func notifRow(_ notif: AppNotification) -> some View {
        HStack(alignment: .top, spacing: 14) {
            // Icon
            ZStack {
                Circle()
                    .fill(notif.isRead ? Color(white: 0.12) : Color.white.opacity(0.12))
                    .frame(width: 44, height: 44)
                Image(systemName: notif.icon)
                    .font(.system(size: 18))
                    .foregroundColor(notif.isRead ? Color(white: 0.45) : .white)
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notif.title)
                        .font(.system(size: 14, weight: notif.isRead ? .regular : .semibold))
                        .foregroundColor(notif.isRead ? Color(white: 0.6) : .white)
                    Spacer()
                    if !notif.isRead {
                        Circle().fill(Color.white).frame(width: 7, height: 7)
                    }
                }
                Text(notif.body)
                    .font(.system(size: 12))
                    .foregroundColor(Color(white: notif.isRead ? 0.38 : 0.55))
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
                Text(notif.time)
                    .font(.system(size: 11))
                    .foregroundColor(Color(white: 0.3))
                    .padding(.top, 2)
            }
        }
        .padding(.horizontal, 20).padding(.vertical, 14)
        .background(notif.isRead ? Color.clear : Color.white.opacity(0.04))
        .onTapGesture {
            if let idx = store.notifications.firstIndex(where: { $0.id == notif.id }) {
                store.notifications[idx].isRead = true
            }
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - HomeFeedEvent Model
// ─────────────────────────────────────────────
struct HomeFeedEvent: Identifiable {
    let id = UUID()
    let title, date, attendees, tag, icon: String
    let isToday: Bool

    static let samples: [HomeFeedEvent] = [
        HomeFeedEvent(title:"Tech Talk: AI in 2025",  date:"Apr 3 · 9AM · Hall A",    attendees:"39 attending",  tag:"Free",     icon:"mic.fill",          isToday:false),
        HomeFeedEvent(title:"Inter-College Football",  date:"Apr 8 · 1PM · Ground",    attendees:"18 attending",  tag:"Cultural", icon:"soccerball",        isToday:true),
        HomeFeedEvent(title:"Annual Art Exhibition",   date:"Apr 5 · 10AM · Gallery",  attendees:"52 attending",  tag:"Cultural", icon:"paintpalette.fill",  isToday:false),
        HomeFeedEvent(title:"Coding Marathon",         date:"Apr 7 · 9AM · Lab 3",     attendees:"24 attending",  tag:"Free",     icon:"laptopcomputer",    isToday:false),
        HomeFeedEvent(title:"Music Fest",              date:"Apr 13 · 6PM · Grounds",  attendees:"120 attending", tag:"Free",     icon:"music.note",        isToday:false),
        HomeFeedEvent(title:"Photo Walk",              date:"Apr 19 · 6AM · Campus",   attendees:"32 attending",  tag:"Club",     icon:"camera.fill",       isToday:false)
    ]
}

// ─────────────────────────────────────────────
// MARK: - HomeFeedCard
// ─────────────────────────────────────────────
struct HomeFeedCard: View {
    let event: HomeFeedEvent
    @EnvironmentObject var store: UserProfileStore
    @State private var showRSVPAlert = false

    var isLiked: Bool { store.likedEventIDs.contains(event.id) }
    var isSaved: Bool { store.isEventSaved(title: event.title) }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image area
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color(white: 0.12)).frame(height: 160)
                    .overlay(Image(systemName: event.icon).font(.system(size: 48)).foregroundColor(Color(white: 0.28)))
                    .clipShape(FeedTopRounded(radius: 14))

                HStack {
                    Text(event.tag)
                        .font(.system(size: 11, weight: .medium)).foregroundColor(.white)
                        .padding(.horizontal, 10).padding(.vertical, 5)
                        .background(Color.black.opacity(0.65)).cornerRadius(6)
                    Spacer()

                    // ❤️ Like
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            if isLiked { store.likedEventIDs.remove(event.id) }
                            else        { store.likedEventIDs.insert(event.id) }
                        }
                    } label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : .white).font(.system(size: 18))
                            .scaleEffect(isLiked ? 1.2 : 1.0)
                            .animation(.spring(response: 0.25), value: isLiked)
                    }

                    // 🔖 Save
                    Button {
                        store.toggleSaveEvent(title: event.title, date: event.date, icon: event.icon, tag: event.tag)
                    } label: {
                        Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.white).font(.system(size: 17))
                            .scaleEffect(isSaved ? 1.15 : 1.0)
                            .animation(.spring(response: 0.25), value: isSaved)
                    }
                }
                .padding(.horizontal, 10).padding(.top, 10)
            }

            // Info area
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(event.title).font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                    HStack(spacing: 5) {
                        Image(systemName: "calendar").font(.system(size: 11)).foregroundColor(Color(white: 0.45))
                        Text(event.date).font(.system(size: 12)).foregroundColor(Color(white: 0.45))
                    }
                    HStack(spacing: 5) {
                        Image(systemName: "person.2.fill").font(.system(size: 11)).foregroundColor(Color(white: 0.38))
                        Text(event.attendees).font(.system(size: 12)).foregroundColor(Color(white: 0.38))
                    }
                }
                Spacer()
                Button { showRSVPAlert = true } label: {
                    Text("RSVP")
                        .font(.system(size: 12, weight: .bold)).foregroundColor(.black)
                        .padding(.horizontal, 14).padding(.vertical, 8)
                        .background(Color.white).cornerRadius(8)
                }
            }
            .padding(14).background(Color(white: 0.1)).clipShape(FeedBottomRounded(radius: 14))
        }
        .alert("RSVP Confirmed! 🎉", isPresented: $showRSVPAlert) {
            Button("OK", role: .cancel) {}
        } message: { Text("You're registered for \(event.title).") }
    }
}

// ─────────────────────────────────────────────
// MARK: - Shapes
// ─────────────────────────────────────────────
struct FeedTopRounded: Shape {
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath)
    }
}
struct FeedBottomRounded: Shape {
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath)
    }
}

#Preview {
    struct W: View {
        @State var tab = "home"
        var body: some View { HomeFeedScreen(selectedTab: $tab).environmentObject(UserProfileStore()) }
    }
    return W()
}
