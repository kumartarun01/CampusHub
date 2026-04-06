//import SwiftUI
//
//struct NotificationsScreen: View {
//    @State private var selectedFilter = "All"
//    let filters = ["All", "Events", "Clubs"]
//
//    struct NotifItem: Identifiable {
//        let id = UUID()
//        let initials: String
//        let name: String
//        let subtitle: String
//        let time: String
//        let tag: String?
//    }
//
//    let notifications: [NotifItem] = [
//        NotifItem(initials: "CS", name: "CS & AI Club", subtitle: "Filth'n emoped · 2\nwtt·indgge roanting", time: "", tag: "Workshop"),
//        NotifItem(initials: "SP", name: "Sports Council", subtitle: "Saored · Soentnst", time: "Jgn Flies · 2025", tag: nil),
//        NotifItem(initials: "MU", name: "Music Club", subtitle: "Jgn Flies · 2025", time: "", tag: nil),
//        NotifItem(initials: "EK", name: "Erjun Kumar", subtitle: "Jgpr o 3dillisgate · tech", time: "", tag: nil)
//    ]
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//
//            VStack(spacing: 0) {
//                // Header
//                HStack {
//                    Text("Notifications")
//                        .font(.system(size: 26, weight: .bold))
//                        .foregroundColor(.white)
//                    Spacer()
//                    ZStack(alignment: .topTrailing) {
//                        Image(systemName: "bell.fill")
//                            .foregroundColor(.white)
//                            .font(.system(size: 20))
//                        Circle()
//                            .fill(Color.red)
//                            .frame(width: 8, height: 8)
//                            .offset(x: 2, y: -2)
//                    }
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 16)
//                .padding(.bottom, 16)
//
//                // Filter chips
//                HStack(spacing: 10) {
//                    ForEach(filters, id: \.self) { filter in
//                        Button(action: { selectedFilter = filter }) {
//                            Text(filter)
//                                .font(.system(size: 14, weight: .medium))
//                                .foregroundColor(selectedFilter == filter ? .black : .white)
//                                .padding(.horizontal, 18)
//                                .padding(.vertical, 9)
//                                .background(selectedFilter == filter ? Color.white : Color(white: 0.15))
//                                .cornerRadius(20)
//                        }
//                    }
//                    Spacer()
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 20)
//
//                // Notifications list
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 0) {
//                        ForEach(notifications) { item in
//                            HStack(alignment: .top, spacing: 14) {
//                                // Avatar
//                                ZStack {
//                                    Circle()
//                                        .fill(Color(white: 0.15))
//                                        .frame(width: 48, height: 48)
//                                    Text(item.initials)
//                                        .font(.system(size: 15, weight: .bold))
//                                        .foregroundColor(.white)
//                                }
//
//                                VStack(alignment: .leading, spacing: 4) {
//                                    HStack {
//                                        Text(item.name)
//                                            .font(.system(size: 15, weight: .semibold))
//                                            .foregroundColor(.white)
//                                        Spacer()
//                                        if let tag = item.tag {
//                                            Text(tag)
//                                                .font(.system(size: 11, weight: .medium))
//                                                .foregroundColor(Color(white: 0.6))
//                                                .padding(.horizontal, 10)
//                                                .padding(.vertical, 4)
//                                                .background(Color(white: 0.12))
//                                                .cornerRadius(6)
//                                        }
//                                    }
//                                    Text(item.subtitle)
//                                        .font(.system(size: 12))
//                                        .foregroundColor(Color(white: 0.45))
//                                        .lineSpacing(2)
//
//                                    if !item.time.isEmpty {
//                                        Text(item.time)
//                                            .font(.system(size: 11))
//                                            .foregroundColor(Color(white: 0.35))
//                                    }
//                                }
//                            }
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 14)
//
//                            Divider()
//                                .background(Color(white: 0.12))
//                                .padding(.horizontal, 20)
//                        }
//                    }
//                    .padding(.bottom, 100)
//                }
//            }
//
//            // Bottom Tab Bar
//            VStack {
//                Spacer()
//                BottomTabBar(selected: "notifications")
//            }
//        }
//    }
//}
//
//#Preview {
//    NotificationsScreen()
//}
