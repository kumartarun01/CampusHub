import SwiftUI

struct ProfileScreen: View {
    struct StatItem {
        let value: String
        let label: String
    }

    struct MenuItem: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
        let subtitle: String
        let showChevron: Bool
        let isDestructive: Bool
    }

    let stats: [StatItem] = [
        StatItem(value: "12", label: "Events"),
        StatItem(value: "5", label: "Clubs"),
        StatItem(value: "34", label: "Following")
    ]

    let menuItems: [MenuItem] = [
        MenuItem(icon: "person.circle", title: "Edit Profile", subtitle: "Name, photo, bio", showChevron: true, isDestructive: false),
        MenuItem(icon: "bell", title: "Notifications", subtitle: "Manage alerts", showChevron: true, isDestructive: false),
        MenuItem(icon: "lock.shield", title: "Privacy & Security", subtitle: "Password, 2FA", showChevron: true, isDestructive: false),
        MenuItem(icon: "bookmark", title: "Saved Events", subtitle: "Your bookmarks", showChevron: true, isDestructive: false),
        MenuItem(icon: "info.circle", title: "About Us", subtitle: "App info & team", showChevron: true, isDestructive: false),
        MenuItem(icon: "star", title: "Rate the App", subtitle: "Share your feedback", showChevron: true, isDestructive: false),
        MenuItem(icon: "rectangle.portrait.and.arrow.right", title: "Log Out", subtitle: "", showChevron: false, isDestructive: true)
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Profile")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 24)

                    // Profile card
                    VStack(spacing: 16) {
                        // Avatar
                        ZStack {
                            Circle()
                                .fill(Color(white: 0.2))
                                .frame(width: 86, height: 86)
                            Text("AK")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)

                            // Edit badge
                            ZStack {
                                Circle().fill(Color.white).frame(width: 26, height: 26)
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                            .offset(x: 30, y: 30)
                        }

                        VStack(spacing: 4) {
                            Text("Arjun Kumar")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Text("CS Engineering · 3rd Year")
                                .font(.system(size: 13))
                                .foregroundColor(Color(white: 0.45))
                            Text("arjun.kumar@campus.edu")
                                .font(.system(size: 12))
                                .foregroundColor(Color(white: 0.35))
                        }

                        // Stats row
                        HStack(spacing: 0) {
                            ForEach(stats.indices, id: \.self) { i in
                                VStack(spacing: 4) {
                                    Text(stats[i].value)
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(.white)
                                    Text(stats[i].label)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color(white: 0.4))
                                }
                                .frame(maxWidth: .infinity)

                                if i < stats.count - 1 {
                                    Rectangle()
                                        .fill(Color(white: 0.15))
                                        .frame(width: 1, height: 36)
                                }
                            }
                        }
                        .padding(.vertical, 14)
                        .background(Color(white: 0.08))
                        .cornerRadius(14)

                        // Interests chips
                        VStack(alignment: .leading, spacing: 10) {
                            Text("INTERESTS")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(Color(white: 0.35))
                            FlowLayout(items: ["AI/ML", "Photography", "Music", "Football", "Coding"], spacing: 8)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(20)
                    .background(Color(white: 0.07))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)

                    // Menu items
                    VStack(spacing: 0) {
                        ForEach(menuItems) { item in
                            Button(action: {}) {
                                HStack(spacing: 14) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(item.isDestructive ? Color.red.opacity(0.15) : Color(white: 0.1))
                                            .frame(width: 40, height: 40)
                                        Image(systemName: item.icon)
                                            .font(.system(size: 16))
                                            .foregroundColor(item.isDestructive ? Color.red : .white)
                                    }

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(item.title)
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(item.isDestructive ? Color.red : .white)
                                        if !item.subtitle.isEmpty {
                                            Text(item.subtitle)
                                                .font(.system(size: 12))
                                                .foregroundColor(Color(white: 0.4))
                                        }
                                    }

                                    Spacer()

                                    if item.showChevron {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color(white: 0.3))
                                            .font(.system(size: 13, weight: .medium))
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                            }

                            if item.id != menuItems.last?.id {
                                Divider()
                                    .background(Color(white: 0.1))
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                    .background(Color(white: 0.07))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }

            // Bottom Tab Bar
            VStack {
                Spacer()
                BottomTabBar(selected: "profile")
            }
        }
    }
}

// Simple flow layout for interest chips
struct FlowLayout: View {
    let items: [String]
    let spacing: CGFloat

    var body: some View {
        var rows: [[String]] = [[]]
        var currentRowWidth: CGFloat = 0
        let maxWidth: CGFloat = UIScreen.main.bounds.width - 80

        for item in items {
            let itemWidth = CGFloat(item.count * 9 + 24)
            if currentRowWidth + itemWidth + spacing > maxWidth && !rows.last!.isEmpty {
                rows.append([item])
                currentRowWidth = itemWidth + spacing
            } else {
                rows[rows.count - 1].append(item)
                currentRowWidth += itemWidth + spacing
            }
        }

        return VStack(alignment: .leading, spacing: spacing) {
            ForEach(rows.indices, id: \.self) { rowIndex in
                HStack(spacing: spacing) {
                    ForEach(rows[rowIndex], id: \.self) { item in
                        Text(item)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(white: 0.15))
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileScreen()
}
