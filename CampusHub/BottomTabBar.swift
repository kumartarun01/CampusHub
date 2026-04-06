//import SwiftUI
//
//struct BottomTabBar: View {
//    let selected: String
//
//    struct TabItem {
//        let id: String
//        let icon: String
//        let label: String
//    }
//
//    let tabs: [TabItem] = [
//        TabItem(id: "home", icon: "house.fill", label: "Home"),
//        TabItem(id: "clubs", icon: "building.columns.fill", label: "Clubs"),
//        TabItem(id: "calendar", icon: "calendar", label: "Calendar"),
//        TabItem(id: "bookmarks", icon: "bookmark.fill", label: "Bookmarks"),
//        TabItem(id: "profile", icon: "person.fill", label: "Profile")
//    ]
//
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(tabs, id: \.id) { tab in
//                Button(action: {}) {
//                    VStack(spacing: 4) {
//                        Image(systemName: tab.icon)
//                            .font(.system(size: 20))
//                            .foregroundColor(selected == tab.id ? .white : Color(white: 0.4))
//                        Text(tab.label)
//                            .font(.system(size: 10, weight: .medium))
//                            .foregroundColor(selected == tab.id ? .white : Color(white: 0.4))
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//            }
//        }
//        .padding(.top, 12)
//        .padding(.bottom, 28)
//        .background(
//            Color(white: 0.06)
//                .ignoresSafeArea(edges: .bottom)
//                .overlay(
//                    Rectangle()
//                        .fill(Color(white: 0.15))
//                        .frame(height: 0.5),
//                    alignment: .top
//                )
//        )
//    }
//}
//
//#Preview {
//    ZStack {
//        Color.black.ignoresSafeArea()
//        VStack {
//            Spacer()
//            BottomTabBar(selected: "home")
//        }
//    }
//}
//
//


import SwiftUI

// ─────────────────────────────────────────────
// MARK: - BottomTabBar
// ─────────────────────────────────────────────
struct BottomTabBar: View {
    @Binding var selectedTab: String

    private struct Tab {
        let id: String
        let icon: String
        let activeIcon: String
        let label: String
    }

    private let tabs: [Tab] = [
        Tab(id: "home",      icon: "house",            activeIcon: "house.fill",            label: "Home"),
        Tab(id: "clubs",     icon: "building.columns", activeIcon: "building.columns.fill",  label: "Clubs"),
        Tab(id: "calendar",  icon: "calendar",         activeIcon: "calendar",               label: "Calendar"),
        Tab(id: "bookmarks", icon: "bookmark",         activeIcon: "bookmark.fill",          label: "Saved"),
        Tab(id: "profile",   icon: "person",           activeIcon: "person.fill",            label: "Profile")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.id) { tab in
                let active = selectedTab == tab.id
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) { selectedTab = tab.id }
                } label: {
                    VStack(spacing: 5) {
                        ZStack {
                            if active {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(white: 0.18))
                                    .frame(width: 44, height: 28)
                                    .transition(.scale.combined(with: .opacity))
                            }
                            Image(systemName: active ? tab.activeIcon : tab.icon)
                                .font(.system(size: active ? 19 : 18,
                                              weight: active ? .semibold : .regular))
                                .foregroundColor(active ? .white : Color(white: 0.38))
                                .scaleEffect(active ? 1.05 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: active)
                        }
                        .frame(height: 30)

                        Text(tab.label)
                            .font(.system(size: 10, weight: active ? .semibold : .regular))
                            .foregroundColor(active ? .white : Color(white: 0.38))
                    }
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 28)
        .background(
            Color(white: 0.06)
                .ignoresSafeArea(edges: .bottom)
                .overlay(
                    Rectangle()
                        .fill(Color(white: 0.14))
                        .frame(height: 0.5),
                    alignment: .top
                )
        )
    }
}

#Preview {
    struct Wrap: View {
        @State var tab = "home"
        var body: some View {
            ZStack(alignment: .bottom) {
                Color.black.ignoresSafeArea()
                BottomTabBar(selectedTab: $tab)
            }
        }
    }
    return Wrap()
}
