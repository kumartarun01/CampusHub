import SwiftUI

struct HomeScreen: View {
    @State private var searchText = ""

    struct ClubRow: Identifiable {
        let id = UUID()
        let initials: String
        let name: String
        let subtitle: String
        let time: String
    }

    let clubRows: [ClubRow] = [
        ClubRow(initials: "CS", name: "CS & AI Club", subtitle: "Filth the eooney. tech", time: ""),
        ClubRow(initials: "SP", name: "Sports Council", subtitle: "Sconed · Saentted", time: ""),
        ClubRow(initials: "MU", name: "Music Club", subtitle: "Agr Flies · 1smd", time: ""),
        ClubRow(initials: "EK", name: "Erjun Kumar", subtitle: "Jgrom 0dliqagse · rco", time: "")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Home")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                        Text("Sopentatoats, woitthe pnemesager")
                            .font(.system(size: 12))
                            .foregroundColor(Color(white: 0.4))
                    }
                    Spacer()
                    // Profile avatar
                    Circle()
                        .fill(Color(white: 0.25))
                        .frame(width: 38, height: 38)
                        .overlay(
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 14)

                // Search bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(white: 0.4))
                        .font(.system(size: 15))
                    TextField("", text: $searchText, prompt: Text("Search events, Clubs.")
                        .foregroundColor(Color(white: 0.35)))
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color(white: 0.1))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                // Clubs/People list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(clubRows) { row in
                            HStack(spacing: 14) {
                                // Avatar
                                ZStack {
                                    Circle()
                                        .fill(Color(white: 0.15))
                                        .frame(width: 46, height: 46)
                                    Text(row.initials)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                }

                                VStack(alignment: .leading, spacing: 3) {
                                    Text(row.name)
                                        .font(.system(size: 15, weight: .semibold))
                                        .foregroundColor(.white)
                                    Text(row.subtitle)
                                        .font(.system(size: 12))
                                        .foregroundColor(Color(white: 0.45))
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(white: 0.3))
                                    .font(.system(size: 13))
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
                BottomTabBar(selected: "home")
            }
        }
    }
}

#Preview {
    HomeScreen()
}
