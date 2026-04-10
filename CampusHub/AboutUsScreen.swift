////import SwiftUI
////
////struct AboutUsScreen: View {
////    struct TeamMember: Identifiable {
////        let id = UUID()
////        let initials: String
////        let name: String
////        let role: String
////    }
////
////    struct FeatureItem: Identifiable {
////        let id = UUID()
////        let icon: String
////        let title: String
////        let description: String
////    }
////
////    let team: [TeamMember] = [
////        TeamMember(initials: "K", name: "Kaptan", role: "Founder & iOS Dev"),
////        TeamMember(initials: "PR", name: "Priya Rao", role: "UI/UX Designer"),
////        TeamMember(initials: "SM", name: "Sahil Mehta", role: "Backend Engineer"),
////        TeamMember(initials: "NK", name: "Neha Kapoor", role: "Product Manager")
////    ]
////
////    let features: [FeatureItem] = [
////        FeatureItem(icon: "calendar.badge.clock", title: "Event Discovery", description: "Find workshops, fests and club activities happening around campus."),
////        FeatureItem(icon: "person.3.fill", title: "Club Connect", description: "Join clubs, follow updates and never miss a meeting or event."),
////        FeatureItem(icon: "bell.badge.fill", title: "Smart Alerts", description: "Get notified about events that match your interests, instantly."),
////        FeatureItem(icon: "bookmark.fill", title: "Save & RSVP", description: "Bookmark events and RSVP with one tap from your feed.")
////    ]
////
////    var body: some View {
////        ZStack {
////            Color.black.ignoresSafeArea()
////
////            ScrollView(showsIndicators: false) {
////                VStack(spacing: 0) {
////                    // Header with back
////                    HStack {
////                        Button(action: {}) {
////                            Image(systemName: "chevron.left")
////                                .font(.system(size: 16, weight: .semibold))
////                                .foregroundColor(.white)
////                        }
////                        Spacer()
////                    }
////                    .padding(.horizontal, 20)
////                    .padding(.top, 16)
////                    .padding(.bottom, 24)
////
////                    // App identity block
////                    VStack(spacing: 16) {
////                        ZStack {
////                            RoundedRectangle(cornerRadius: 24)
////                                .fill(Color(white: 0.12))
////                                .frame(width: 88, height: 88)
////                            RoundedRectangle(cornerRadius: 10)
////                                .stroke(Color.white, lineWidth: 2.5)
////                                .frame(width: 40, height: 40)
////                        }
////
////                        Text("CampusHub")
////                            .font(.system(size: 28, weight: .bold))
////                            .foregroundColor(.white)
////
////                        Text("Version 1.0.0")
////                            .font(.system(size: 12))
////                            .foregroundColor(Color(white: 0.35))
////
////                        Text("Your campus. All in one place.")
////                            .font(.system(size: 15))
////                            .foregroundColor(Color(white: 0.5))
////
////                        Text("CampusHub was built to solve a simple problem — students missing out on amazing events and opportunities happening right around them. We connect students with clubs, events, workshops, and each other.")
////                            .font(.system(size: 14))
////                            .foregroundColor(Color(white: 0.45))
////                            .multilineTextAlignment(.center)
////                            .lineSpacing(5)
////                            .padding(.horizontal, 8)
////                    }
////                    .padding(.horizontal, 24)
////                    .padding(.bottom, 32)
////
////                    // Mission banner
////                    VStack(alignment: .leading, spacing: 10) {
////                        HStack(spacing: 10) {
////                            Image(systemName: "target")
////                                .font(.system(size: 18))
////                                .foregroundColor(.white)
////                            Text("Our Mission")
////                                .font(.system(size: 16, weight: .bold))
////                                .foregroundColor(.white)
////                        }
////                        Text("To build the most connected campus community — where every student discovers, participates, and grows.")
////                            .font(.system(size: 13))
////                            .foregroundColor(Color(white: 0.55))
////                            .lineSpacing(4)
////                    }
////                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .padding(18)
////                    .background(Color(white: 0.08))
////                    .cornerRadius(16)
////                    .overlay(
////                        RoundedRectangle(cornerRadius: 16)
////                            .stroke(Color(white: 0.15), lineWidth: 1)
////                    )
////                    .padding(.horizontal, 20)
////                    .padding(.bottom, 28)
////
////                    // Features
////                    VStack(alignment: .leading, spacing: 14) {
////                        Text("WHAT WE OFFER")
////                            .font(.system(size: 11, weight: .semibold))
////                            .foregroundColor(Color(white: 0.35))
////                            .padding(.horizontal, 20)
////
////                        VStack(spacing: 0) {
////                            ForEach(features) { feature in
////                                HStack(alignment: .top, spacing: 14) {
////                                    ZStack {
////                                        RoundedRectangle(cornerRadius: 10)
////                                            .fill(Color(white: 0.1))
////                                            .frame(width: 40, height: 40)
////                                        Image(systemName: feature.icon)
////                                            .font(.system(size: 16))
////                                            .foregroundColor(.white)
////                                    }
////                                    VStack(alignment: .leading, spacing: 4) {
////                                        Text(feature.title)
////                                            .font(.system(size: 14, weight: .semibold))
////                                            .foregroundColor(.white)
////                                        Text(feature.description)
////                                            .font(.system(size: 12))
////                                            .foregroundColor(Color(white: 0.45))
////                                            .lineSpacing(3)
////                                    }
////                                    Spacer()
////                                }
////                                .padding(.horizontal, 20)
////                                .padding(.vertical, 14)
////
////                                if feature.id != features.last?.id {
////                                    Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
////                                }
////                            }
////                        }
////                        .background(Color(white: 0.07))
////                        .cornerRadius(20)
////                        .padding(.horizontal, 20)
////                    }
////                    .padding(.bottom, 28)
////
////                    // Team
////                    VStack(alignment: .leading, spacing: 14) {
////                        Text("THE TEAM")
////                            .font(.system(size: 11, weight: .semibold))
////                            .foregroundColor(Color(white: 0.35))
////                            .padding(.horizontal, 20)
////
////                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
////                            ForEach(team) { member in
////                                VStack(spacing: 10) {
////                                    ZStack {
////                                        Circle()
////                                            .fill(Color(white: 0.15))
////                                            .frame(width: 52, height: 52)
////                                        Text(member.initials)
////                                            .font(.system(size: 16, weight: .bold))
////                                            .foregroundColor(.white)
////                                    }
////                                    VStack(spacing: 3) {
////                                        Text(member.name)
////                                            .font(.system(size: 13, weight: .semibold))
////                                            .foregroundColor(.white)
////                                        Text(member.role)
////                                            .font(.system(size: 11))
////                                            .foregroundColor(Color(white: 0.4))
////                                            .multilineTextAlignment(.center)
////                                    }
////                                }
////                                .frame(maxWidth: .infinity)
////                                .padding(.vertical, 16)
////                                .background(Color(white: 0.07))
////                                .cornerRadius(16)
////                            }
////                        }
////                        .padding(.horizontal, 20)
////                    }
////                    .padding(.bottom, 28)
////
////                    // Links
////                    VStack(spacing: 0) {
////                        ForEach(["Privacy Policy", "Terms of Service", "Contact Us", "Follow on Instagram"], id: \.self) { link in
////                            Button(action: {}) {
////                                HStack {
////                                    Text(link)
////                                        .font(.system(size: 14, weight: .medium))
////                                        .foregroundColor(.white)
////                                    Spacer()
////                                    Image(systemName: "arrow.up.right")
////                                        .font(.system(size: 12))
////                                        .foregroundColor(Color(white: 0.35))
////                                }
////                                .padding(.horizontal, 20)
////                                .padding(.vertical, 15)
////                            }
////                            Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
////                        }
////                    }
////                    .background(Color(white: 0.07))
////                    .cornerRadius(20)
////                    .padding(.horizontal, 20)
////                    .padding(.bottom, 24)
////
////                    Text("Made with ❤️ on campus")
////                        .font(.system(size: 13))
////                        .foregroundColor(Color(white: 0.3))
////                        .padding(.bottom, 40)
////                }
////            }
////        }
////    }
////}
////
////#Preview {
////    AboutUsScreen()
////}
//
//
//import SwiftUI
//
//// ─────────────────────────────────────────────
//// MARK: - AboutUsScreen
//// ─────────────────────────────────────────────
//struct AboutUsScreen: View {
//    @Environment(\.dismiss) var dismiss
//
//    private struct Member: Identifiable {
//        let id = UUID(); let initials, name, role: String
//    }
//    private struct Feature: Identifiable {
//        let id = UUID(); let icon, title, desc: String
//    }
//
//    private let team: [Member] = [
//        Member(initials: "AK", name: "Arjun Kumar", role: "Founder & iOS Dev"),
//        Member(initials: "PR", name: "Priya Rao",   role: "UI/UX Designer"),
//        Member(initials: "SM", name: "Sahil Mehta", role: "Backend Engineer"),
//        Member(initials: "NK", name: "Neha Kapoor", role: "Product Manager")
//    ]
//    private let features: [Feature] = [
//        Feature(icon: "calendar.badge.clock", title: "Event Discovery",
//                desc: "Find workshops, fests and club activities happening around campus."),
//        Feature(icon: "person.3.fill",        title: "Club Connect",
//                desc: "Join clubs, follow updates and never miss a meeting."),
//        Feature(icon: "bell.badge.fill",      title: "Smart Alerts",
//                desc: "Instant notifications that match your interests."),
//        Feature(icon: "bookmark.fill",        title: "Save & RSVP",
//                desc: "Bookmark and RSVP with one tap from your feed.")
//    ]
//    private let links = ["Privacy Policy","Terms of Service","Contact Us","Follow on Instagram"]
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 0) {
//                    navBar
//                    appIdentity
//                    missionBlock
//                    featuresSection
//                    teamSection
//                    linksSection
//                    footer
//                }
//            }
//        }
//        .navigationBarHidden(true)
//    }
//
//    var navBar: some View {
//        HStack {
//            Button { dismiss() } label: {
//                HStack(spacing: 5) {
//                    Image(systemName: "chevron.left").font(.system(size: 15, weight: .semibold))
//                    Text("Back")
//                }.foregroundColor(Color(white: 0.55))
//            }
//            Spacer()
//            Text("About Us").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
//            Spacer()
//            Color.clear.frame(width: 60)
//        }
//        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 24)
//    }
//
//    var appIdentity: some View {
//        VStack(spacing: 14) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 24).fill(Color(white: 0.12)).frame(width: 88, height: 88)
//                RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2.5).frame(width: 40, height: 40)
//            }
//            Text("CampusHub").font(.system(size: 28, weight: .bold)).foregroundColor(.white)
//            Text("Version 1.0.0").font(.system(size: 12)).foregroundColor(Color(white: 0.32))
//            Text("Your campus. All in one place.")
//                .font(.system(size: 15)).foregroundColor(Color(white: 0.5))
//            Text("CampusHub was built to solve a simple problem — students missing out on amazing events happening right around them. We connect students with clubs, events, workshops and each other.")
//                .font(.system(size: 14)).foregroundColor(Color(white: 0.45))
//                .multilineTextAlignment(.center).lineSpacing(5).padding(.horizontal, 8)
//        }
//        .padding(.horizontal, 24).padding(.bottom, 28)
//    }
//
//    var missionBlock: some View {
//        HStack(alignment: .top, spacing: 12) {
//            Image(systemName: "target").font(.system(size: 18)).foregroundColor(.white)
//            VStack(alignment: .leading, spacing: 6) {
//                Text("Our Mission").font(.system(size: 16, weight: .bold)).foregroundColor(.white)
//                Text("To build the most connected campus community — where every student discovers, participates, and grows.")
//                    .font(.system(size: 13)).foregroundColor(Color(white: 0.55)).lineSpacing(4)
//            }
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(18)
//        .background(Color(white: 0.08)).cornerRadius(16)
//        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(white: 0.14), lineWidth: 1))
//        .padding(.horizontal, 20).padding(.bottom, 24)
//    }
//
//    var featuresSection: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            sectionLabel("WHAT WE OFFER")
//            VStack(spacing: 0) {
//                ForEach(features) { f in
//                    HStack(alignment: .top, spacing: 14) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10).fill(Color(white: 0.1)).frame(width: 40, height: 40)
//                            Image(systemName: f.icon).font(.system(size: 16)).foregroundColor(.white)
//                        }
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text(f.title).font(.system(size: 14, weight: .semibold)).foregroundColor(.white)
//                            Text(f.desc).font(.system(size: 12)).foregroundColor(Color(white: 0.45)).lineSpacing(3)
//                        }
//                        Spacer()
//                    }
//                    .padding(.horizontal, 20).padding(.vertical, 14)
//                    if f.id != features.last?.id {
//                        Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
//                    }
//                }
//            }
//            .background(Color(white: 0.07)).cornerRadius(20)
//            .padding(.horizontal, 20).padding(.bottom, 24)
//        }
//    }
//
//    var teamSection: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            sectionLabel("THE TEAM")
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
//                ForEach(team) { m in
//                    VStack(spacing: 10) {
//                        ZStack {
//                            Circle().fill(Color(white: 0.15)).frame(width: 52, height: 52)
//                            Text(m.initials).font(.system(size: 16, weight: .bold)).foregroundColor(.white)
//                        }
//                        VStack(spacing: 3) {
//                            Text(m.name).font(.system(size: 13, weight: .semibold)).foregroundColor(.white)
//                            Text(m.role).font(.system(size: 11)).foregroundColor(Color(white: 0.4))
//                                .multilineTextAlignment(.center)
//                        }
//                    }
//                    .frame(maxWidth: .infinity).padding(.vertical, 16)
//                    .background(Color(white: 0.07)).cornerRadius(16)
//                }
//            }
//            .padding(.horizontal, 20).padding(.bottom, 24)
//        }
//    }
//
//    var linksSection: some View {
//        VStack(spacing: 0) {
//            ForEach(links, id: \.self) { link in
//                Button {} label: {
//                    HStack {
//                        Text(link).font(.system(size: 14, weight: .medium)).foregroundColor(.white)
//                        Spacer()
//                        Image(systemName: "arrow.up.right").font(.system(size: 12)).foregroundColor(Color(white: 0.35))
//                    }
//                    .padding(.horizontal, 20).padding(.vertical, 15)
//                }
//                Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
//            }
//        }
//        .background(Color(white: 0.07)).cornerRadius(20)
//        .padding(.horizontal, 20).padding(.bottom, 20)
//    }
//
//    var footer: some View {
//        Text("Made with ❤️ on campus")
//            .font(.system(size: 13)).foregroundColor(Color(white: 0.28))
//            .padding(.bottom, 40)
//    }
//
//    func sectionLabel(_ t: String) -> some View {
//        Text(t).font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.35))
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.horizontal, 24).padding(.bottom, 10)
//    }
//}
//
//#Preview {
//    NavigationStack { AboutUsScreen() }
//}


import SwiftUI

// ─────────────────────────────────────────────
// MARK: - AboutUsScreen
// ─────────────────────────────────────────────
struct AboutUsScreen: View {
    @Environment(\.dismiss) var dismiss

    @State private var activeSheet: AboutSheet? = nil

    enum AboutSheet: String, Identifiable {
        case privacy   = "Privacy Policy"
        case terms     = "Terms of Service"
        case contact   = "Contact Us"
        case follow    = "Follow on Instagram"
        var id: String { rawValue }
    }

    private struct Member: Identifiable {
        let id = UUID(); let initials, name, role: String
    }
    private struct Feature: Identifiable {
        let id = UUID(); let icon, title, desc: String
    }

    private let team: [Member] = [
        Member(initials:"AK", name:"Arjun Kumar",  role:"Founder & iOS Dev"),
        Member(initials:"PR", name:"Priya Rao",    role:"UI/UX Designer"),
        Member(initials:"SM", name:"Sahil Mehta",  role:"Backend Engineer"),
        Member(initials:"NK", name:"Neha Kapoor",  role:"Product Manager")
    ]
    private let features: [Feature] = [
        Feature(icon:"calendar.badge.clock", title:"Event Discovery", desc:"Find workshops, fests and club activities happening around campus."),
        Feature(icon:"person.3.fill",        title:"Club Connect",    desc:"Join clubs, follow updates and never miss a meeting."),
        Feature(icon:"bell.badge.fill",      title:"Smart Alerts",    desc:"Instant notifications that match your interests."),
        Feature(icon:"bookmark.fill",        title:"Save & RSVP",     desc:"Bookmark and RSVP with one tap from your feed.")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    navBar; appIdentity; missionBlock; featuresSection; teamSection; linksSection; footer
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(item: $activeSheet) { sheet in
            aboutSheetView(for: sheet)
        }
    }

    // MARK: – Nav
    var navBar: some View {
        HStack {
            Button { dismiss() } label: {
                HStack(spacing: 5) {
                    Image(systemName: "chevron.left").font(.system(size: 15, weight: .semibold))
                    Text("Back")
                }.foregroundColor(Color(white: 0.55))
            }
            Spacer()
            Text("About Us").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
            Spacer()
            Color.clear.frame(width: 60)
        }
        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 24)
    }

    // MARK: – App identity
    var appIdentity: some View {
        VStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 24).fill(Color(white: 0.12)).frame(width: 88, height: 88)
                RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2.5).frame(width: 40, height: 40)
            }
            Text("CampusHub").font(.system(size: 28, weight: .bold)).foregroundColor(.white)
            Text("Version 1.0.0").font(.system(size: 12)).foregroundColor(Color(white: 0.32))
            Text("Your campus. All in one place.").font(.system(size: 15)).foregroundColor(Color(white: 0.5))
            Text("CampusHub was built to solve a simple problem — students missing out on amazing events happening right around them. We connect students with clubs, events, workshops and each other.")
                .font(.system(size: 14)).foregroundColor(Color(white: 0.45))
                .multilineTextAlignment(.center).lineSpacing(5).padding(.horizontal, 8)
        }
        .padding(.horizontal, 24).padding(.bottom, 28)
    }

    // MARK: – Mission
    var missionBlock: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "target").font(.system(size: 18)).foregroundColor(.white)
            VStack(alignment: .leading, spacing: 6) {
                Text("Our Mission").font(.system(size: 16, weight: .bold)).foregroundColor(.white)
                Text("To build the most connected campus community — where every student discovers, participates, and grows.")
                    .font(.system(size: 13)).foregroundColor(Color(white: 0.55)).lineSpacing(4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading).padding(18)
        .background(Color(white: 0.08)).cornerRadius(16)
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(white: 0.14), lineWidth: 1))
        .padding(.horizontal, 20).padding(.bottom, 24)
    }

    // MARK: – Features
    var featuresSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionLabel("WHAT WE OFFER")
            VStack(spacing: 0) {
                ForEach(features) { f in
                    HStack(alignment: .top, spacing: 14) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10).fill(Color(white: 0.1)).frame(width: 40, height: 40)
                            Image(systemName: f.icon).font(.system(size: 16)).foregroundColor(.white)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text(f.title).font(.system(size: 14, weight: .semibold)).foregroundColor(.white)
                            Text(f.desc).font(.system(size: 12)).foregroundColor(Color(white: 0.45)).lineSpacing(3)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20).padding(.vertical, 14)
                    if f.id != features.last?.id { Divider().background(Color(white: 0.1)).padding(.horizontal, 20) }
                }
            }
            .background(Color(white: 0.07)).cornerRadius(20)
            .padding(.horizontal, 20).padding(.bottom, 24)
        }
    }

    // MARK: – Team
    var teamSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionLabel("THE TEAM")
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(team) { m in
                    VStack(spacing: 10) {
                        ZStack {
                            Circle().fill(Color(white: 0.15)).frame(width: 52, height: 52)
                            Text(m.initials).font(.system(size: 16, weight: .bold)).foregroundColor(.white)
                        }
                        VStack(spacing: 3) {
                            Text(m.name).font(.system(size: 13, weight: .semibold)).foregroundColor(.white)
                            Text(m.role).font(.system(size: 11)).foregroundColor(Color(white: 0.4)).multilineTextAlignment(.center)
                        }
                    }
                    .frame(maxWidth: .infinity).padding(.vertical, 16)
                    .background(Color(white: 0.07)).cornerRadius(16)
                }
            }
            .padding(.horizontal, 20).padding(.bottom, 24)
        }
    }

    // MARK: – Links (now open sheets)
    var linksSection: some View {
        VStack(spacing: 0) {
            linkRow(icon: "lock.shield",     label: "Privacy Policy",       color: .blue)   { activeSheet = .privacy }
            Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
            linkRow(icon: "doc.text",        label: "Terms of Service",     color: .indigo) { activeSheet = .terms }
            Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
            linkRow(icon: "envelope",        label: "Contact Us",           color: .green)  { activeSheet = .contact }
            Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
            linkRow(icon: "camera.fill",     label: "Follow on Instagram",  color: .pink)   { activeSheet = .follow }
        }
        .background(Color(white: 0.07)).cornerRadius(20)
        .padding(.horizontal, 20).padding(.bottom, 20)
    }

    @ViewBuilder
    func linkRow(icon: String, label: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 9).fill(color.opacity(0.18)).frame(width: 36, height: 36)
                    Image(systemName: icon).font(.system(size: 15)).foregroundColor(color)
                }
                Text(label).font(.system(size: 14, weight: .medium)).foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right").font(.system(size: 13)).foregroundColor(Color(white: 0.3))
            }
            .padding(.horizontal, 20).padding(.vertical, 14)
        }
    }

    var footer: some View {
        Text("Made with ❤️ on campus").font(.system(size: 13)).foregroundColor(Color(white: 0.28)).padding(.bottom, 40)
    }

    func sectionLabel(_ t: String) -> some View {
        Text(t).font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.35))
            .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 24).padding(.bottom, 10)
    }

    // MARK: – Sheet content router
    @ViewBuilder
    func aboutSheetView(for sheet: AboutSheet) -> some View {
        switch sheet {
        case .privacy:   PrivacyPolicySheet()
        case .terms:     TermsOfServiceSheet()
        case .contact:   ContactUsSheet()
        case .follow:    FollowInstagramSheet()
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - Privacy Policy Sheet
// ─────────────────────────────────────────────
struct PrivacyPolicySheet: View {
    @Environment(\.dismiss) var dismiss

    private let sections: [(title: String, body: String)] = [
        ("Information We Collect", "We collect information you provide when creating your account — such as your name, university email address, department, and profile photo. We also collect data about events you RSVP to, clubs you join, and events you bookmark or like within the app."),
        ("How We Use Your Information", "Your information is used to personalise your campus experience — showing you relevant events, connecting you with clubs that match your interests, and sending you timely notifications. We never sell your personal data to third parties."),
        ("Data Storage & Security", "All data is stored on secure servers with industry-standard encryption. Your profile image is stored locally on your device unless you explicitly share it. We use end-to-end encryption for all communications within the app."),
        ("Notifications", "With your permission, we send push notifications about upcoming events, club updates, and RSVP confirmations. You can manage these preferences at any time in Profile → Notifications."),
        ("Third-Party Services", "CampusHub may integrate with university systems for event verification. We do not share identifiable data with advertisers. Analytics data is anonymised before any processing."),
        ("Your Rights", "You may request deletion of your account and all associated data at any time through Profile → Privacy & Security → Delete Account. You may also export your data by contacting support."),
        ("Contact", "For privacy-related concerns, email us at privacy@campushub.app. We respond to all requests within 48 hours.")
    ]

    var body: some View {
        legalSheet(title: "Privacy Policy", icon: "lock.shield", color: .blue, sections: sections)
    }
}

// ─────────────────────────────────────────────
// MARK: - Terms of Service Sheet
// ─────────────────────────────────────────────
struct TermsOfServiceSheet: View {
    @Environment(\.dismiss) var dismiss

    private let sections: [(title: String, body: String)] = [
        ("Acceptance of Terms", "By creating a CampusHub account and using the app, you agree to these Terms of Service. If you do not agree, please do not use the app. These terms apply to all users including students, club administrators, and event organisers."),
        ("Eligibility", "CampusHub is intended for students, faculty, and staff of registered educational institutions. You must be at least 13 years old to use the app, and 18 or older to organise public events."),
        ("User Conduct", "You agree not to post harmful, misleading, or inappropriate content. Club and event information must be accurate. Impersonation of other users or organisations is strictly prohibited and may result in immediate account termination."),
        ("Content Ownership", "You retain ownership of content you post (profile info, event descriptions, club posts). By posting, you grant CampusHub a non-exclusive licence to display that content within the app. We will never claim ownership of your content."),
        ("Event & Club Guidelines", "Events listed must be genuine campus activities. Clubs must have a stated purpose aligned with educational or extracurricular activities. CampusHub reserves the right to remove events or clubs that violate these guidelines."),
        ("Limitation of Liability", "CampusHub is a platform for campus connectivity. We are not responsible for the conduct of event organisers, club administrators, or other users. Always use your judgement when attending events."),
        ("Changes to Terms", "We may update these terms from time to time. Continued use of the app after changes constitutes acceptance of the new terms. We will notify you of major changes via in-app notification.")
    ]

    var body: some View {
        legalSheet(title: "Terms of Service", icon: "doc.text", color: .indigo, sections: sections)
    }
}

// ─────────────────────────────────────────────
// MARK: - Contact Us Sheet
// ─────────────────────────────────────────────
struct ContactUsSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var name     = ""
    @State private var email    = ""
    @State private var subject  = "General Enquiry"
    @State private var message  = ""
    @State private var sent     = false

    private let subjects = ["General Enquiry", "Report a Bug", "Event Issue", "Club Issue", "Account Help", "Privacy Concern", "Feedback"]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if sent {
                // Success state
                VStack(spacing: 20) {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill").font(.system(size: 64)).foregroundColor(.green)
                    Text("Message Sent!").font(.system(size: 24, weight: .bold)).foregroundColor(.white)
                    Text("We'll get back to you at\n\(email.isEmpty ? "your email" : email)\nwithin 24–48 hours.")
                        .font(.system(size: 15)).foregroundColor(Color(white: 0.5))
                        .multilineTextAlignment(.center).lineSpacing(4)
                    Spacer()
                    Button { dismiss() } label: {
                        Text("Done")
                            .font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                            .frame(maxWidth: .infinity).frame(height: 52)
                            .background(Color.white).cornerRadius(13)
                    }
                    .padding(.horizontal, 24).padding(.bottom, 40)
                }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header
                        HStack {
                            Button { dismiss() } label: {
                                Image(systemName: "xmark").font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                            }
                            Spacer()
                            Text("Contact Us").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
                            Spacer()
                            Color.clear.frame(width: 28)
                        }
                        .padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 24)

                        // Contact cards
                        HStack(spacing: 12) {
                            contactCard(icon: "envelope.fill",  label: "Email",      value: "support@\ncampushub.app", color: .blue)
                            contactCard(icon: "clock.fill",     label: "Response",   value: "24–48\nhours",            color: .green)
                        }
                        .padding(.horizontal, 20).padding(.bottom, 24)

                        // Form
                        VStack(spacing: 16) {
                            formField("Your Name",    icon: "person",   text: $name,  kb: .default)
                            formField("Your Email",   icon: "envelope", text: $email, kb: .emailAddress)

                            // Subject picker
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Subject").font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.5))
                                Menu {
                                    ForEach(subjects, id: \.self) { s in Button(s) { subject = s } }
                                } label: {
                                    HStack(spacing: 12) {
                                        Image(systemName: "tag").foregroundColor(Color(white: 0.4)).font(.system(size: 15))
                                        Text(subject).foregroundColor(.white).font(.system(size: 14))
                                        Spacer()
                                        Image(systemName: "chevron.up.chevron.down").font(.system(size: 12)).foregroundColor(Color(white: 0.35))
                                    }
                                    .padding(.horizontal, 16).padding(.vertical, 14)
                                    .background(Color(white: 0.1)).cornerRadius(12)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
                                }
                            }

                            // Message
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Message").font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.5))
                                ZStack(alignment: .topLeading) {
                                    if message.isEmpty {
                                        Text("Describe your issue or feedback…")
                                            .font(.system(size: 14)).foregroundColor(Color(white: 0.3))
                                            .padding(.horizontal, 16).padding(.top, 14)
                                    }
                                    TextEditor(text: $message)
                                        .foregroundColor(.white).font(.system(size: 14))
                                        .scrollContentBackground(.hidden).background(Color.clear)
                                        .padding(10).frame(minHeight: 120)
                                }
                                .background(Color(white: 0.1)).cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
                                HStack { Spacer(); Text("\(message.count)/500").font(.system(size: 11)).foregroundColor(Color(white: 0.3)) }
                            }

                            Button {
                                withAnimation { sent = true }
                            } label: {
                                Text("Send Message")
                                    .font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                                    .frame(maxWidth: .infinity).frame(height: 52)
                                    .background(canSend ? Color.white : Color(white: 0.25))
                                    .cornerRadius(13)
                            }
                            .disabled(!canSend)
                        }
                        .padding(20).background(Color(white: 0.07)).cornerRadius(20)
                        .padding(.horizontal, 20).padding(.bottom, 40)
                    }
                }
            }
        }
    }

    var canSend: Bool { !name.isEmpty && !email.isEmpty && !message.isEmpty }

    @ViewBuilder
    func contactCard(icon: String, label: String, value: String, color: Color) -> some View {
        VStack(spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 12).fill(color.opacity(0.18)).frame(width: 48, height: 48)
                Image(systemName: icon).font(.system(size: 20)).foregroundColor(color)
            }
            Text(label).font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.4))
            Text(value).font(.system(size: 13, weight: .medium)).foregroundColor(.white).multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity).padding(.vertical, 18)
        .background(Color(white: 0.07)).cornerRadius(16)
    }

    @ViewBuilder
    func formField(_ lbl: String, icon: String, text: Binding<String>, kb: UIKeyboardType) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(lbl).font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.5))
            HStack(spacing: 12) {
                Image(systemName: icon).foregroundColor(Color(white: 0.4)).font(.system(size: 15))
                TextField("", text: text).foregroundColor(.white).font(.system(size: 14))
                    .keyboardType(kb).autocapitalization(kb == .emailAddress ? .none : .words)
            }
            .padding(.horizontal, 16).padding(.vertical, 14)
            .background(Color(white: 0.1)).cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - Follow on Instagram Sheet
// ─────────────────────────────────────────────
struct FollowInstagramSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var followed = false

    private let posts: [(icon: String, label: String)] = [
        ("calendar.fill",     "Event highlights"),
        ("person.3.fill",     "Club spotlights"),
        ("camera.fill",       "Campus moments"),
        ("megaphone.fill",    "Announcements")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark").font(.system(size: 16, weight: .semibold)).foregroundColor(.white)
                    }
                    Spacer()
                    Text("Instagram").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
                    Spacer()
                    Color.clear.frame(width: 28)
                }
                .padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 24)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        // IG Profile card
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(colors: [.purple, .pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 90, height: 90)
                                Text("CH").font(.system(size: 28, weight: .bold)).foregroundColor(.white)
                            }
                            VStack(spacing: 4) {
                                Text("@campushub_official").font(.system(size: 18, weight: .bold)).foregroundColor(.white)
                                Text("Your campus community 🎓").font(.system(size: 14)).foregroundColor(Color(white: 0.5))
                                Text("campushub.app").font(.system(size: 12)).foregroundColor(.blue)
                            }

                            // Stats
                            HStack(spacing: 0) {
                                ForEach([("2.4K","Posts"),("18.6K","Followers"),("342","Following")], id: \.0) { s in
                                    VStack(spacing: 2) {
                                        Text(s.0).font(.system(size: 18, weight: .bold)).foregroundColor(.white)
                                        Text(s.1).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
                                    }
                                    .frame(maxWidth: .infinity)
                                    if s.1 != "Following" { Rectangle().fill(Color(white: 0.15)).frame(width: 1, height: 30) }
                                }
                            }
                            .padding(.vertical, 12).background(Color(white: 0.08)).cornerRadius(14)

                            // Follow button
                            Button { withAnimation(.spring()) { followed.toggle() } } label: {
                                HStack(spacing: 8) {
                                    Image(systemName: followed ? "checkmark" : "plus")
                                        .font(.system(size: 14, weight: .semibold))
                                    Text(followed ? "Following" : "Follow")
                                        .font(.system(size: 15, weight: .semibold))
                                }
                                .foregroundColor(followed ? Color(white: 0.4) : .black)
                                .frame(maxWidth: .infinity).frame(height: 46)
                                .background(followed ? Color(white: 0.15) : Color.white)
                                .cornerRadius(12)
                            }
                        }
                        .padding(20).background(Color(white: 0.07)).cornerRadius(20)
                        .padding(.horizontal, 20)

                        // What we post
                        VStack(alignment: .leading, spacing: 14) {
                            Text("WHAT WE POST")
                                .font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.35))
                                .padding(.horizontal, 24)
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                ForEach(posts, id: \.label) { post in
                                    VStack(spacing: 10) {
                                        Image(systemName: post.icon).font(.system(size: 24)).foregroundColor(.white)
                                        Text(post.label).font(.system(size: 12, weight: .medium)).foregroundColor(Color(white: 0.6)).multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: .infinity).padding(.vertical, 18)
                                    .background(Color(white: 0.07)).cornerRadius(14)
                                }
                            }
                            .padding(.horizontal, 20)
                        }

                        // Open in Instagram button
                        Button {
                            if let url = URL(string: "instagram://user?username=campushub_official") {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url)
                                } else if let web = URL(string: "https://instagram.com/campushub_official") {
                                    UIApplication.shared.open(web)
                                }
                            }
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "arrow.up.right.square").font(.system(size: 16))
                                Text("Open in Instagram").font(.system(size: 15, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity).frame(height: 52)
                            .background(
                                LinearGradient(colors: [Color(red:0.56,green:0,blue:0.77), Color(red:0.91,green:0.27,blue:0.36), Color(red:0.98,green:0.65,blue:0.25)],
                                               startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(13)
                        }
                        .padding(.horizontal, 20).padding(.bottom, 40)
                    }
                }
            }
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - Shared legal sheet builder
// ─────────────────────────────────────────────
private func legalSheet(title: String, icon: String, color: Color, sections: [(title: String, body: String)]) -> some View {
    _LegalSheet(title: title, icon: icon, color: color, sections: sections)
}

private struct _LegalSheet: View {
    @Environment(\.dismiss) var dismiss
    let title: String; let icon: String; let color: Color
    let sections: [(title: String, body: String)]

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
                        Text(title).font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
                        Spacer()
                        Color.clear.frame(width: 28)
                    }
                    .padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 24)

                    // Icon + last updated
                    VStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18).fill(color.opacity(0.18)).frame(width: 72, height: 72)
                            Image(systemName: icon).font(.system(size: 30)).foregroundColor(color)
                        }
                        Text(title).font(.system(size: 22, weight: .bold)).foregroundColor(.white)
                        Text("Last updated: April 1, 2025").font(.system(size: 12)).foregroundColor(Color(white: 0.35))
                    }
                    .padding(.bottom, 28)

                    // Sections
                    VStack(spacing: 0) {
                        ForEach(Array(sections.enumerated()), id: \.offset) { idx, section in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack(spacing: 10) {
                                    Text("\(idx + 1)").font(.system(size: 12, weight: .bold))
                                        .foregroundColor(color)
                                        .frame(width: 24, height: 24)
                                        .background(color.opacity(0.18))
                                        .clipShape(Circle())
                                    Text(section.title).font(.system(size: 15, weight: .semibold)).foregroundColor(.white)
                                }
                                Text(section.body)
                                    .font(.system(size: 13)).foregroundColor(Color(white: 0.55))
                                    .lineSpacing(5).fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.horizontal, 20).padding(.vertical, 16)
                            if idx < sections.count - 1 { Divider().background(Color(white: 0.1)).padding(.horizontal, 20) }
                        }
                    }
                    .background(Color(white: 0.07)).cornerRadius(20)
                    .padding(.horizontal, 20).padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    NavigationStack { AboutUsScreen() }
}
