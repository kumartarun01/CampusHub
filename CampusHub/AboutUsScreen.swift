import SwiftUI

struct AboutUsScreen: View {
    struct TeamMember: Identifiable {
        let id = UUID()
        let initials: String
        let name: String
        let role: String
    }

    struct FeatureItem: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
        let description: String
    }

    let team: [TeamMember] = [
        TeamMember(initials: "K", name: "Kaptan", role: "Founder & iOS Dev"),
        TeamMember(initials: "PR", name: "Priya Rao", role: "UI/UX Designer"),
        TeamMember(initials: "SM", name: "Sahil Mehta", role: "Backend Engineer"),
        TeamMember(initials: "NK", name: "Neha Kapoor", role: "Product Manager")
    ]

    let features: [FeatureItem] = [
        FeatureItem(icon: "calendar.badge.clock", title: "Event Discovery", description: "Find workshops, fests and club activities happening around campus."),
        FeatureItem(icon: "person.3.fill", title: "Club Connect", description: "Join clubs, follow updates and never miss a meeting or event."),
        FeatureItem(icon: "bell.badge.fill", title: "Smart Alerts", description: "Get notified about events that match your interests, instantly."),
        FeatureItem(icon: "bookmark.fill", title: "Save & RSVP", description: "Bookmark events and RSVP with one tap from your feed.")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Header with back
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 24)

                    // App identity block
                    VStack(spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(Color(white: 0.12))
                                .frame(width: 88, height: 88)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 2.5)
                                .frame(width: 40, height: 40)
                        }

                        Text("CampusHub")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)

                        Text("Version 1.0.0")
                            .font(.system(size: 12))
                            .foregroundColor(Color(white: 0.35))

                        Text("Your campus. All in one place.")
                            .font(.system(size: 15))
                            .foregroundColor(Color(white: 0.5))

                        Text("CampusHub was built to solve a simple problem — students missing out on amazing events and opportunities happening right around them. We connect students with clubs, events, workshops, and each other.")
                            .font(.system(size: 14))
                            .foregroundColor(Color(white: 0.45))
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                            .padding(.horizontal, 8)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)

                    // Mission banner
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 10) {
                            Image(systemName: "target")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                            Text("Our Mission")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                        Text("To build the most connected campus community — where every student discovers, participates, and grows.")
                            .font(.system(size: 13))
                            .foregroundColor(Color(white: 0.55))
                            .lineSpacing(4)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(18)
                    .background(Color(white: 0.08))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(white: 0.15), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 28)

                    // Features
                    VStack(alignment: .leading, spacing: 14) {
                        Text("WHAT WE OFFER")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(Color(white: 0.35))
                            .padding(.horizontal, 20)

                        VStack(spacing: 0) {
                            ForEach(features) { feature in
                                HStack(alignment: .top, spacing: 14) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(white: 0.1))
                                            .frame(width: 40, height: 40)
                                        Image(systemName: feature.icon)
                                            .font(.system(size: 16))
                                            .foregroundColor(.white)
                                    }
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(feature.title)
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(.white)
                                        Text(feature.description)
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(white: 0.45))
                                            .lineSpacing(3)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)

                                if feature.id != features.last?.id {
                                    Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
                                }
                            }
                        }
                        .background(Color(white: 0.07))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 28)

                    // Team
                    VStack(alignment: .leading, spacing: 14) {
                        Text("THE TEAM")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(Color(white: 0.35))
                            .padding(.horizontal, 20)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(team) { member in
                                VStack(spacing: 10) {
                                    ZStack {
                                        Circle()
                                            .fill(Color(white: 0.15))
                                            .frame(width: 52, height: 52)
                                        Text(member.initials)
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    VStack(spacing: 3) {
                                        Text(member.name)
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(.white)
                                        Text(member.role)
                                            .font(.system(size: 11))
                                            .foregroundColor(Color(white: 0.4))
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(white: 0.07))
                                .cornerRadius(16)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 28)

                    // Links
                    VStack(spacing: 0) {
                        ForEach(["Privacy Policy", "Terms of Service", "Contact Us", "Follow on Instagram"], id: \.self) { link in
                            Button(action: {}) {
                                HStack {
                                    Text(link)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "arrow.up.right")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color(white: 0.35))
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                            }
                            Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
                        }
                    }
                    .background(Color(white: 0.07))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)

                    Text("Made with ❤️ on campus")
                        .font(.system(size: 13))
                        .foregroundColor(Color(white: 0.3))
                        .padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    AboutUsScreen()
}
