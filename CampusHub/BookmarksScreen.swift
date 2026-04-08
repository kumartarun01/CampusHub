
import SwiftUI

// ─────────────────────────────────────────────
// MARK: - BookmarksScreen
// ─────────────────────────────────────────────
struct BookmarksScreen: View {
    @Binding var selectedTab: String
    @EnvironmentObject var store: UserProfileStore
    @State private var activeTab = "Events"

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {

                // Header
                HStack {
                    Text("Saved")
                        .font(.system(size: 26, weight: .bold)).foregroundColor(.white)
                    Spacer()
                    Text("\(store.savedEvents.count)")
                        .font(.system(size: 13, weight: .semibold)).foregroundColor(Color(white: 0.4))
                }
                .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 16)

                // Tabs
                HStack(spacing: 10) {
                    ForEach(["Events","Clubs"], id: \.self) { t in
                        Button { withAnimation { activeTab = t } } label: {
                            Text(t)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(activeTab == t ? .black : .white)
                                .padding(.horizontal, 20).padding(.vertical, 9)
                                .background(activeTab == t ? Color.white : Color(white: 0.15))
                                .cornerRadius(20)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20).padding(.bottom, 20)

                if activeTab == "Events" { eventsView }
                else { clubsView }
            }
        }
    }

    // MARK: – Saved Events
    @ViewBuilder
    var eventsView: some View {
        if store.savedEvents.isEmpty {
            emptyState(icon: "bookmark.slash", title: "No saved events", sub: "Tap the bookmark icon on any event in the feed to save it here.")
        } else {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(store.savedEvents) { ev in
                        HStack(spacing: 14) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10).fill(Color(white: 0.12)).frame(width: 44, height: 44)
                                Image(systemName: ev.icon).font(.system(size: 18)).foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(ev.title).font(.system(size: 15, weight: .semibold)).foregroundColor(.white)
                                HStack(spacing: 4) {
                                    Image(systemName: "calendar").font(.system(size: 11)).foregroundColor(Color(white: 0.4))
                                    Text(ev.date).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
                                }
                            }
                            Spacer()
                            Text(ev.tag)
                                .font(.system(size: 11, weight: .medium)).foregroundColor(Color(white: 0.55))
                                .padding(.horizontal, 8).padding(.vertical, 4)
                                .background(Color(white: 0.12)).cornerRadius(6)

                            Button {
                                withAnimation { store.savedEvents.removeAll { $0.id == ev.id } }
                            } label: {
                                Image(systemName: "bookmark.fill").font(.system(size: 16)).foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 20).padding(.vertical, 14)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                withAnimation { store.savedEvents.removeAll { $0.id == ev.id } }
                            } label: { Label("Remove", systemImage: "bookmark.slash") }
                        }

                        if ev.id != store.savedEvents.last?.id {
                            Divider().background(Color(white: 0.12)).padding(.horizontal, 20)
                        }
                    }
                }
                .background(Color(white: 0.07)).cornerRadius(20)
                .padding(.horizontal, 20).padding(.bottom, 110)
            }
        }
    }

    // MARK: – Joined Clubs
    @ViewBuilder
    var clubsView: some View {
        let joined = store.clubs.filter { $0.isJoined }
        if joined.isEmpty {
            emptyState(icon: "person.3", title: "No clubs joined", sub: "Join clubs from the Clubs tab to see them here.")
        } else {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(joined) { club in
                        HStack(spacing: 14) {
                            ZStack {
                                Circle().fill(Color(white: 0.15)).frame(width: 46, height: 46)
                                Text(club.initials).font(.system(size: 14, weight: .bold)).foregroundColor(.white)
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text(club.name).font(.system(size: 15, weight: .semibold)).foregroundColor(.white)
                                Text("\(club.category) · \(club.members) members")
                                    .font(.system(size: 12)).foregroundColor(Color(white: 0.45))
                            }
                            Spacer()
                            Text("Joined")
                                .font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.5))
                                .padding(.horizontal, 10).padding(.vertical, 5)
                                .background(Color(white: 0.12)).cornerRadius(8)
                        }
                        .padding(.horizontal, 20).padding(.vertical, 14)

                        if club.id != joined.last?.id {
                            Divider().background(Color(white: 0.12)).padding(.horizontal, 20)
                        }
                    }
                }
                .background(Color(white: 0.07)).cornerRadius(20)
                .padding(.horizontal, 20).padding(.bottom, 110)
            }
        }
    }

    func emptyState(icon: String, title: String, sub: String) -> some View {
        VStack(spacing: 14) {
            Spacer()
            Image(systemName: icon).font(.system(size: 48)).foregroundColor(Color(white: 0.2))
            Text(title).font(.system(size: 17, weight: .semibold)).foregroundColor(Color(white: 0.4))
            Text(sub).font(.system(size: 13)).foregroundColor(Color(white: 0.28))
                .multilineTextAlignment(.center).lineSpacing(4).padding(.horizontal, 40)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    struct W: View {
        @State var tab = "bookmarks"
        var body: some View { BookmarksScreen(selectedTab: $tab).environmentObject(UserProfileStore()) }
    }
    return W()
}
