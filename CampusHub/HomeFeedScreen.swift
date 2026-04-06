//import SwiftUI
//
//struct EventCard: Identifiable {
//    let id = UUID()
//    let title: String
//    let date: String
//    let attendees: String
//    let tag: String
//    let tagColor: Color
//    let imageName: String
//    let showRSVP: Bool
//}
//
//struct HomeFeedScreen: View {
//    @State private var selectedFilter = "All"
//    let filters = ["All", "Today", "Free"]
//
//    let events: [EventCard] = [
//        EventCard(title: "Tech Talk: AI in 2025", date: "Apr 1 · 10AM · Hall A", attendees: "39s attending", tag: "Free", tagColor: Color(white: 0.15), imageName: "mic", showRSVP: true),
//        EventCard(title: "Inter-College Football", date: "Apr 1 · 19AM · Gaatory", attendees: "18s attending", tag: "Cultural", tagColor: Color(white: 0.15), imageName: "soccerball", showRSVP: true)
//    ]
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//
//            VStack(spacing: 0) {
//                // Header
//                HStack {
//                    Text("Home Feed")
//                        .font(.system(size: 26, weight: .bold))
//                        .foregroundColor(.white)
//                    Spacer()
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 16)
//                .padding(.bottom, 14)
//
//                // Filter chips
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 10) {
//                        ForEach(filters, id: \.self) { filter in
//                            Button(action: { selectedFilter = filter }) {
//                                Text(filter)
//                                    .font(.system(size: 14, weight: .medium))
//                                    .foregroundColor(selectedFilter == filter ? .black : .white)
//                                    .padding(.horizontal, 18)
//                                    .padding(.vertical, 9)
//                                    .background(selectedFilter == filter ? Color.white : Color(white: 0.15))
//                                    .cornerRadius(20)
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                }
//                .padding(.bottom, 20)
//
//                // Events list
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 14) {
//                        ForEach(events) { event in
//                            HomeFeedEventCard(event: event)
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 100)
//                }
//            }
//
//            // Bottom Tab Bar
//            VStack {
//                Spacer()
//                BottomTabBar(selected: "home")
//            }
//        }
//    }
//}
//
//struct HomeFeedEventCard: View {
//    let event: EventCard
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            // Image area
//            ZStack(alignment: .topLeading) {
//                RoundedRectangle(cornerRadius: 0)
//                    .fill(Color(white: 0.12))
//                    .frame(height: 160)
//                    .overlay(
//                        Image(systemName: event.imageName)
//                            .font(.system(size: 48))
//                            .foregroundColor(Color(white: 0.3))
//                    )
//
//                // Tag
//                Text("Flamme")
//                    .font(.system(size: 11, weight: .medium))
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 5)
//                    .background(Color.black.opacity(0.7))
//                    .cornerRadius(6)
//                    .padding(10)
//
//                // Heart
//                HStack {
//                    Spacer()
//                    Image(systemName: "heart")
//                        .foregroundColor(.white)
//                        .font(.system(size: 16))
//                        .padding(10)
//                }
//            }
//            .cornerRadius(14, corners: [.topLeft, .topRight])
//
//            // Info area
//            VStack(alignment: .leading, spacing: 6) {
//                HStack {
//                    Text(event.title)
//                        .font(.system(size: 17, weight: .semibold))
//                        .foregroundColor(.white)
//                    Spacer()
//                    if event.showRSVP {
//                        Text("RSVP")
//                            .font(.system(size: 12, weight: .bold))
//                            .foregroundColor(.black)
//                            .padding(.horizontal, 14)
//                            .padding(.vertical, 7)
//                            .background(Color.white)
//                            .cornerRadius(8)
//                    }
//                }
//
//                HStack(spacing: 6) {
//                    Image(systemName: "calendar")
//                        .font(.system(size: 12))
//                        .foregroundColor(Color(white: 0.5))
//                    Text(event.date)
//                        .font(.system(size: 12))
//                        .foregroundColor(Color(white: 0.5))
//                }
//
//                HStack(spacing: 6) {
//                    Image(systemName: "person.2.fill")
//                        .font(.system(size: 12))
//                        .foregroundColor(Color(white: 0.4))
//                    Text(event.attendees)
//                        .font(.system(size: 12))
//                        .foregroundColor(Color(white: 0.4))
//                }
//            }
//            .padding(14)
//            .background(Color(white: 0.1))
//            .cornerRadius(14, corners: [.bottomLeft, .bottomRight])
//        }
//        .clipShape(RoundedRectangle(cornerRadius: 14))
//    }
//}
//
//// MARK: - Corner Radius Helper
//extension View {
//    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
//        clipShape(RoundedCorner(radius: radius, corners: corners))
//    }
//}
//
//struct RoundedCorner: Shape {
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(
//            roundedRect: rect,
//            byRoundingCorners: corners,
//            cornerRadii: CGSize(width: radius, height: radius)
//        )
//        return Path(path.cgPath)
//    }
//}
//
//#Preview {
//    HomeFeedScreen()
//}


//import SwiftUI
//
//// ─────────────────────────────────────────────
//// MARK: - HomeFeedScreen
//// ─────────────────────────────────────────────
//struct HomeFeedScreen: View {
//    @Binding var selectedTab: String
//    @State private var selectedFilter = "All"
//
//    private let filters = ["All", "Today", "Free"]
//
//    private struct FeedEvent: Identifiable {
//        let id = UUID()
//        let title: String
//        let date: String
//        let attendees: String
//        let tag: String
//        let icon: String
//    }
//
//    private let events: [FeedEvent] = [
//        FeedEvent(title: "Tech Talk: AI in 2025",   date: "Apr 1 · 10AM · Hall A",    attendees: "39 attending", tag: "Free",     icon: "mic.fill"),
//        FeedEvent(title: "Inter-College Football",   date: "Apr 1 · 1PM · Ground",      attendees: "18 attending", tag: "Cultural", icon: "soccerball"),
//        FeedEvent(title: "Annual Art Exhibition",    date: "Apr 5 · 10AM · Gallery",    attendees: "52 attending", tag: "Cultural", icon: "paintpalette.fill"),
//        FeedEvent(title: "Coding Marathon",          date: "Apr 7 · 9AM · Lab 3",       attendees: "24 attending", tag: "Free",     icon: "laptopcomputer")
//    ]
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            VStack(spacing: 0) {
//
//                // Header
//                HStack {
//                    Text("Home Feed")
//                        .font(.system(size: 26, weight: .bold))
//                        .foregroundColor(.white)
//                    Spacer()
//                    Button {} label: {
//                        Image(systemName: "bell")
//                            .font(.system(size: 20))
//                            .foregroundColor(.white)
//                    }
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 16)
//                .padding(.bottom, 14)
//
//                // Filter chips
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
//                        ForEach(events) { event in
//                            FeedCard(event: event)
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 110)
//                }
//            }
//        }
//    }
//}
//
//// ─────────────────────────────────────────────
//// MARK: - FeedCard
//// ─────────────────────────────────────────────
//private struct FeedCard: View {
//    let event: HomeFeedScreen.FeedEvent
//
//    // expose FeedEvent so it can be used in extension below
//    fileprivate init(event: HomeFeedScreen.FeedEvent) { self.event = event }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            // Image placeholder
//            ZStack(alignment: .topLeading) {
//                Rectangle()
//                    .fill(Color(white: 0.12))
//                    .frame(height: 160)
//                    .overlay(
//                        Image(systemName: event.icon)
//                            .font(.system(size: 48))
//                            .foregroundColor(Color(white: 0.28))
//                    )
//                    .clipShape(RoundedTopCorners(radius: 14))
//
//                Text(event.tag)
//                    .font(.system(size: 11, weight: .medium))
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 10).padding(.vertical, 5)
//                    .background(Color.black.opacity(0.65))
//                    .cornerRadius(6)
//                    .padding(10)
//
//                HStack {
//                    Spacer()
//                    Image(systemName: "heart")
//                        .foregroundColor(.white)
//                        .font(.system(size: 16))
//                        .padding(10)
//                }
//            }
//
//            // Info
//            HStack {
//                VStack(alignment: .leading, spacing: 5) {
//                    Text(event.title)
//                        .font(.system(size: 16, weight: .semibold))
//                        .foregroundColor(.white)
//                    HStack(spacing: 5) {
//                        Image(systemName: "calendar")
//                            .font(.system(size: 11))
//                            .foregroundColor(Color(white: 0.45))
//                        Text(event.date)
//                            .font(.system(size: 12))
//                            .foregroundColor(Color(white: 0.45))
//                    }
//                    HStack(spacing: 5) {
//                        Image(systemName: "person.2.fill")
//                            .font(.system(size: 11))
//                            .foregroundColor(Color(white: 0.38))
//                        Text(event.attendees)
//                            .font(.system(size: 12))
//                            .foregroundColor(Color(white: 0.38))
//                    }
//                }
//                Spacer()
//                Text("RSVP")
//                    .font(.system(size: 12, weight: .bold))
//                    .foregroundColor(.black)
//                    .padding(.horizontal, 14).padding(.vertical, 8)
//                    .background(Color.white)
//                    .cornerRadius(8)
//            }
//            .padding(14)
//            .background(Color(white: 0.1))
//            .clipShape(RoundedBottomCorners(radius: 14))
//        }
//    }
//}
//
//// ─────────────────────────────────────────────
//// MARK: - Corner helpers (used only in this file)
//// ─────────────────────────────────────────────
//private struct RoundedTopCorners: Shape {
//    var radius: CGFloat
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect,
//                                byRoundingCorners: [.topLeft, .topRight],
//                                cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}
//
//private struct RoundedBottomCorners: Shape {
//    var radius: CGFloat
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect,
//                                byRoundingCorners: [.bottomLeft, .bottomRight],
//                                cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}
//
//#Preview {
//    struct Wrap: View {
//        @State var tab = "home"
//        var body: some View { HomeFeedScreen(selectedTab: $tab) }
//    }
//    return Wrap()
//}


import SwiftUI

// ─────────────────────────────────────────────
// MARK: - HomeFeedScreen
// ─────────────────────────────────────────────
struct HomeFeedScreen: View {
    @Binding var selectedTab: String
    @State private var selectedFilter = "All"

    private let filters = ["All", "Today", "Free"]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Home Feed")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Button {} label: {
                        Image(systemName: "bell")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 14)

                // Filter chips
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

                // Events list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        ForEach(HomeFeedEvent.samples) { event in
                            HomeFeedCard(event: event)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 110)
                }
            }
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - HomeFeedEvent model (internal, not private)
// ─────────────────────────────────────────────
struct HomeFeedEvent: Identifiable {
    let id        = UUID()
    let title:      String
    let date:       String
    let attendees:  String
    let tag:        String
    let icon:       String

    static let samples: [HomeFeedEvent] = [
        HomeFeedEvent(title: "Tech Talk: AI in 2025",  date: "Apr 1 · 10AM · Hall A",  attendees: "39 attending",  tag: "Free",     icon: "mic.fill"),
        HomeFeedEvent(title: "Inter-College Football", date: "Apr 1 · 1PM · Ground",    attendees: "18 attending",  tag: "Cultural", icon: "soccerball"),
        HomeFeedEvent(title: "Annual Art Exhibition",  date: "Apr 5 · 10AM · Gallery",  attendees: "52 attending",  tag: "Cultural", icon: "paintpalette.fill"),
        HomeFeedEvent(title: "Coding Marathon",        date: "Apr 7 · 9AM · Lab 3",     attendees: "24 attending",  tag: "Free",     icon: "laptopcomputer")
    ]
}

// ─────────────────────────────────────────────
// MARK: - HomeFeedCard
// ─────────────────────────────────────────────
struct HomeFeedCard: View {
    let event: HomeFeedEvent

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image area
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color(white: 0.12))
                    .frame(height: 160)
                    .overlay(
                        Image(systemName: event.icon)
                            .font(.system(size: 48))
                            .foregroundColor(Color(white: 0.28))
                    )
                    .clipShape(FeedTopRounded(radius: 14))

                Text(event.tag)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10).padding(.vertical, 5)
                    .background(Color.black.opacity(0.65))
                    .cornerRadius(6)
                    .padding(10)

                HStack {
                    Spacer()
                    Image(systemName: "heart")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .padding(10)
                }
            }

            // Info area
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(event.title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    HStack(spacing: 5) {
                        Image(systemName: "calendar")
                            .font(.system(size: 11))
                            .foregroundColor(Color(white: 0.45))
                        Text(event.date)
                            .font(.system(size: 12))
                            .foregroundColor(Color(white: 0.45))
                    }
                    HStack(spacing: 5) {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 11))
                            .foregroundColor(Color(white: 0.38))
                        Text(event.attendees)
                            .font(.system(size: 12))
                            .foregroundColor(Color(white: 0.38))
                    }
                }
                Spacer()
                Text("RSVP")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 14).padding(.vertical, 8)
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .padding(14)
            .background(Color(white: 0.1))
            .clipShape(FeedBottomRounded(radius: 14))
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - Shapes (unique names to avoid conflicts)
// ─────────────────────────────────────────────
struct FeedTopRounded: Shape {
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        ).cgPath)
    }
}

struct FeedBottomRounded: Shape {
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        Path(UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: radius, height: radius)
        ).cgPath)
    }
}

#Preview {
    struct Wrap: View {
        @State var tab = "home"
        var body: some View { HomeFeedScreen(selectedTab: $tab) }
    }
    return Wrap()
}
