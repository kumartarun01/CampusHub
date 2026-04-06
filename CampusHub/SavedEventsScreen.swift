//
//  SavedEventsScreen.swift
//  CampusHub
//
//  Created by iMac1 on 06/04/26.
//

import SwiftUI

// ─────────────────────────────────────────────
// MARK: - SavedEventsScreen
// ─────────────────────────────────────────────
struct SavedEventsScreen: View {
    @EnvironmentObject var store: UserProfileStore
    @Environment(\.dismiss) var dismiss
    @State private var activeTab = "Bookmarks"

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {
                navBar

                // Tabs
                HStack(spacing: 10) {
                    ForEach(["Bookmarks","Clubs"], id: \.self) { t in
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) { activeTab = t }
                        } label: {
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

                if activeTab == "Bookmarks" { bookmarksList }
                else { clubsEmpty }
            }
        }
        .navigationBarHidden(true)
    }

    var navBar: some View {
        HStack {
            Button { dismiss() } label: {
                HStack(spacing: 5) {
                    Image(systemName: "chevron.left").font(.system(size: 15, weight: .semibold))
                    Text("Back")
                }.foregroundColor(Color(white: 0.55))
            }
            Spacer()
            Text("Saved Events").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
            Spacer()
            Text("\(store.savedEvents.count)")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(Color(white: 0.4)).frame(width: 50, alignment: .trailing)
        }
        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 16)
    }

    @ViewBuilder
    var bookmarksList: some View {
        if store.savedEvents.isEmpty {
            emptyState
        } else {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(store.savedEvents) { ev in
                        eventRow(ev)
                        if ev.id != store.savedEvents.last?.id {
                            Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
                        }
                    }
                }
                .background(Color(white: 0.07)).cornerRadius(20)
                .padding(.horizontal, 20).padding(.bottom, 40)
            }
        }
    }

    @ViewBuilder
    func eventRow(_ ev: SavedEvent) -> some View {
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
    }

    var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "bookmark.slash").font(.system(size: 48)).foregroundColor(Color(white: 0.2))
            Text("No saved events").font(.system(size: 17, weight: .semibold)).foregroundColor(Color(white: 0.4))
            Text("Bookmark events from the feed\nand they'll appear here.")
                .font(.system(size: 14)).foregroundColor(Color(white: 0.28))
                .multilineTextAlignment(.center).lineSpacing(4)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    var clubsEmpty: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "person.3").font(.system(size: 48)).foregroundColor(Color(white: 0.2))
            Text("No saved clubs").font(.system(size: 17, weight: .semibold)).foregroundColor(Color(white: 0.4))
            Text("Follow clubs to see them here.").font(.system(size: 14)).foregroundColor(Color(white: 0.28))
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack { SavedEventsScreen().environmentObject(UserProfileStore()) }
}
