//
//import SwiftUI
//
//// ─────────────────────────────────────────────
//// MARK: - EventCalendarScreen
//// ─────────────────────────────────────────────
//struct EventCalendarScreen: View {
//    @Binding var selectedTab: String
//    @EnvironmentObject var store: UserProfileStore
//    @State private var selectedDay = 8   // today
//
//    private let weekdays     = ["S","M","T","W","T","F","S"]
//    private let startOffset  = 2   // April 2025 starts Tuesday
//
//    // Events keyed by day
//    private let eventsByDay: [Int: [DayEvent]] = [
//        3:  [DayEvent(title:"Tech Talk: AI in 2025",  time:"9AM · Hall A",    tag:"Free",     icon:"mic.fill")],
//        5:  [DayEvent(title:"Annual Art Exhibition",   time:"10AM · Gallery",  tag:"Cultural", icon:"paintpalette.fill")],
//        7:  [DayEvent(title:"Coding Marathon",         time:"9AM · Lab 3",     tag:"Free",     icon:"laptopcomputer")],
//        8:  [DayEvent(title:"Inter-College Football",  time:"1PM · Ground",    tag:"Sports",   icon:"soccerball")],
//        10: [DayEvent(title:"Book Club Meetup",        time:"4PM · Library",   tag:"Arts",     icon:"book.fill")],
//        13: [DayEvent(title:"Music Fest",              time:"6PM · Grounds",   tag:"Free",     icon:"music.note")],
//        15: [DayEvent(title:"Cricket Cup",             time:"10AM · Field",    tag:"Sports",   icon:"sportscourt.fill")],
//        19: [DayEvent(title:"Photo Walk",              time:"6AM · Campus",    tag:"Club",     icon:"camera.fill")],
//        20: [DayEvent(title:"Hackathon 2025",          time:"10AM · Lab Block", tag:"Tech",    icon:"desktopcomputer")],
//        30: [DayEvent(title:"Robotics Demo",           time:"2PM · Lab B",     tag:"Tech",     icon:"desktopcomputer")]
//    ]
//
//    var eventsForSelected: [DayEvent] { eventsByDay[selectedDay] ?? [] }
//
//    // Days that have events
//    var eventDays: Set<Int> { Set(eventsByDay.keys) }
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            VStack(spacing: 0) {
//
//                // Header
//                HStack {
//                    Text("Event Calendar").font(.system(size: 26, weight: .bold)).foregroundColor(.white)
//                    Spacer()
//                }
//                .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 4)
//
//                Text("Tap a date to see events · Bookmark to save")
//                    .font(.system(size: 12)).foregroundColor(Color(white: 0.38))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal, 20).padding(.bottom, 14)
//
//                // Calendar card
//                VStack(spacing: 10) {
//                    // Month row
//                    HStack {
//                        Button {} label: { Image(systemName: "chevron.left").foregroundColor(Color(white: 0.5)).font(.system(size: 14)) }
//                        Spacer()
//                        Text("April 2025").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
//                        Spacer()
//                        Button {} label: { Image(systemName: "chevron.right").foregroundColor(Color(white: 0.5)).font(.system(size: 14)) }
//                    }
//                    .padding(.horizontal, 14)
//
//                    // Weekday headers
//                    HStack(spacing: 0) {
//                        ForEach(weekdays, id: \.self) { d in
//                            Text(d).font(.system(size: 12, weight: .medium)).foregroundColor(Color(white: 0.45))
//                                .frame(maxWidth: .infinity)
//                        }
//                    }
//                    .padding(.horizontal, 6)
//
//                    // Day grid
//                    let cols = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
//                    LazyVGrid(columns: cols, spacing: 2) {
//                        ForEach(0..<startOffset, id: \.self) { _ in Color.clear.frame(height: 40) }
//                        ForEach(1...30, id: \.self) { day in
//                            dayCell(day)
//                        }
//                    }
//                    .padding(.horizontal, 6)
//                }
//                .padding(14)
//                .background(Color(white: 0.08)).cornerRadius(16)
//                .padding(.horizontal, 20).padding(.bottom, 16)
//
//                // Bookmarks strip
//                if !store.calendarBookmarks.isEmpty {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 10) {
//                            ForEach(store.calendarBookmarks) { bm in
//                                HStack(spacing: 6) {
//                                    Image(systemName: "bookmark.fill").font(.system(size: 11)).foregroundColor(.white)
//                                    Text("Apr \(bm.day)").font(.system(size: 12, weight: .medium)).foregroundColor(.white)
//                                }
//                                .padding(.horizontal, 12).padding(.vertical, 7)
//                                .background(Color(white: 0.15)).cornerRadius(20)
//                                .onTapGesture { selectedDay = bm.day }
//                            }
//                        }
//                        .padding(.horizontal, 20)
//                    }
//                    .padding(.bottom, 12)
//                }
//
//                // Events for selected day
//                Text("EVENTS · APRIL \(selectedDay)")
//                    .font(.system(size: 12, weight: .semibold)).foregroundColor(Color(white: 0.38))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal, 20).padding(.bottom, 10)
//
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 0) {
//                        if eventsForSelected.isEmpty {
//                            VStack(spacing: 10) {
//                                Image(systemName: "calendar.badge.minus")
//                                    .font(.system(size: 36)).foregroundColor(Color(white: 0.22))
//                                Text("No events on this day")
//                                    .font(.system(size: 14)).foregroundColor(Color(white: 0.38))
//                            }
//                            .frame(maxWidth: .infinity).padding(.top, 30)
//                        } else {
//                            ForEach(eventsForSelected) { ev in
//                                HStack(alignment: .top, spacing: 14) {
//                                    ZStack {
//                                        RoundedRectangle(cornerRadius: 10).fill(Color(white: 0.12)).frame(width: 40, height: 40)
//                                        Image(systemName: ev.icon).font(.system(size: 17)).foregroundColor(.white)
//                                    }
//                                    VStack(alignment: .leading, spacing: 4) {
//                                        Text(ev.title).font(.system(size: 14, weight: .semibold)).foregroundColor(.white)
//                                        HStack(spacing: 4) {
//                                            Image(systemName: "clock").font(.system(size: 11)).foregroundColor(Color(white: 0.4))
//                                            Text(ev.time).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
//                                        }
//                                    }
//                                    Spacer()
//                                    Text(ev.tag)
//                                        .font(.system(size: 11, weight: .medium)).foregroundColor(Color(white: 0.6))
//                                        .padding(.horizontal, 10).padding(.vertical, 4)
//                                        .background(Color(white: 0.12)).cornerRadius(6)
//                                }
//                                .padding(.horizontal, 20).padding(.vertical, 14)
//                                Divider().background(Color(white: 0.12)).padding(.horizontal, 20)
//                            }
//                        }
//                    }
//                    .padding(.bottom, 110)
//                }
//            }
//        }
//    }
//
//    @ViewBuilder
//    func dayCell(_ day: Int) -> some View {
//        let isSelected  = day == selectedDay
//        let hasEvent    = eventDays.contains(day)
//        let isBookmarked = store.isDayBookmarked(day: day)
//
//        Button {
//            withAnimation(.easeInOut(duration: 0.15)) { selectedDay = day }
//        } label: {
//            ZStack {
//                if isSelected {
//                    Circle().fill(Color.white).frame(width: 34, height: 34)
//                }
//                VStack(spacing: 2) {
//                    Text("\(day)")
//                        .font(.system(size: 14, weight: isSelected ? .bold : .regular))
//                        .foregroundColor(isSelected ? .black : .white)
//
//                    // Event dot
//                    if hasEvent && !isSelected {
//                        Circle().fill(Color.white.opacity(0.7)).frame(width: 4, height: 4)
//                    }
//                }
//            }
//            .frame(height: 40)
//            .overlay(alignment: .topTrailing) {
//                if isBookmarked {
//                    Image(systemName: "bookmark.fill")
//                        .font(.system(size: 8)).foregroundColor(.white)
//                        .offset(x: 2, y: -2)
//                }
//            }
//        }
//        .contextMenu {
//            if hasEvent {
//                let evTitle = eventsByDay[day]?.first?.title ?? "Event"
//                Button {
//                    store.toggleDayBookmark(day: day, title: evTitle)
//                } label: {
//                    Label(
//                        store.isDayBookmarked(day: day) ? "Remove Bookmark" : "Bookmark Apr \(day)",
//                        systemImage: store.isDayBookmarked(day: day) ? "bookmark.slash" : "bookmark"
//                    )
//                }
//            }
//            Button { selectedDay = day } label: {
//                Label("View Events", systemImage: "calendar")
//            }
//        }
//    }
//}
//
//// ─────────────────────────────────────────────
//// MARK: - DayEvent Model
//// ─────────────────────────────────────────────
//struct DayEvent: Identifiable {
//    let id    = UUID()
//    let title:  String
//    let time:   String
//    let tag:    String
//    let icon:   String
//}
//
//#Preview {
//    struct W: View {
//        @State var tab = "calendar"
//        var body: some View { EventCalendarScreen(selectedTab: $tab).environmentObject(UserProfileStore()) }
//    }
//    return W()
//}


import SwiftUI

// ─────────────────────────────────────────────
// MARK: - EventCalendarScreen
// ─────────────────────────────────────────────
struct EventCalendarScreen: View {
    @Binding var selectedTab: String
    @EnvironmentObject var store: UserProfileStore

    @State private var selectedDay   = 8
    @State private var showAddEvent  = false

    private let weekdays    = ["S","M","T","W","T","F","S"]
    private let startOffset = 2   // April 2025 starts Tuesday

    // Built-in events keyed by day
    private let builtInEvents: [Int: [DayEvent]] = [
        3:  [DayEvent(title:"Tech Talk: AI in 2025",  time:"9AM · Hall A",     tag:"Free",     icon:"mic.fill")],
        5:  [DayEvent(title:"Annual Art Exhibition",   time:"10AM · Gallery",   tag:"Cultural", icon:"paintpalette.fill")],
        7:  [DayEvent(title:"Coding Marathon",         time:"9AM · Lab 3",      tag:"Free",     icon:"laptopcomputer")],
        8:  [DayEvent(title:"Inter-College Football",  time:"1PM · Ground",     tag:"Sports",   icon:"soccerball")],
        10: [DayEvent(title:"Book Club Meetup",        time:"4PM · Library",    tag:"Arts",     icon:"book.fill")],
        13: [DayEvent(title:"Music Fest",              time:"6PM · Grounds",    tag:"Free",     icon:"music.note")],
        15: [DayEvent(title:"Cricket Cup",             time:"10AM · Field",     tag:"Sports",   icon:"sportscourt.fill")],
        19: [DayEvent(title:"Photo Walk",              time:"6AM · Campus",     tag:"Club",     icon:"camera.fill")],
        20: [DayEvent(title:"Hackathon 2025",          time:"10AM · Lab Block", tag:"Tech",     icon:"desktopcomputer")],
        30: [DayEvent(title:"Robotics Demo",           time:"2PM · Lab B",      tag:"Tech",     icon:"desktopcomputer")]
    ]

    var allEventsForSelected: [DayEvent] {
        store.allEventsForDay(selectedDay, builtIn: builtInEvents)
    }

    // Days that have any events
    var daysWithEvents: Set<Int> {
        var days = Set(builtInEvents.keys)
        for ce in store.customEvents { days.insert(ce.day) }
        return days
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {

                // ── Header ───────────────────────────────
                HStack {
                    Text("Event Calendar").font(.system(size: 26, weight: .bold)).foregroundColor(.white)
                    Spacer()
                    // Add event button
                    Button { showAddEvent = true } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24)).foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 4)

                Text("Tap date to see events · Long-press to bookmark")
                    .font(.system(size: 12)).foregroundColor(Color(white: 0.35))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20).padding(.bottom, 14)

                // ── Calendar card ─────────────────────────
                VStack(spacing: 10) {
                    HStack {
                        Button {} label: { Image(systemName: "chevron.left").foregroundColor(Color(white: 0.5)).font(.system(size: 14)) }
                        Spacer()
                        Text("April 2025").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        Button {} label: { Image(systemName: "chevron.right").foregroundColor(Color(white: 0.5)).font(.system(size: 14)) }
                    }
                    .padding(.horizontal, 14)

                    HStack(spacing: 0) {
                        ForEach(weekdays, id: \.self) { d in
                            Text(d).font(.system(size: 12, weight: .medium)).foregroundColor(Color(white: 0.45)).frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 6)

                    let cols = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
                    LazyVGrid(columns: cols, spacing: 2) {
                        ForEach(0..<startOffset, id: \.self) { _ in Color.clear.frame(height: 44) }
                        ForEach(1...30, id: \.self) { day in dayCell(day) }
                    }
                    .padding(.horizontal, 6)
                }
                .padding(14)
                .background(Color(white: 0.08)).cornerRadius(16)
                .padding(.horizontal, 20).padding(.bottom, 14)

                // ── Bookmarked days strip ─────────────────
                if !store.calendarBookmarks.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            Text("Bookmarks:").font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.35))
                            ForEach(store.calendarBookmarks.sorted(by: { $0.day < $1.day })) { bm in
                                Button { withAnimation { selectedDay = bm.day } } label: {
                                    HStack(spacing: 5) {
                                        Image(systemName: "bookmark.fill").font(.system(size: 10)).foregroundColor(.white)
                                        Text("Apr \(bm.day)").font(.system(size: 12, weight: .medium)).foregroundColor(.white)
                                    }
                                    .padding(.horizontal, 12).padding(.vertical, 7)
                                    .background(selectedDay == bm.day ? Color(white: 0.3) : Color(white: 0.15))
                                    .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 12)
                }

                // ── Events for selected day ───────────────
                HStack {
                    Text("EVENTS · APRIL \(selectedDay)")
                        .font(.system(size: 12, weight: .semibold)).foregroundColor(Color(white: 0.38))
                    Spacer()
                    Button { showAddEvent = true } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "plus").font(.system(size: 11, weight: .semibold))
                            Text("Add").font(.system(size: 12, weight: .semibold))
                        }
                        .foregroundColor(Color(white: 0.5))
                        .padding(.horizontal, 12).padding(.vertical, 6)
                        .background(Color(white: 0.12)).cornerRadius(14)
                    }
                }
                .padding(.horizontal, 20).padding(.bottom, 10)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        if allEventsForSelected.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "calendar.badge.plus")
                                    .font(.system(size: 36)).foregroundColor(Color(white: 0.22))
                                Text("No events on April \(selectedDay)")
                                    .font(.system(size: 14)).foregroundColor(Color(white: 0.38))
                                Button { showAddEvent = true } label: {
                                    Text("Add an event")
                                        .font(.system(size: 13, weight: .semibold)).foregroundColor(.black)
                                        .padding(.horizontal, 20).padding(.vertical, 10)
                                        .background(Color.white).cornerRadius(10)
                                }
                            }
                            .frame(maxWidth: .infinity).padding(.top, 30)
                        } else {
                            ForEach(allEventsForSelected) { ev in
                                eventRow(ev)
                                Divider().background(Color(white: 0.12)).padding(.horizontal, 20)
                            }
                        }
                    }
                    .padding(.bottom, 110)
                }
            }
        }
        .sheet(isPresented: $showAddEvent) {
            AddCalendarEventSheet(preselectedDay: selectedDay)
                .environmentObject(store)
        }
    }

    // MARK: – Day cell
    @ViewBuilder
    func dayCell(_ day: Int) -> some View {
        let isSelected   = day == selectedDay
        let hasEvent     = daysWithEvents.contains(day)
        let isBookmarked = store.isDayBookmarked(day: day)
        let hasCustom    = store.customEvents.contains(where: { $0.day == day })

        Button { withAnimation(.easeInOut(duration: 0.15)) { selectedDay = day } } label: {
            ZStack {
                if isSelected { Circle().fill(Color.white).frame(width: 34, height: 34) }
                VStack(spacing: 3) {
                    Text("\(day)")
                        .font(.system(size: 14, weight: isSelected ? .bold : .regular))
                        .foregroundColor(isSelected ? .black : .white)
                    HStack(spacing: 2) {
                        if hasEvent && !isSelected { Circle().fill(Color.white.opacity(0.7)).frame(width: 4, height: 4) }
                        if hasCustom && !isSelected { Circle().fill(Color.green.opacity(0.8)).frame(width: 4, height: 4) }
                    }
                }
            }
            .frame(height: 44)
            .overlay(alignment: .topTrailing) {
                if isBookmarked {
                    Image(systemName: "bookmark.fill")
                        .font(.system(size: 8)).foregroundColor(.white)
                        .offset(x: 2, y: -2)
                }
            }
        }
        .contextMenu {
            Button {
                let evTitle = builtInEvents[day]?.first?.title ?? "Apr \(day)"
                store.toggleDayBookmark(day: day, title: evTitle)
            } label: {
                Label(store.isDayBookmarked(day: day) ? "Remove Bookmark" : "Bookmark Apr \(day)",
                      systemImage: store.isDayBookmarked(day: day) ? "bookmark.slash" : "bookmark")
            }
            Button { showAddEvent = true } label: {
                Label("Add Event on Apr \(day)", systemImage: "plus.circle")
            }
        }
    }

    // MARK: – Event row
    @ViewBuilder
    func eventRow(_ ev: DayEvent) -> some View {
        HStack(alignment: .center, spacing: 14) {
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
    }
}

// ─────────────────────────────────────────────
// MARK: - AddCalendarEventSheet
// ─────────────────────────────────────────────
struct AddCalendarEventSheet: View {
    @EnvironmentObject var store: UserProfileStore
    @Environment(\.dismiss) var dismiss

    var preselectedDay: Int

    @State private var title     = ""
    @State private var day       = 1
    @State private var timeHour  = 9
    @State private var timeMin   = 0
    @State private var location  = ""
    @State private var tag       = "Personal"
    @State private var icon      = "calendar"
    @State private var showError = false
    @State private var saved     = false

    private let tags  = ["Personal","Academic","Sports","Arts","Tech","Social","Other"]
    private let icons = ["calendar","star.fill","book.fill","sportscourt.fill","music.note","camera.fill","laptopcomputer","desktopcomputer","person.3.fill","heart.fill"]
    private let hours = Array(0...23)
    private let mins  = [0, 15, 30, 45]

    var timeString: String { String(format: "%d:%02d %@", timeHour % 12 == 0 ? 12 : timeHour % 12, timeMin, timeHour < 12 ? "AM" : "PM") }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if saved {
                // Success
                VStack(spacing: 20) {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill").font(.system(size: 64)).foregroundColor(.green)
                    Text("Event Added!").font(.system(size: 24, weight: .bold)).foregroundColor(.white)
                    Text("'\(title)' has been added to\nApril \(day).")
                        .font(.system(size: 15)).foregroundColor(Color(white: 0.5))
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button { dismiss() } label: {
                        Text("Done")
                            .font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                            .frame(maxWidth: .infinity).frame(height: 52)
                            .background(Color.white).cornerRadius(13)
                    }
                    .padding(.horizontal, 24).padding(.bottom, 40)
                }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // Header
                        HStack {
                            Button { dismiss() } label: {
                                Text("Cancel").font(.system(size: 15)).foregroundColor(Color(white: 0.55))
                            }
                            Spacer()
                            Text("Add Event").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
                            Spacer()
                            Button(action: save) {
                                Text("Save")
                                    .font(.system(size: 15, weight: .semibold)).foregroundColor(.black)
                                    .padding(.horizontal, 16).padding(.vertical, 7)
                                    .background(title.isEmpty ? Color(white: 0.3) : Color.white)
                                    .cornerRadius(10)
                            }
                            .disabled(title.isEmpty)
                        }
                        .padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 28)

                        VStack(spacing: 18) {

                            // Event title
                            VStack(alignment: .leading, spacing: 8) {
                                fieldLabel("Event Title")
                                HStack(spacing: 12) {
                                    Image(systemName: "text.cursor").foregroundColor(Color(white: 0.4)).font(.system(size: 15))
                                    TextField("", text: $title, prompt: Text("e.g. Study Group Meeting").foregroundColor(Color(white: 0.3)))
                                        .foregroundColor(.white).font(.system(size: 14))
                                }
                                .inputStyle()
                            }

                            // Day picker
                            VStack(alignment: .leading, spacing: 8) {
                                fieldLabel("Day in April")
                                HStack(spacing: 0) {
                                    // Decrease
                                    Button { if day > 1 { day -= 1 } } label: {
                                        Image(systemName: "minus").font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                                            .frame(width: 44, height: 44)
                                            .background(Color(white: 0.12)).cornerRadius(10)
                                    }

                                    Spacer()
                                    VStack(spacing: 2) {
                                        Text("April \(day)")
                                            .font(.system(size: 18, weight: .bold)).foregroundColor(.white)
                                        Text(dayOfWeek(day))
                                            .font(.system(size: 12)).foregroundColor(Color(white: 0.45))
                                    }
                                    Spacer()

                                    // Increase
                                    Button { if day < 30 { day += 1 } } label: {
                                        Image(systemName: "plus").font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                                            .frame(width: 44, height: 44)
                                            .background(Color(white: 0.12)).cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal, 16).padding(.vertical, 14)
                                .background(Color(white: 0.1)).cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
                            }

                            // Time picker
                            VStack(alignment: .leading, spacing: 8) {
                                fieldLabel("Time")
                                HStack(spacing: 10) {
                                    // Hour
                                    Menu {
                                        ForEach(hours, id: \.self) { h in
                                            Button(String(format: "%02d", h)) { timeHour = h }
                                        }
                                    } label: {
                                        timePickerChip(String(format: "%02d", timeHour), suffix: "hr")
                                    }

                                    Text(":").font(.system(size: 18, weight: .bold)).foregroundColor(Color(white: 0.4))

                                    // Minute
                                    Menu {
                                        ForEach(mins, id: \.self) { m in
                                            Button(String(format: "%02d", m)) { timeMin = m }
                                        }
                                    } label: {
                                        timePickerChip(String(format: "%02d", timeMin), suffix: "min")
                                    }

                                    Text(timeHour < 12 ? "AM" : "PM")
                                        .font(.system(size: 15, weight: .semibold)).foregroundColor(Color(white: 0.6))
                                        .padding(.leading, 4)

                                    Spacer()
                                    Text(timeString).font(.system(size: 14, weight: .semibold)).foregroundColor(Color(white: 0.4))
                                }
                            }

                            // Location
                            VStack(alignment: .leading, spacing: 8) {
                                fieldLabel("Location (optional)")
                                HStack(spacing: 12) {
                                    Image(systemName: "mappin").foregroundColor(Color(white: 0.4)).font(.system(size: 15))
                                    TextField("", text: $location, prompt: Text("e.g. Room 204, Library").foregroundColor(Color(white: 0.3)))
                                        .foregroundColor(.white).font(.system(size: 14))
                                }
                                .inputStyle()
                            }

                            // Tag
                            VStack(alignment: .leading, spacing: 8) {
                                fieldLabel("Category")
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(tags, id: \.self) { t in
                                            Button { tag = t } label: {
                                                Text(t)
                                                    .font(.system(size: 12, weight: .medium))
                                                    .foregroundColor(tag == t ? .black : .white)
                                                    .padding(.horizontal, 14).padding(.vertical, 8)
                                                    .background(tag == t ? Color.white : Color(white: 0.15))
                                                    .cornerRadius(20)
                                            }
                                        }
                                    }
                                }
                            }

                            // Icon
                            VStack(alignment: .leading, spacing: 10) {
                                fieldLabel("Icon")
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 10) {
                                    ForEach(icons, id: \.self) { ic in
                                        Button { icon = ic } label: {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(icon == ic ? Color.white : Color(white: 0.12))
                                                    .frame(height: 48)
                                                Image(systemName: ic)
                                                    .font(.system(size: 20))
                                                    .foregroundColor(icon == ic ? .black : Color(white: 0.6))
                                            }
                                        }
                                    }
                                }
                            }

                            if showError {
                                Text("Please enter an event title.")
                                    .font(.system(size: 13)).foregroundColor(.red)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(20).background(Color(white: 0.07)).cornerRadius(20)
                        .padding(.horizontal, 20).padding(.bottom, 30)

                        Button(action: save) {
                            Text("Save Event")
                                .font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                                .frame(maxWidth: .infinity).frame(height: 52)
                                .background(title.isEmpty ? Color(white: 0.25) : Color.white)
                                .cornerRadius(13)
                        }
                        .disabled(title.isEmpty)
                        .padding(.horizontal, 20).padding(.bottom, 40)
                    }
                }
            }
        }
        .onAppear { day = preselectedDay }
    }

    func save() {
        let trimmed = title.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { showError = true; return }
        let loc = location.trimmingCharacters(in: .whitespaces)
        let timeStr = loc.isEmpty ? timeString : "\(timeString) · \(loc)"
        let ev = CustomCalendarEvent(day: day, month: "April", title: trimmed,
                                     time: timeStr, location: loc, tag: tag, icon: icon)
        store.customEvents.append(ev)
        withAnimation { saved = true }
    }

    func dayOfWeek(_ day: Int) -> String {
        // April 2025: April 1 = Tuesday (offset 2)
        let weekdays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        return weekdays[(day + 1) % 7]  // April 1 = Tue
    }

    func fieldLabel(_ t: String) -> some View {
        Text(t).font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.5))
    }

    @ViewBuilder
    func timePickerChip(_ value: String, suffix: String) -> some View {
        VStack(spacing: 2) {
            Text(value).font(.system(size: 22, weight: .bold)).foregroundColor(.white)
            Text(suffix).font(.system(size: 10)).foregroundColor(Color(white: 0.4))
        }
        .frame(width: 64, height: 54)
        .background(Color(white: 0.12)).cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(white: 0.22), lineWidth: 1))
    }
}

// ─────────────────────────────────────────────
// MARK: - Input Style Modifier
// ─────────────────────────────────────────────
extension View {
    func inputStyle() -> some View {
        self
            .padding(.horizontal, 16).padding(.vertical, 14)
            .background(Color(white: 0.1)).cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
    }
}

#Preview {
    struct W: View {
        @State var tab = "calendar"
        var body: some View { EventCalendarScreen(selectedTab: $tab).environmentObject(UserProfileStore()) }
    }
    return W()
}
