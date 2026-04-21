
import SwiftUI
import PhotosUI
import FirebaseAuth

// ─────────────────────────────────────────────
// MARK: - ProfileScreen
// ─────────────────────────────────────────────
struct ProfileScreen: View {
    @Binding var selectedTab: String
    @EnvironmentObject var store:    UserProfileStore
    @EnvironmentObject var appState: AppState

    @State private var pickerItem:     PhotosPickerItem?
    @State private var showPhotoPicker = false
    @State private var showPhotoDialog = false
    @State private var showLogoutAlert = false

    @State private var goEdit          = false
    @State private var goNotifications = false
    @State private var goPrivacy       = false
    @State private var goSaved         = false
    @State private var goAbout         = false
    @State private var goReview        = false

    var body: some View {
        // NavigationStack ONLY here — sub-screens use dismiss()
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
            .photosPicker(isPresented: $showPhotoPicker, selection: $pickerItem, matching: .images)
            .onChange(of: pickerItem) { item in
                Task {
                    if let data = try? await item?.loadTransferable(type: Data.self),
                       let img  = UIImage(data: data) {
                        await MainActor.run { store.profileImage = img }
                    }
                }
            }
            .confirmationDialog("Profile Photo", isPresented: $showPhotoDialog, titleVisibility: .visible) {
                Button("Choose from Library") { showPhotoPicker = true }
                Button("Remove Photo", role: .destructive) { store.profileImage = nil }
                Button("Cancel", role: .cancel) {}
            }
            .alert("Log Out", isPresented: $showLogoutAlert) {
                Button("Log Out", role: .destructive) {
                    try? Auth.auth().signOut()
                    appState.screen = .login
                }
                Button("Cancel", role: .cancel) {}
            } message: { Text("Are you sure you want to log out?") }
        }
    }

    // MARK: – Top bar
    var topBar: some View {
        HStack {
            Text("Profile").font(.system(size: 26, weight: .bold)).foregroundColor(.white)
            Spacer()
            Button { goEdit = true } label: {
                Image(systemName: "square.and.pencil").font(.system(size: 18)).foregroundColor(.white)
            }
        }
        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 22)
    }

    // MARK: – Avatar card
    var avatarCard: some View {
        VStack(spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                avatarImage
                Button { showPhotoDialog = true } label: {
                    ZStack {
                        Circle().fill(Color.white).frame(width: 30, height: 30)
                        Image(systemName: "camera.fill").font(.system(size: 13)).foregroundColor(.black)
                    }
                }
                .offset(x: 2, y: 2)
            }

            VStack(spacing: 4) {
                Text(store.name).font(.system(size: 20, weight: .bold)).foregroundColor(.white)
                Text("\(store.department) · \(store.year)").font(.system(size: 13)).foregroundColor(Color(white: 0.45))
                Text(store.email).font(.system(size: 12)).foregroundColor(Color(white: 0.32))
                if !store.bio.isEmpty {
                    Text(store.bio).font(.system(size: 13)).foregroundColor(Color(white: 0.50))
                        .multilineTextAlignment(.center).lineSpacing(3).padding(.top, 4)
                }
            }

            // Stats
            HStack(spacing: 0) {
                let joined = store.clubs.filter { $0.isJoined }.count
                ForEach([("\(store.savedEvents.count)","Saved"),("\(joined)","Clubs"),("34","Following")], id: \.0) { s in
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
            .padding(.vertical, 14).background(Color(white: 0.08)).cornerRadius(14)

            // Interests
            VStack(alignment: .leading, spacing: 10) {
                Text("INTERESTS").font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.35))
                ProfileFlowLayout(items: store.interests)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20).background(Color(white: 0.07)).cornerRadius(20)
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
                    Text(store.initials).font(.system(size: 30, weight: .bold)).foregroundColor(.white)
                }
            }
        }
        .frame(width: 90, height: 90).clipShape(Circle())
        .overlay(Circle().stroke(Color(white: 0.25), lineWidth: 2))
    }

    // MARK: – Menu card
    var menuCard: some View {
        VStack(spacing: 0) {
            mRow("person.circle", "Edit Profile",       "Name, photo, bio")  { goEdit = true }
            mDiv
            mRow("bell",          "Notifications",      "Manage alerts")      { goNotifications = true }
            mDiv
            mRow("lock.shield",   "Privacy & Security", "Password, 2FA")      { goPrivacy = true }
            mDiv
            mRow("bookmark",      "Saved Events",       "Your bookmarks")     { goSaved = true }
            mDiv
            mRow("info.circle",   "About Us",           "App info & team")    { goAbout = true }
            mDiv
            mRow("star",          "Rate the App",       "Share feedback")     { goReview = true }
            mDiv
            // Logout row
            Button { showLogoutAlert = true } label: {
                HStack(spacing: 14) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.15)).frame(width: 40, height: 40)
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 16)).foregroundColor(.red)
                    }
                    Text("Log Out").font(.system(size: 15, weight: .medium)).foregroundColor(.red)
                    Spacer()
                }
                .padding(.horizontal, 20).padding(.vertical, 14)
            }
        }
        .background(Color(white: 0.07)).cornerRadius(20)
        .padding(.horizontal, 20).padding(.bottom, 110)
    }

    @ViewBuilder
    func mRow(_ icon: String, _ title: String, _ sub: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(Color(white: 0.12)).frame(width: 40, height: 40)
                    Image(systemName: icon).font(.system(size: 16)).foregroundColor(.white)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.system(size: 15, weight: .medium)).foregroundColor(.white)
                    Text(sub).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
                }
                Spacer()
                Image(systemName: "chevron.right").font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.28))
            }
            .padding(.horizontal, 20).padding(.vertical, 14)
        }
    }

    var mDiv: some View { Divider().background(Color(white: 0.1)).padding(.horizontal, 20) }
}

// ─────────────────────────────────────────────
// MARK: - ProfileFlowLayout
// ─────────────────────────────────────────────
struct ProfileFlowLayout: View {
    let items: [String]
    var body: some View {
        var rows: [[String]] = [[]]
        var rowW: CGFloat    = 0
        let maxW: CGFloat    = UIScreen.main.bounds.width - 80
        for item in items {
            let w = CGFloat(item.count * 9 + 28)
            if rowW + w + 8 > maxW, !rows.last!.isEmpty { rows.append([item]); rowW = w + 8 }
            else { rows[rows.count - 1].append(item); rowW += w + 8 }
        }
        return VStack(alignment: .leading, spacing: 8) {
            ForEach(rows.indices, id: \.self) { ri in
                HStack(spacing: 8) {
                    ForEach(rows[ri], id: \.self) { chip in
                        Text(chip).font(.system(size: 12, weight: .medium)).foregroundColor(.white)
                            .padding(.horizontal, 12).padding(.vertical, 6)
                            .background(Color(white: 0.15)).cornerRadius(20)
                    }
                }
            }
        }
    }
}

#Preview {
    struct W: View {
        @State var tab = "profile"
        var body: some View {
            ProfileScreen(selectedTab: $tab)
                .environmentObject(UserProfileStore())
                .environmentObject(AppState())
        }
    }
    return W()
}
