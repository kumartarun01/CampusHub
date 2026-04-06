//import SwiftUI
//
//struct ProfileScreen: View {
//    struct StatItem {
//        let value: String
//        let label: String
//    }
//
//    struct MenuItem: Identifiable {
//        let id = UUID()
//        let icon: String
//        let title: String
//        let subtitle: String
//        let showChevron: Bool
//        let isDestructive: Bool
//    }
//
//    let stats: [StatItem] = [
//        StatItem(value: "12", label: "Events"),
//        StatItem(value: "5", label: "Clubs"),
//        StatItem(value: "34", label: "Following")
//    ]
//
//    let menuItems: [MenuItem] = [
//        MenuItem(icon: "person.circle", title: "Edit Profile", subtitle: "Name, photo, bio", showChevron: true, isDestructive: false),
//        MenuItem(icon: "bell", title: "Notifications", subtitle: "Manage alerts", showChevron: true, isDestructive: false),
//        MenuItem(icon: "lock.shield", title: "Privacy & Security", subtitle: "Password, 2FA", showChevron: true, isDestructive: false),
//        MenuItem(icon: "bookmark", title: "Saved Events", subtitle: "Your bookmarks", showChevron: true, isDestructive: false),
//        MenuItem(icon: "info.circle", title: "About Us", subtitle: "App info & team", showChevron: true, isDestructive: false),
//        MenuItem(icon: "star", title: "Rate the App", subtitle: "Share your feedback", showChevron: true, isDestructive: false),
//        MenuItem(icon: "rectangle.portrait.and.arrow.right", title: "Log Out", subtitle: "", showChevron: false, isDestructive: true)
//    ]
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 0) {
//                    // Header
//                    HStack {
//                        Text("Profile")
//                            .font(.system(size: 26, weight: .bold))
//                            .foregroundColor(.white)
//                        Spacer()
//                        Button(action: {}) {
//                            Image(systemName: "square.and.pencil")
//                                .font(.system(size: 18))
//                                .foregroundColor(.white)
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.top, 16)
//                    .padding(.bottom, 24)
//
//                    // Profile card
//                    VStack(spacing: 16) {
//                        // Avatar
//                        ZStack {
//                            Circle()
//                                .fill(Color(white: 0.2))
//                                .frame(width: 86, height: 86)
//                            Text("AK")
//                                .font(.system(size: 28, weight: .bold))
//                                .foregroundColor(.white)
//
//                            // Edit badge
//                            ZStack {
//                                Circle().fill(Color.white).frame(width: 26, height: 26)
//                                Image(systemName: "camera.fill")
//                                    .font(.system(size: 12))
//                                    .foregroundColor(.black)
//                            }
//                            .offset(x: 30, y: 30)
//                        }
//
//                        VStack(spacing: 4) {
//                            Text("Arjun Kumar")
//                                .font(.system(size: 20, weight: .bold))
//                                .foregroundColor(.white)
//                            Text("CS Engineering · 3rd Year")
//                                .font(.system(size: 13))
//                                .foregroundColor(Color(white: 0.45))
//                            Text("arjun.kumar@campus.edu")
//                                .font(.system(size: 12))
//                                .foregroundColor(Color(white: 0.35))
//                        }
//
//                        // Stats row
//                        HStack(spacing: 0) {
//                            ForEach(stats.indices, id: \.self) { i in
//                                VStack(spacing: 4) {
//                                    Text(stats[i].value)
//                                        .font(.system(size: 22, weight: .bold))
//                                        .foregroundColor(.white)
//                                    Text(stats[i].label)
//                                        .font(.system(size: 12))
//                                        .foregroundColor(Color(white: 0.4))
//                                }
//                                .frame(maxWidth: .infinity)
//
//                                if i < stats.count - 1 {
//                                    Rectangle()
//                                        .fill(Color(white: 0.15))
//                                        .frame(width: 1, height: 36)
//                                }
//                            }
//                        }
//                        .padding(.vertical, 14)
//                        .background(Color(white: 0.08))
//                        .cornerRadius(14)
//
//                        // Interests chips
//                        VStack(alignment: .leading, spacing: 10) {
//                            Text("INTERESTS")
//                                .font(.system(size: 11, weight: .semibold))
//                                .foregroundColor(Color(white: 0.35))
//                            FlowLayout(items: ["AI/ML", "Photography", "Music", "Football", "Coding"], spacing: 8)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    .padding(20)
//                    .background(Color(white: 0.07))
//                    .cornerRadius(20)
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 20)
//
//                    // Menu items
//                    VStack(spacing: 0) {
//                        ForEach(menuItems) { item in
//                            Button(action: {}) {
//                                HStack(spacing: 14) {
//                                    ZStack {
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .fill(item.isDestructive ? Color.red.opacity(0.15) : Color(white: 0.1))
//                                            .frame(width: 40, height: 40)
//                                        Image(systemName: item.icon)
//                                            .font(.system(size: 16))
//                                            .foregroundColor(item.isDestructive ? Color.red : .white)
//                                    }
//
//                                    VStack(alignment: .leading, spacing: 2) {
//                                        Text(item.title)
//                                            .font(.system(size: 15, weight: .medium))
//                                            .foregroundColor(item.isDestructive ? Color.red : .white)
//                                        if !item.subtitle.isEmpty {
//                                            Text(item.subtitle)
//                                                .font(.system(size: 12))
//                                                .foregroundColor(Color(white: 0.4))
//                                        }
//                                    }
//
//                                    Spacer()
//
//                                    if item.showChevron {
//                                        Image(systemName: "chevron.right")
//                                            .foregroundColor(Color(white: 0.3))
//                                            .font(.system(size: 13, weight: .medium))
//                                    }
//                                }
//                                .padding(.horizontal, 20)
//                                .padding(.vertical, 14)
//                            }
//
//                            if item.id != menuItems.last?.id {
//                                Divider()
//                                    .background(Color(white: 0.1))
//                                    .padding(.horizontal, 20)
//                            }
//                        }
//                    }
//                    .background(Color(white: 0.07))
//                    .cornerRadius(20)
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 100)
//                }
//            }
//
//            // Bottom Tab Bar
//            VStack {
//                Spacer()
//                BottomTabBar(selected: "profile")
//            }
//        }
//    }
//}
//
//// Simple flow layout for interest chips
//struct FlowLayout: View {
//    let items: [String]
//    let spacing: CGFloat
//
//    var body: some View {
//        var rows: [[String]] = [[]]
//        var currentRowWidth: CGFloat = 0
//        let maxWidth: CGFloat = UIScreen.main.bounds.width - 80
//
//        for item in items {
//            let itemWidth = CGFloat(item.count * 9 + 24)
//            if currentRowWidth + itemWidth + spacing > maxWidth && !rows.last!.isEmpty {
//                rows.append([item])
//                currentRowWidth = itemWidth + spacing
//            } else {
//                rows[rows.count - 1].append(item)
//                currentRowWidth += itemWidth + spacing
//            }
//        }
//
//        return VStack(alignment: .leading, spacing: spacing) {
//            ForEach(rows.indices, id: \.self) { rowIndex in
//                HStack(spacing: spacing) {
//                    ForEach(rows[rowIndex], id: \.self) { item in
//                        Text(item)
//                            .font(.system(size: 12, weight: .medium))
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 6)
//                            .background(Color(white: 0.15))
//                            .cornerRadius(20)
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ProfileScreen()
//}


import SwiftUI
import PhotosUI

// ─────────────────────────────────────────────
// MARK: - ProfileScreen
// ─────────────────────────────────────────────
struct ProfileScreen: View {
    @Binding var selectedTab: String
    @EnvironmentObject var store: UserProfileStore

    @State private var pickerItem:       PhotosPickerItem?
    @State private var showPhotoPicker   = false
    @State private var showPhotoDialog   = false
    @State private var showLogoutAlert   = false

    @State private var goEdit            = false
    @State private var goNotifications   = false
    @State private var goPrivacy         = false
    @State private var goSaved           = false
    @State private var goAbout           = false
    @State private var goReview          = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.black.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        topBar
                        avatarCard
                        menuCard
                    }
                }

                BottomTabBar(selectedTab: $selectedTab)
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationBarHidden(true)

            // ── Destinations ──────────────────────────────
            .navigationDestination(isPresented: $goEdit) {
                EditProfileScreen().environmentObject(store)
            }
            .navigationDestination(isPresented: $goNotifications) {
                NotificationSettingsScreen().environmentObject(store)
            }
            .navigationDestination(isPresented: $goPrivacy) {
                PrivacySecurityScreen().environmentObject(store)
            }
            .navigationDestination(isPresented: $goSaved) {
                SavedEventsScreen().environmentObject(store)
            }
            .navigationDestination(isPresented: $goAbout) {
                AboutUsScreen()
            }
            .navigationDestination(isPresented: $goReview) {
                ReviewScreen()
            }

            // ── Photo Picker ──────────────────────────────
            .photosPicker(isPresented: $showPhotoPicker,
                          selection: $pickerItem,
                          matching: .images)
            .onChange(of: pickerItem) { item in
                Task {
                    if let data = try? await item?.loadTransferable(type: Data.self),
                       let img  = UIImage(data: data) {
                        await MainActor.run { store.profileImage = img }
                    }
                }
            }
            .confirmationDialog("Profile Photo", isPresented: $showPhotoDialog,
                                titleVisibility: .visible) {
                Button("Choose from Library") { showPhotoPicker = true }
                Button("Remove Photo", role: .destructive) { store.profileImage = nil }
                Button("Cancel", role: .cancel) {}
            }
            .alert("Log Out", isPresented: $showLogoutAlert) {
                Button("Log Out", role: .destructive) {}
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to log out?")
            }
        }
    }

    // ─────────────────────────────────────────
    // MARK: Top bar
    // ─────────────────────────────────────────
    var topBar: some View {
        HStack {
            Text("Profile")
                .font(.system(size: 26, weight: .bold)).foregroundColor(.white)
            Spacer()
            Button { goEdit = true } label: {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 18)).foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 22)
    }

    // ─────────────────────────────────────────
    // MARK: Avatar + info card
    // ─────────────────────────────────────────
    var avatarCard: some View {
        VStack(spacing: 16) {

            // Photo
            ZStack(alignment: .bottomTrailing) {
                avatarImage
                Button { showPhotoDialog = true } label: {
                    ZStack {
                        Circle().fill(Color.white).frame(width: 30, height: 30)
                        Image(systemName: "camera.fill")
                            .font(.system(size: 13)).foregroundColor(.black)
                    }
                }
                .offset(x: 2, y: 2)
            }

            // Name / info
            VStack(spacing: 4) {
                Text(store.name)
                    .font(.system(size: 20, weight: .bold)).foregroundColor(.white)
                Text("\(store.department) · \(store.year)")
                    .font(.system(size: 13)).foregroundColor(Color(white: 0.45))
                Text(store.email)
                    .font(.system(size: 12)).foregroundColor(Color(white: 0.32))
                if !store.bio.isEmpty {
                    Text(store.bio)
                        .font(.system(size: 13)).foregroundColor(Color(white: 0.50))
                        .multilineTextAlignment(.center).lineSpacing(3)
                        .padding(.top, 4).padding(.horizontal, 6)
                }
            }

            // Stats
            statsRow

            // Interests
            VStack(alignment: .leading, spacing: 10) {
                Text("INTERESTS")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(Color(white: 0.35))
                ProfileFlowLayout(items: store.interests)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .background(Color(white: 0.07)).cornerRadius(20)
        .padding(.horizontal, 20).padding(.bottom, 20)
    }

    @ViewBuilder
    var avatarImage: some View {
        Group {
            if let img = store.profileImage {
                Image(uiImage: img).resizable().scaledToFill()
            } else {
                ZStack {
                    Circle().fill(Color(white: 0.22))
                    Text(store.initials)
                        .font(.system(size: 30, weight: .bold)).foregroundColor(.white)
                }
            }
        }
        .frame(width: 90, height: 90)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color(white: 0.25), lineWidth: 2))
    }

    var statsRow: some View {
        HStack(spacing: 0) {
            ForEach([("12","Events"),("5","Clubs"),("34","Following")], id: \.0) { s in
                VStack(spacing: 4) {
                    Text(s.0).font(.system(size: 22, weight: .bold)).foregroundColor(.white)
                    Text(s.1).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
                }
                .frame(maxWidth: .infinity)
                if s.1 != "Following" {
                    Rectangle().fill(Color(white: 0.15)).frame(width: 1, height: 36)
                }
            }
        }
        .padding(.vertical, 14)
        .background(Color(white: 0.08)).cornerRadius(14)
    }

    // ─────────────────────────────────────────
    // MARK: Menu card
    // ─────────────────────────────────────────
    var menuCard: some View {
        VStack(spacing: 0) {
            menuRow(icon: "person.circle",
                    title: "Edit Profile",      sub: "Name, photo, bio")  { goEdit = true }
            menuDivider
            menuRow(icon: "bell",
                    title: "Notifications",     sub: "Manage alerts")      { goNotifications = true }
            menuDivider
            menuRow(icon: "lock.shield",
                    title: "Privacy & Security",sub: "Password, 2FA")      { goPrivacy = true }
            menuDivider
            menuRow(icon: "bookmark",
                    title: "Saved Events",      sub: "Your bookmarks")     { goSaved = true }
            menuDivider
            menuRow(icon: "info.circle",
                    title: "About Us",          sub: "App info & team")    { goAbout = true }
            menuDivider
            menuRow(icon: "star",
                    title: "Rate the App",      sub: "Share feedback")     { goReview = true }
            menuDivider
            logoutRow
        }
        .background(Color(white: 0.07)).cornerRadius(20)
        .padding(.horizontal, 20).padding(.bottom, 110)
    }

    @ViewBuilder
    func menuRow(icon: String, title: String, sub: String,
                 action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                iconBox(icon, red: false)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.system(size: 15, weight: .medium)).foregroundColor(.white)
                    Text(sub).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(white: 0.28))
            }
            .padding(.horizontal, 20).padding(.vertical, 14)
        }
    }

    var logoutRow: some View {
        Button { showLogoutAlert = true } label: {
            HStack(spacing: 14) {
                iconBox("rectangle.portrait.and.arrow.right", red: true)
                Text("Log Out")
                    .font(.system(size: 15, weight: .medium)).foregroundColor(.red)
                Spacer()
            }
            .padding(.horizontal, 20).padding(.vertical, 14)
        }
    }

    func iconBox(_ name: String, red: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(red ? Color.red.opacity(0.15) : Color(white: 0.12))
                .frame(width: 40, height: 40)
            Image(systemName: name)
                .font(.system(size: 16))
                .foregroundColor(red ? .red : .white)
        }
    }

    var menuDivider: some View {
        Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
    }
}

// ─────────────────────────────────────────────
// MARK: - ProfileFlowLayout  (chip rows)
// ─────────────────────────────────────────────
struct ProfileFlowLayout: View {
    let items: [String]

    var body: some View {
        var rows: [[String]] = [[]]
        var rowW: CGFloat = 0
        let maxW: CGFloat = UIScreen.main.bounds.width - 80

        for item in items {
            let w = CGFloat(item.count * 9 + 28)
            if rowW + w + 8 > maxW, !rows.last!.isEmpty {
                rows.append([item]); rowW = w + 8
            } else {
                rows[rows.count - 1].append(item); rowW += w + 8
            }
        }

        return VStack(alignment: .leading, spacing: 8) {
            ForEach(rows.indices, id: \.self) { ri in
                HStack(spacing: 8) {
                    ForEach(rows[ri], id: \.self) { chip in
                        Text(chip)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12).padding(.vertical, 6)
                            .background(Color(white: 0.15))
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

#Preview {
    struct Wrap: View {
        @State var tab = "profile"
        var body: some View {
            ProfileScreen(selectedTab: $tab).environmentObject(UserProfileStore())
        }
    }
    return Wrap()
}
