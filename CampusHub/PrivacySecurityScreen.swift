//
//  PrivacySecurityScreen.swift
//  CampusHub
//
//  Created by iMac1 on 06/04/26.
//

import SwiftUI

// ─────────────────────────────────────────────
// MARK: - PrivacySecurityScreen
// ─────────────────────────────────────────────
struct PrivacySecurityScreen: View {
    @EnvironmentObject var store: UserProfileStore
    @Environment(\.dismiss) var dismiss

    @State private var expandPwd     = false
    @State private var curPwd        = ""
    @State private var newPwd        = ""
    @State private var confPwd       = ""
    @State private var showPwd       = false
    @State private var pwdOK         = false
    @State private var pwdErr        = ""
    @State private var showDeact     = false
    @State private var showDelete    = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    navBar

                    // Privacy
                    sectionLabel("PROFILE PRIVACY")
                    card {
                        tog("eye.fill",                 "Public Profile",
                            "Let others find you",                   $store.profilePublic)
                        div
                        tog("envelope",                 "Show Email",
                            "Display email on your profile",         $store.showEmail)
                        div
                        tog("calendar.badge.checkmark", "Show Attending Events",
                            "Others see events you've RSVP'd",       $store.showAttending)
                    }
                    .padding(.bottom, 20)

                    // Security
                    sectionLabel("ACCOUNT SECURITY")
                    card {
                        tog("faceid",        "Face ID / Touch ID",
                            "Use biometrics to unlock",              $store.biometric)
                        div
                        tog("lock.shield.fill","Two-Factor Auth",
                            "Extra layer of login security",         $store.twoFactor)
                        div
                        // Change password accordion
                        Button {
                            withAnimation(.spring(response: 0.35)) { expandPwd.toggle() }
                        } label: {
                            HStack(spacing: 14) {
                                iconBox("key.fill")
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Change Password")
                                        .font(.system(size: 15, weight: .medium)).foregroundColor(.white)
                                    Text("Update your login password")
                                        .font(.system(size: 12)).foregroundColor(Color(white: 0.4))
                                }
                                Spacer()
                                Image(systemName: expandPwd ? "chevron.up" : "chevron.right")
                                    .font(.system(size: 13)).foregroundColor(Color(white: 0.3))
                            }
                            .padding(.horizontal, 20).padding(.vertical, 14)
                        }

                        if expandPwd {
                            VStack(spacing: 14) {
                                div
                                VStack(spacing: 12) {
                                    pwdField("Current Password",     $curPwd)
                                    pwdField("New Password",          $newPwd)
                                    pwdField("Confirm New Password",  $confPwd)

                                    Button { showPwd.toggle() } label: {
                                        HStack(spacing: 6) {
                                            Image(systemName: showPwd ? "eye.slash" : "eye")
                                                .font(.system(size: 13))
                                            Text(showPwd ? "Hide" : "Show passwords")
                                                .font(.system(size: 13))
                                        }
                                        .foregroundColor(Color(white: 0.45))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }

                                    if !pwdErr.isEmpty {
                                        Label(pwdErr, systemImage: "exclamationmark.circle.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.red.opacity(0.85))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    if pwdOK {
                                        Label("Password updated!", systemImage: "checkmark.circle.fill")
                                            .font(.system(size: 12)).foregroundColor(.green)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }

                                    Button(action: savePwd) {
                                        Text("Update Password")
                                            .font(.system(size: 14, weight: .semibold)).foregroundColor(.black)
                                            .frame(maxWidth: .infinity).frame(height: 46)
                                            .background(canSave ? Color.white : Color(white: 0.25))
                                            .cornerRadius(12)
                                    }
                                    .disabled(!canSave)
                                }
                                .padding(.horizontal, 20).padding(.bottom, 16)
                            }
                            .transition(.opacity.combined(with: .move(edge: .top)))
                        }
                    }
                    .padding(.bottom, 20)

                    // Danger zone
                    sectionLabel("DANGER ZONE")
                    card {
                        dangerRow("person.badge.minus", "Deactivate Account",
                                  "Temporarily hide your profile", .orange) { showDeact = true }
                        div
                        dangerRow("trash.fill", "Delete Account",
                                  "Permanently remove your data", .red) { showDelete = true }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
        .alert("Deactivate Account?", isPresented: $showDeact) {
            Button("Deactivate", role: .destructive) {}
            Button("Cancel", role: .cancel) {}
        } message: { Text("Your profile will be hidden until you log back in.") }
        .alert("Delete Account?", isPresented: $showDelete) {
            Button("Delete", role: .destructive) {}
            Button("Cancel", role: .cancel) {}
        } message: { Text("This is permanent and cannot be undone.") }
    }

    var canSave: Bool { !curPwd.isEmpty && newPwd.count >= 8 && newPwd == confPwd }

    func savePwd() {
        pwdErr = ""
        guard newPwd == confPwd else { pwdErr = "Passwords don't match."; return }
        guard newPwd.count >= 8  else { pwdErr = "Minimum 8 characters required."; return }
        pwdOK = true
        curPwd = ""; newPwd = ""; confPwd = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            pwdOK = false
            withAnimation { expandPwd = false }
        }
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
            Text("Privacy & Security").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
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
    func tog(_ icon: String, _ title: String, _ sub: String, _ b: Binding<Bool>) -> some View {
        HStack(spacing: 14) {
            iconBox(icon)
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.system(size: 15, weight: .medium)).foregroundColor(.white)
                Text(sub).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
            }
            Spacer()
            Toggle("", isOn: b).tint(.white).scaleEffect(0.85)
        }
        .padding(.horizontal, 20).padding(.vertical, 13)
    }

    @ViewBuilder
    func dangerRow(_ icon: String, _ title: String, _ sub: String,
                   _ color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.opacity(0.15)).frame(width: 40, height: 40)
                    Image(systemName: icon).font(.system(size: 15)).foregroundColor(color)
                }
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.system(size: 15, weight: .medium)).foregroundColor(color)
                    Text(sub).font(.system(size: 12)).foregroundColor(Color(white: 0.4))
                }
                Spacer()
                Image(systemName: "chevron.right").font(.system(size: 13)).foregroundColor(Color(white: 0.3))
            }
            .padding(.horizontal, 20).padding(.vertical, 14)
        }
    }

    @ViewBuilder
    func pwdField(_ lbl: String, _ text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(lbl).font(.system(size: 12, weight: .medium)).foregroundColor(Color(white: 0.45))
            Group {
                if showPwd {
                    TextField("••••••••", text: text)
                } else {
                    SecureField("••••••••", text: text)
                }
            }
            .foregroundColor(.white).font(.system(size: 14))
            .padding(.horizontal, 14).padding(.vertical, 12)
            .background(Color(white: 0.1)).cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(white: 0.18), lineWidth: 1))
        }
    }

    func iconBox(_ name: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(white: 0.12)).frame(width: 40, height: 40)
            Image(systemName: name).font(.system(size: 16)).foregroundColor(.white)
        }
    }

    var div: some View { Divider().background(Color(white: 0.1)).padding(.horizontal, 20) }
}

#Preview {
    NavigationStack { PrivacySecurityScreen().environmentObject(UserProfileStore()) }
}
