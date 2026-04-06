//
//  NotificationSettingsScreen.swift
//  CampusHub
//
//  Created by iMac1 on 06/04/26.
//

import SwiftUI

// ─────────────────────────────────────────────
// MARK: - NotificationSettingsScreen
// ─────────────────────────────────────────────
struct NotificationSettingsScreen: View {
    @EnvironmentObject var store: UserProfileStore
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    navBar

                    // Banner
                    HStack(spacing: 14) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(white: 0.12)).frame(width: 52, height: 52)
                            Image(systemName: "bell.badge.fill")
                                .font(.system(size: 24)).foregroundColor(.white)
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Stay in the loop")
                                .font(.system(size: 15, weight: .semibold)).foregroundColor(.white)
                            Text("Choose what you want to be notified about.")
                                .font(.system(size: 12)).foregroundColor(Color(white: 0.45))
                        }
                        Spacer()
                    }
                    .padding(16)
                    .background(Color(white: 0.07)).cornerRadius(16)
                    .padding(.horizontal, 20).padding(.bottom, 24)

                    // Push section
                    sectionLabel("PUSH NOTIFICATIONS")
                    card {
                        row("calendar.badge.clock", "Event Updates",
                            "New events matching your interests",     $store.notifEvents)
                        div
                        row("person.3.fill",        "Club Activity",
                            "Posts from clubs you've joined",         $store.notifClubs)
                        div
                        row("checkmark.circle",     "RSVP Confirmations",
                            "When your RSVP is confirmed",            $store.notifRSVP)
                        div
                        row("clock.badge.exclamationmark", "Event Reminders",
                            "1 hour before events you've joined",     $store.notifReminders)
                        div
                        row("plus.circle",          "New Clubs",
                            "When new clubs are created on campus",   $store.notifNewClubs)
                    }
                    .padding(.bottom, 20)

                    // Email section
                    sectionLabel("EMAIL NOTIFICATIONS")
                    card {
                        row("envelope.fill", "Weekly Digest",
                            "Top events every Monday morning",        $store.notifEmail)
                    }
                    .padding(.bottom, 24)

                    // Note
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "info.circle")
                            .foregroundColor(Color(white: 0.4)).font(.system(size: 14))
                        Text("To manage system permissions go to iOS Settings → CampusHub → Notifications.")
                            .font(.system(size: 12)).foregroundColor(Color(white: 0.38)).lineSpacing(3)
                    }
                    .padding(14)
                    .background(Color(white: 0.06)).cornerRadius(12)
                    .padding(.horizontal, 20).padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: – Helpers
    var navBar: some View {
        HStack {
            Button { dismiss() } label: {
                HStack(spacing: 5) {
                    Image(systemName: "chevron.left").font(.system(size: 15, weight: .semibold))
                    Text("Back")
                }.foregroundColor(Color(white: 0.55))
            }
            Spacer()
            Text("Notifications").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
            Spacer()
            Color.clear.frame(width: 60)
        }
        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 24)
    }

    func sectionLabel(_ t: String) -> some View {
        Text(t).font(.system(size: 11, weight: .semibold)).foregroundColor(Color(white: 0.35))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24).padding(.bottom, 10)
    }

    @ViewBuilder
    func card<C: View>(@ViewBuilder _ content: () -> C) -> some View {
        VStack(spacing: 0) { content() }
            .background(Color(white: 0.07)).cornerRadius(20)
            .padding(.horizontal, 20)
    }

    @ViewBuilder
    func row(_ icon: String, _ title: String, _ sub: String, _ b: Binding<Bool>) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(white: 0.12)).frame(width: 40, height: 40)
                Image(systemName: icon).font(.system(size: 16)).foregroundColor(.white)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.system(size: 15, weight: .medium)).foregroundColor(.white)
                Text(sub).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
            }
            Spacer()
            Toggle("", isOn: b).tint(.white).scaleEffect(0.85)
        }
        .padding(.horizontal, 20).padding(.vertical, 13)
    }

    var div: some View {
        Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
    }
}

#Preview {
    NavigationStack { NotificationSettingsScreen().environmentObject(UserProfileStore()) }
}
