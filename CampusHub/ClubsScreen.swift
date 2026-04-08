
import SwiftUI

// ─────────────────────────────────────────────
// MARK: - ClubsScreen
// ─────────────────────────────────────────────
struct ClubsScreen: View {
    @Binding var selectedTab: String
    @EnvironmentObject var store: UserProfileStore

    @State private var selectedFilter  = "All"
    @State private var selectedClub:   Club?        = nil
    @State private var showAddClub     = false
    @State private var searchText      = ""

    private let filters = ["All", "Tech", "Sports", "Arts"]

    var filteredClubs: [Club] {
        let bySearch = searchText.isEmpty
            ? store.clubs
            : store.clubs.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        if selectedFilter == "All" { return bySearch }
        return bySearch.filter { $0.category == selectedFilter }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {

                // Header
                HStack {
                    Text("Clubs").font(.system(size: 26, weight: .bold)).foregroundColor(.white)
                    Spacer()
                    Button { showAddClub = true } label: {
                        Image(systemName: "plus.circle.fill").font(.system(size: 22)).foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 8)

                // Search
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass").foregroundColor(Color(white: 0.4)).font(.system(size: 14))
                    TextField("", text: $searchText,
                              prompt: Text("Search clubs…").foregroundColor(Color(white: 0.3)))
                        .foregroundColor(.white).font(.system(size: 14))
                    if !searchText.isEmpty {
                        Button { searchText = "" } label: {
                            Image(systemName: "xmark.circle.fill").foregroundColor(Color(white: 0.4))
                        }
                    }
                }
                .padding(.horizontal, 14).padding(.vertical, 11)
                .background(Color(white: 0.1)).cornerRadius(12)
                .padding(.horizontal, 20).padding(.bottom, 14)

                // Filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(filters, id: \.self) { f in
                            Button { selectedFilter = f } label: {
                                Text(f)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(selectedFilter == f ? .black : .white)
                                    .padding(.horizontal, 18).padding(.vertical, 9)
                                    .background(selectedFilter == f ? Color.white : Color(white: 0.15))
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 16)

                // Club list
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(filteredClubs) { club in
                            Button { selectedClub = club } label: {
                                clubRow(club)
                            }
                            Divider().background(Color(white: 0.12)).padding(.horizontal, 20)
                        }

                        if filteredClubs.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "person.3").font(.system(size: 40)).foregroundColor(Color(white: 0.25))
                                Text("No clubs found").font(.system(size: 16)).foregroundColor(Color(white: 0.4))
                            }
                            .frame(maxWidth: .infinity).padding(.top, 60)
                        }
                    }
                    .padding(.bottom, 110)
                }
            }
        }
        // Club Detail Sheet
        .sheet(item: $selectedClub) { club in
            ClubDetailSheet(club: club)
                .environmentObject(store)
        }
        // Add Club Sheet
        .sheet(isPresented: $showAddClub) {
            AddClubSheet()
                .environmentObject(store)
        }
    }

    @ViewBuilder
    func clubRow(_ club: Club) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle().fill(Color(white: 0.15)).frame(width: 50, height: 50)
                Text(club.initials).font(.system(size: 16, weight: .bold)).foregroundColor(.white)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(club.name).font(.system(size: 15, weight: .semibold)).foregroundColor(.white)
                HStack(spacing: 6) {
                    Text(club.category).font(.system(size: 11)).foregroundColor(Color(white: 0.45))
                    Text("·").foregroundColor(Color(white: 0.3))
                    Text("\(club.members) members").font(.system(size: 11)).foregroundColor(Color(white: 0.45))
                }
            }

            Spacer()

            // Join/Joined badge
            Text(club.isJoined ? "Joined" : "Join")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(club.isJoined ? Color(white: 0.5) : .black)
                .padding(.horizontal, 12).padding(.vertical, 6)
                .background(club.isJoined ? Color(white: 0.15) : Color.white)
                .cornerRadius(8)

            Image(systemName: "chevron.right").font(.system(size: 13)).foregroundColor(Color(white: 0.3))
        }
        .padding(.horizontal, 20).padding(.vertical, 14)
    }
}

// ─────────────────────────────────────────────
// MARK: - ClubDetailSheet
// ─────────────────────────────────────────────
struct ClubDetailSheet: View {
    let club: Club
    @EnvironmentObject var store: UserProfileStore
    @Environment(\.dismiss) var dismiss
    @State private var showRemoveAlert = false

    var currentClub: Club? { store.clubs.first(where: { $0.id == club.id }) }
    var isJoined: Bool { currentClub?.isJoined ?? false }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // Header
                    HStack {
                        Button { dismiss() } label: {
                            Image(systemName: "xmark").font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                        }
                        Spacer()
                        Text("Club Details").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        Color.clear.frame(width: 28)
                    }
                    .padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 24)

                    // Avatar + name
                    VStack(spacing: 14) {
                        ZStack {
                            Circle().fill(Color(white: 0.18)).frame(width: 80, height: 80)
                            Text(club.initials).font(.system(size: 26, weight: .bold)).foregroundColor(.white)
                        }
                        Text(club.name).font(.system(size: 22, weight: .bold)).foregroundColor(.white)
                        HStack(spacing: 10) {
                            Label(club.category, systemImage: "tag")
                                .font(.system(size: 12)).foregroundColor(Color(white: 0.5))
                            Text("·").foregroundColor(Color(white: 0.3))
                            Label("\(club.members) members", systemImage: "person.2")
                                .font(.system(size: 12)).foregroundColor(Color(white: 0.5))
                        }
                    }
                    .padding(.bottom, 24)

                    // Description
                    VStack(alignment: .leading, spacing: 10) {
                        Text("ABOUT").font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.35))
                        Text(club.description)
                            .font(.system(size: 14)).foregroundColor(Color(white: 0.6)).lineSpacing(4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(18).background(Color(white: 0.07)).cornerRadius(16)
                    .padding(.horizontal, 20).padding(.bottom, 16)

                    // Upcoming events
                    VStack(alignment: .leading, spacing: 12) {
                        Text("UPCOMING EVENTS").font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.35))
                        ForEach(club.events, id: \.self) { ev in
                            HStack(spacing: 12) {
                                Circle().fill(Color(white: 0.25)).frame(width: 8, height: 8)
                                Text(ev).font(.system(size: 14)).foregroundColor(.white)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(18).background(Color(white: 0.07)).cornerRadius(16)
                    .padding(.horizontal, 20).padding(.bottom, 24)

                    // Join / Leave button
                    if isJoined {
                        Button { showRemoveAlert = true } label: {
                            Text("Leave Club")
                                .font(.system(size: 16, weight: .semibold)).foregroundColor(.red)
                                .frame(maxWidth: .infinity).frame(height: 52)
                                .background(Color.red.opacity(0.12)).cornerRadius(13)
                        }
                        .padding(.horizontal, 20)
                    } else {
                        Button {
                            if let idx = store.clubs.firstIndex(where: { $0.id == club.id }) {
                                store.clubs[idx].isJoined = true
                                store.clubs[idx].members += 1
                            }
                            dismiss()
                        } label: {
                            Text("Join Club")
                                .font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                                .frame(maxWidth: .infinity).frame(height: 52)
                                .background(Color.white).cornerRadius(13)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .alert("Leave \(club.name)?", isPresented: $showRemoveAlert) {
            Button("Leave", role: .destructive) {
                if let idx = store.clubs.firstIndex(where: { $0.id == club.id }) {
                    store.clubs[idx].isJoined = false
                    store.clubs[idx].members = max(0, store.clubs[idx].members - 1)
                }
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: { Text("You will stop receiving updates from this club.") }
    }
}

// ─────────────────────────────────────────────
// MARK: - AddClubSheet
// ─────────────────────────────────────────────
struct AddClubSheet: View {
    @EnvironmentObject var store: UserProfileStore
    @Environment(\.dismiss) var dismiss

    @State private var name        = ""
    @State private var description = ""
    @State private var category    = "Tech"
    @State private var showError   = false

    private let categories = ["Tech","Sports","Arts","Science","Culture","Other"]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // Header
                    HStack {
                        Button { dismiss() } label: {
                            Text("Cancel").font(.system(size: 15)).foregroundColor(Color(white: 0.55))
                        }
                        Spacer()
                        Text("New Club").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        Button(action: createClub) {
                            Text("Create").font(.system(size: 15, weight: .semibold)).foregroundColor(.black)
                                .padding(.horizontal, 14).padding(.vertical, 7)
                                .background(name.isEmpty ? Color(white: 0.3) : Color.white)
                                .cornerRadius(10)
                        }
                        .disabled(name.isEmpty)
                    }
                    .padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 28)

                    VStack(spacing: 18) {
                        // Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Club Name").font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.5))
                            HStack(spacing: 12) {
                                Image(systemName: "person.3").foregroundColor(Color(white: 0.4)).font(.system(size: 15))
                                TextField("", text: $name, prompt: Text("e.g. Drama Club").foregroundColor(Color(white: 0.3)))
                                    .foregroundColor(.white).font(.system(size: 14))
                            }
                            .padding(.horizontal, 16).padding(.vertical, 14)
                            .background(Color(white: 0.1)).cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
                        }

                        // Category
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Category").font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.5))
                            Menu {
                                ForEach(categories, id: \.self) { c in Button(c) { category = c } }
                            } label: {
                                HStack(spacing: 12) {
                                    Image(systemName: "tag").foregroundColor(Color(white: 0.4)).font(.system(size: 15))
                                    Text(category).foregroundColor(.white).font(.system(size: 14))
                                    Spacer()
                                    Image(systemName: "chevron.up.chevron.down").font(.system(size: 12)).foregroundColor(Color(white: 0.35))
                                }
                                .padding(.horizontal, 16).padding(.vertical, 14)
                                .background(Color(white: 0.1)).cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
                            }
                        }

                        // Description
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description").font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.5))
                            ZStack(alignment: .topLeading) {
                                if description.isEmpty {
                                    Text("What is this club about?")
                                        .font(.system(size: 14)).foregroundColor(Color(white: 0.3))
                                        .padding(.horizontal, 16).padding(.top, 14)
                                }
                                TextEditor(text: $description)
                                    .foregroundColor(.white).font(.system(size: 14))
                                    .scrollContentBackground(.hidden).background(Color.clear)
                                    .padding(10).frame(minHeight: 100)
                            }
                            .background(Color(white: 0.1)).cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
                        }

                        if showError {
                            Text("Please enter a club name.")
                                .font(.system(size: 13)).foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(20).background(Color(white: 0.07)).cornerRadius(20)
                    .padding(.horizontal, 20).padding(.bottom, 30)

                    Button(action: createClub) {
                        Text("Create Club")
                            .font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                            .frame(maxWidth: .infinity).frame(height: 52)
                            .background(name.isEmpty ? Color(white: 0.25) : Color.white)
                            .cornerRadius(13)
                    }
                    .disabled(name.isEmpty)
                    .padding(.horizontal, 20).padding(.bottom, 40)
                }
            }
        }
    }

    func createClub() {
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { showError = true; return }
        let initials = String(trimmed.split(separator: " ").compactMap { $0.first }.prefix(2)).uppercased()
        let newClub = Club(
            initials: initials.isEmpty ? "CL" : initials,
            name: trimmed,
            description: description.isEmpty ? "A new campus club." : description,
            members: 1,
            category: category,
            isJoined: true,
            events: []
        )
        store.clubs.append(newClub)
        dismiss()
    }
}

#Preview {
    struct W: View {
        @State var tab = "clubs"
        var body: some View { ClubsScreen(selectedTab: $tab).environmentObject(UserProfileStore()) }
    }
    return W()
}
