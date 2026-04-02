import SwiftUI

struct ClubsScreen: View {
    @State private var selectedFilter = "All"
    let filters = ["All", "Events", "Clubs"]

    struct Club: Identifiable {
        let id = UUID()
        let initials: String
        let name: String
        let subtitle: String
        let tag: String
        let tagStyle: TagStyle
    }

    enum TagStyle {
        case outline, filled
    }

    let clubs: [Club] = [
        Club(initials: "CS", name: "CS & AI Club", subtitle: "Filth'n emoped · 2\nwtt·indgge roanting", tag: "Freeless", tagStyle: .outline),
        Club(initials: "SP", name: "Sports Council", subtitle: "Bre·Imoeented · event\ntoocomed", tag: "Gobing", tagStyle: .filled),
        Club(initials: "MU", name: "Music Club", subtitle: "Rob emano · g\nbooos diiims", tag: "RSVng", tagStyle: .filled),
        Club(initials: "PH", name: "Photography Club", subtitle: "Jgpr Flies · 9oms", tag: "Flamse", tagStyle: .outline)
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

                Text("Soree nstd")
                    .font(.system(size: 13))
                    .foregroundColor(Color(white: 0.4))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)

                // Filter chips
                HStack(spacing: 10) {
                    ForEach(filters, id: \.self) { filter in
                        Button(action: { selectedFilter = filter }) {
                            Text(filter)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(selectedFilter == filter ? .black : .white)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 9)
                                .background(selectedFilter == filter ? Color.white : Color(white: 0.15))
                                .cornerRadius(20)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                // Clubs list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(clubs) { club in
                            HStack(spacing: 14) {
                                // Avatar
                                ZStack {
                                    Circle()
                                        .fill(Color(white: 0.15))
                                        .frame(width: 50, height: 50)
                                    Text(club.initials)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(club.name)
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text(club.subtitle)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color(white: 0.45))
                                        .lineSpacing(2)
                                }

                                Spacer()

                                // Tag
                                Text(club.tag)
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(club.tagStyle == .filled ? .black : .white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(club.tagStyle == .filled ? Color.white : Color.clear)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(club.tagStyle == .outline ? Color(white: 0.4) : Color.clear, lineWidth: 1)
                                    )
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)

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
                BottomTabBar(selected: "clubs")
            }
        }
    }
}

#Preview {
    ClubsScreen()
}
