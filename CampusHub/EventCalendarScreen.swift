
import SwiftUI

// ─────────────────────────────────────────────
// MARK: - EventCalendarScreen
// ─────────────────────────────────────────────
struct EventCalendarScreen: View {
    @Binding var selectedTab: String
    @EnvironmentObject var store: UserProfileStore
    @State private var selectedDay = 8   // today

    private let weekdays     = ["S","M","T","W","T","F","S"]
    private let startOffset  = 2   // April 2025 starts Tuesday

    // Events keyed by day
    private let eventsByDay: [Int: [DayEvent]] = [
        3:  [DayEvent(title:"Tech Talk: AI in 2025",  time:"9AM · Hall A",    tag:"Free",     icon:"mic.fill")],
        5:  [DayEvent(title:"Annual Art Exhibition",   time:"10AM · Gallery",  tag:"Cultural", icon:"paintpalette.fill")],
        7:  [DayEvent(title:"Coding Marathon",         time:"9AM · Lab 3",     tag:"Free",     icon:"laptopcomputer")],
        8:  [DayEvent(title:"Inter-College Football",  time:"1PM · Ground",    tag:"Sports",   icon:"soccerball")],
        10: [DayEvent(title:"Book Club Meetup",        time:"4PM · Library",   tag:"Arts",     icon:"book.fill")],
        13: [DayEvent(title:"Music Fest",              time:"6PM · Grounds",   tag:"Free",     icon:"music.note")],
        15: [DayEvent(title:"Cricket Cup",             time:"10AM · Field",    tag:"Sports",   icon:"sportscourt.fill")],
        19: [DayEvent(title:"Photo Walk",              time:"6AM · Campus",    tag:"Club",     icon:"camera.fill")],
        20: [DayEvent(title:"Hackathon 2025",          time:"10AM · Lab Block", tag:"Tech",    icon:"desktopcomputer")],
        30: [DayEvent(title:"Robotics Demo",           time:"2PM · Lab B",     tag:"Tech",     icon:"desktopcomputer")]
    ]

    var eventsForSelected: [DayEvent] { eventsByDay[selectedDay] ?? [] }

    // Days that have events
    var eventDays: Set<Int> { Set(eventsByDay.keys) }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {

                // Header
                HStack {
                    Text("Event Calendar").font(.system(size: 26, weight: .bold)).foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 4)

                Text("Tap a date to see events · Bookmark to save")
                    .font(.system(size: 12)).foregroundColor(Color(white: 0.38))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20).padding(.bottom, 14)

                // Calendar card
                VStack(spacing: 10) {
                    // Month row
                    HStack {
                        Button {} label: { Image(systemName: "chevron.left").foregroundColor(Color(white: 0.5)).font(.system(size: 14)) }
                        Spacer()
                        Text("April 2025").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        Button {} label: { Image(systemName: "chevron.right").foregroundColor(Color(white: 0.5)).font(.system(size: 14)) }
                    }
                    .padding(.horizontal, 14)

                    // Weekday headers
                    HStack(spacing: 0) {
                        ForEach(weekdays, id: \.self) { d in
                            Text(d).font(.system(size: 12, weight: .medium)).foregroundColor(Color(white: 0.45))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 6)

                    // Day grid
                    let cols = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
                    LazyVGrid(columns: cols, spacing: 2) {
                        ForEach(0..<startOffset, id: \.self) { _ in Color.clear.frame(height: 40) }
                        ForEach(1...30, id: \.self) { day in
                            dayCell(day)
                        }
                    }
                    .padding(.horizontal, 6)
                }
                .padding(14)
                .background(Color(white: 0.08)).cornerRadius(16)
                .padding(.horizontal, 20).padding(.bottom, 16)

                // Bookmarks strip
                if !store.calendarBookmarks.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(store.calendarBookmarks) { bm in
                                HStack(spacing: 6) {
                                    Image(systemName: "bookmark.fill").font(.system(size: 11)).foregroundColor(.white)
                                    Text("Apr \(bm.day)").font(.system(size: 12, weight: .medium)).foregroundColor(.white)
                                }
                                .padding(.horizontal, 12).padding(.vertical, 7)
                                .background(Color(white: 0.15)).cornerRadius(20)
                                .onTapGesture { selectedDay = bm.day }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 12)
                }

                // Events for selected day
                Text("EVENTS · APRIL \(selectedDay)")
                    .font(.system(size: 12, weight: .semibold)).foregroundColor(Color(white: 0.38))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20).padding(.bottom, 10)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        if eventsForSelected.isEmpty {
                            VStack(spacing: 10) {
                                Image(systemName: "calendar.badge.minus")
                                    .font(.system(size: 36)).foregroundColor(Color(white: 0.22))
                                Text("No events on this day")
                                    .font(.system(size: 14)).foregroundColor(Color(white: 0.38))
                            }
                            .frame(maxWidth: .infinity).padding(.top, 30)
                        } else {
                            ForEach(eventsForSelected) { ev in
                                HStack(alignment: .top, spacing: 14) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10).fill(Color(white: 0.12)).frame(width: 40, height: 40)
                                        Image(systemName: ev.icon).font(.system(size: 17)).foregroundColor(.white)
                                    }
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(ev.title).font(.system(size: 14, weight: .semibold)).foregroundColor(.white)
                                        HStack(spacing: 4) {
                                            Image(systemName: "clock").font(.system(size: 11)).foregroundColor(Color(white: 0.4))
                                            Text(ev.time).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
                                        }
                                    }
                                    Spacer()
                                    Text(ev.tag)
                                        .font(.system(size: 11, weight: .medium)).foregroundColor(Color(white: 0.6))
                                        .padding(.horizontal, 10).padding(.vertical, 4)
                                        .background(Color(white: 0.12)).cornerRadius(6)
                                }
                                .padding(.horizontal, 20).padding(.vertical, 14)
                                Divider().background(Color(white: 0.12)).padding(.horizontal, 20)
                            }
                        }
                    }
                    .padding(.bottom, 110)
                }
            }
        }
    }

    @ViewBuilder
    func dayCell(_ day: Int) -> some View {
        let isSelected  = day == selectedDay
        let hasEvent    = eventDays.contains(day)
        let isBookmarked = store.isDayBookmarked(day: day)

        Button {
            withAnimation(.easeInOut(duration: 0.15)) { selectedDay = day }
        } label: {
            ZStack {
                if isSelected {
                    Circle().fill(Color.white).frame(width: 34, height: 34)
                }
                VStack(spacing: 2) {
                    Text("\(day)")
                        .font(.system(size: 14, weight: isSelected ? .bold : .regular))
                        .foregroundColor(isSelected ? .black : .white)

                    // Event dot
                    if hasEvent && !isSelected {
                        Circle().fill(Color.white.opacity(0.7)).frame(width: 4, height: 4)
                    }
                }
            }
            .frame(height: 40)
            .overlay(alignment: .topTrailing) {
                if isBookmarked {
                    Image(systemName: "bookmark.fill")
                        .font(.system(size: 8)).foregroundColor(.white)
                        .offset(x: 2, y: -2)
                }
            }
        }
        .contextMenu {
            if hasEvent {
                let evTitle = eventsByDay[day]?.first?.title ?? "Event"
                Button {
                    store.toggleDayBookmark(day: day, title: evTitle)
                } label: {
                    Label(
                        store.isDayBookmarked(day: day) ? "Remove Bookmark" : "Bookmark Apr \(day)",
                        systemImage: store.isDayBookmarked(day: day) ? "bookmark.slash" : "bookmark"
                    )
                }
            }
            Button { selectedDay = day } label: {
                Label("View Events", systemImage: "calendar")
            }
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - DayEvent Model
// ─────────────────────────────────────────────
struct DayEvent: Identifiable {
    let id    = UUID()
    let title:  String
    let time:   String
    let tag:    String
    let icon:   String
}

#Preview {
    struct W: View {
        @State var tab = "calendar"
        var body: some View { EventCalendarScreen(selectedTab: $tab).environmentObject(UserProfileStore()) }
    }
    return W()
}
