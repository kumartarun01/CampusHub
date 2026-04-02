import SwiftUI

struct EventCalendarScreen: View {
    @State private var selectedDay = 4
    @State private var selectedFilter = "All"
    let filters = ["All", "Events", "Clubs"]

    let days = Array(1...28)
    let weekdays = ["S", "M", "T", "W", "T", "F", "S"]

    struct CalendarEvent: Identifiable {
        let id = UUID()
        let title: String
        let time: String
        let tag: String
        let tagColor: Color
    }

    let weekEvents: [CalendarEvent] = [
        CalendarEvent(title: "Tech Talk: AI in 2025", time: "Apr 3 · 9AM · Hall A", tag: "Flamme", tagColor: Color(white: 0.15)),
        CalendarEvent(title: "Coding Marathon", time: "Apr 2 · 19SM · Hall 3", tag: "Saach", tagColor: Color(white: 0.15)),
        CalendarEvent(title: "Art Exhibition", time: "Apr 3 · 10A · AgiAI abd", tag: "Coimng", tagColor: Color(white: 0.15))
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("Event Calendar")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)

                Text("Soreesstad")
                    .font(.system(size: 13))
                    .foregroundColor(Color(white: 0.4))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)

                // Calendar
                VStack(spacing: 0) {
                    // Month navigation
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color(white: 0.5))
                                .font(.system(size: 14))
                        }
                        Spacer()
                        Text("April 2025")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(white: 0.5))
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)

                    // Weekday headers
                    HStack(spacing: 0) {
                        ForEach(weekdays, id: \.self) { day in
                            Text(day)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(white: 0.45))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)

                    // Day grid
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
                    LazyVGrid(columns: columns, spacing: 6) {
                        ForEach(days, id: \.self) { day in
                            Button(action: { selectedDay = day }) {
                                ZStack {
                                    if selectedDay == day {
                                        Circle()
                                            .fill(Color.white)
                                            .frame(width: 34, height: 34)
                                    }
                                    Text("\(day)")
                                        .font(.system(size: 14, weight: selectedDay == day ? .bold : .regular))
                                        .foregroundColor(selectedDay == day ? .black : .white)
                                }
                                .frame(height: 36)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                }
                .background(Color(white: 0.08))
                .cornerRadius(16)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                // Events This Week header
                Text("EVENTS THIS WEEK")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color(white: 0.4))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)

                // Event rows
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(weekEvents) { event in
                            HStack(alignment: .top, spacing: 12) {
                                Circle()
                                    .fill(Color(white: 0.25))
                                    .frame(width: 8, height: 8)
                                    .padding(.top, 6)

                                VStack(alignment: .leading, spacing: 3) {
                                    Text(event.title)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.white)
                                    HStack(spacing: 4) {
                                        Image(systemName: "calendar")
                                            .font(.system(size: 11))
                                            .foregroundColor(Color(white: 0.4))
                                        Text(event.time)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(white: 0.4))
                                    }
                                }

                                Spacer()

                                Text(event.tag)
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(Color(white: 0.6))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color(white: 0.12))
                                    .cornerRadius(6)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)

                            Divider()
                                .background(Color(white: 0.12))
                                .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 100)
                }
            }

            // Bottom Tab Bar
            VStack {
                Spacer()
                BottomTabBar(selected: "calendar")
            }
        }
    }
}

#Preview {
    EventCalendarScreen()
}
