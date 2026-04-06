//
//  EditProfileScreen.swift
//  CampusHub
//
//  Created by iMac1 on 06/04/26.
//

import SwiftUI
import PhotosUI

// ─────────────────────────────────────────────
// MARK: - EditProfileScreen
// ─────────────────────────────────────────────
struct EditProfileScreen: View {
    @EnvironmentObject var store: UserProfileStore
    @Environment(\.dismiss) var dismiss

    @State private var draftName:      String   = ""
    @State private var draftDept:      String   = ""
    @State private var draftYear:      String   = ""
    @State private var draftEmail:     String   = ""
    @State private var draftBio:       String   = ""
    @State private var draftInterests: [String] = []
    @State private var draftImage:     UIImage? = nil

    @State private var newInterest:    String   = ""
    @State private var pickerItem:     PhotosPickerItem?
    @State private var showPicker      = false
    @State private var showDialog      = false
    @State private var showToast       = false

    private let depts = ["CS Engineering","Electrical","Mechanical","Civil","Biotechnology","MBA","Design"]
    private let years = ["1st Year","2nd Year","3rd Year","4th Year","Postgrad"]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    navBar
                    avatarPicker
                    formCard
                    saveButton
                }
            }

            // Toast
            if showToast {
                VStack {
                    Spacer()
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark.circle.fill").foregroundColor(.white)
                        Text("Profile saved!").font(.system(size: 14, weight: .medium)).foregroundColor(.white)
                    }
                    .padding(.horizontal, 22).padding(.vertical, 13)
                    .background(Color(white: 0.18)).cornerRadius(30)
                    .padding(.bottom, 48)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(), value: showToast)
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: loadDraft)
        .photosPicker(isPresented: $showPicker, selection: $pickerItem, matching: .images)
        .onChange(of: pickerItem) { item in
            Task {
                if let data = try? await item?.loadTransferable(type: Data.self),
                   let img  = UIImage(data: data) {
                    await MainActor.run { draftImage = img }
                }
            }
        }
        .confirmationDialog("Change Photo", isPresented: $showDialog, titleVisibility: .visible) {
            Button("Choose from Library") { showPicker = true }
            Button("Remove Photo", role: .destructive) { draftImage = nil; store.profileImage = nil }
            Button("Cancel", role: .cancel) {}
        }
    }

    // MARK: – Nav bar
    var navBar: some View {
        HStack {
            Button { dismiss() } label: {
                HStack(spacing: 5) {
                    Image(systemName: "chevron.left").font(.system(size: 15, weight: .semibold))
                    Text("Back")
                }.foregroundColor(Color(white: 0.55))
            }
            Spacer()
            Text("Edit Profile").font(.system(size: 17, weight: .semibold)).foregroundColor(.white)
            Spacer()
            Button(action: save) {
                Text("Save")
                    .font(.system(size: 15, weight: .semibold)).foregroundColor(.black)
                    .padding(.horizontal, 16).padding(.vertical, 7)
                    .background(Color.white).cornerRadius(10)
            }
        }
        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 24)
    }

    // MARK: – Avatar picker
    var avatarPicker: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if let img = draftImage {
                        Image(uiImage: img).resizable().scaledToFill()
                    } else {
                        ZStack {
                            Circle().fill(Color(white: 0.22))
                            Text(store.initials)
                                .font(.system(size: 32, weight: .bold)).foregroundColor(.white)
                        }
                    }
                }
                .frame(width: 96, height: 96)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(white: 0.25), lineWidth: 2))

                Button { showDialog = true } label: {
                    ZStack {
                        Circle().fill(Color.white).frame(width: 30, height: 30)
                        Image(systemName: "camera.fill").font(.system(size: 13)).foregroundColor(.black)
                    }
                }
                .offset(x: 2, y: 2)
            }
            Text("Tap to change photo")
                .font(.system(size: 12)).foregroundColor(Color(white: 0.38))
        }
        .padding(.bottom, 28)
    }

    // MARK: – Form
    var formCard: some View {
        VStack(spacing: 18) {
            editField("Full Name",  icon: "person",   kb: .default,      text: $draftName)
            editField("Email",      icon: "envelope", kb: .emailAddress, text: $draftEmail)

            // Department
            menuPicker("Department", icon: "building.2",
                       label: draftDept.isEmpty ? "Select" : draftDept) {
                ForEach(depts, id: \.self) { d in Button(d) { draftDept = d } }
            }

            // Year
            menuPicker("Year", icon: "calendar",
                       label: draftYear.isEmpty ? "Select" : draftYear) {
                ForEach(years, id: \.self) { y in Button(y) { draftYear = y } }
            }

            // Bio
            VStack(alignment: .leading, spacing: 8) {
                fieldLabel("Bio")
                ZStack(alignment: .topLeading) {
                    if draftBio.isEmpty {
                        Text("Write something about yourself…")
                            .font(.system(size: 14)).foregroundColor(Color(white: 0.3))
                            .padding(.horizontal, 16).padding(.top, 14)
                    }
                    TextEditor(text: $draftBio)
                        .foregroundColor(.white).font(.system(size: 14))
                        .scrollContentBackground(.hidden).background(Color.clear)
                        .padding(10).frame(minHeight: 90)
                        .onChange(of: draftBio) { v in if v.count > 160 { draftBio = String(v.prefix(160)) } }
                }
                .background(Color(white: 0.1)).cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
                HStack { Spacer()
                    Text("\(draftBio.count)/160").font(.system(size: 11)).foregroundColor(Color(white: 0.3)) }
            }

            // Interests
            VStack(alignment: .leading, spacing: 12) {
                fieldLabel("Interests")
                if !draftInterests.isEmpty {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                        ForEach(draftInterests, id: \.self) { chip in
                            HStack(spacing: 6) {
                                Text(chip).font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white).lineLimit(1)
                                Spacer(minLength: 0)
                                Button { draftInterests.removeAll { $0 == chip } } label: {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 9, weight: .bold))
                                        .foregroundColor(Color(white: 0.5))
                                }
                            }
                            .padding(.horizontal, 12).padding(.vertical, 8)
                            .background(Color(white: 0.14)).cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(white: 0.2), lineWidth: 1))
                        }
                    }
                }
                HStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Image(systemName: "plus").font(.system(size: 13)).foregroundColor(Color(white: 0.4))
                        TextField("", text: $newInterest,
                                  prompt: Text("Add interest…").foregroundColor(Color(white: 0.3)))
                            .foregroundColor(.white).font(.system(size: 14))
                    }
                    .padding(.horizontal, 14).padding(.vertical, 12)
                    .background(Color(white: 0.1)).cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))

                    Button(action: addInterest) {
                        Text("Add").font(.system(size: 13, weight: .semibold)).foregroundColor(.black)
                            .padding(.horizontal, 16).padding(.vertical, 12)
                            .background(newInterest.trimmingCharacters(in: .whitespaces).isEmpty
                                        ? Color(white: 0.3) : Color.white)
                            .cornerRadius(12)
                    }
                    .disabled(newInterest.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
        .padding(20)
        .background(Color(white: 0.07)).cornerRadius(20)
        .padding(.horizontal, 20).padding(.bottom, 24)
    }

    var saveButton: some View {
        Button(action: save) {
            Text("Save Changes")
                .font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                .frame(maxWidth: .infinity).frame(height: 52)
                .background(Color.white).cornerRadius(13)
        }
        .padding(.horizontal, 20).padding(.bottom, 40)
    }

    // MARK: – Field builders
    @ViewBuilder
    func editField(_ label: String, icon: String, kb: UIKeyboardType,
                   text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            fieldLabel(label)
            HStack(spacing: 12) {
                Image(systemName: icon).foregroundColor(Color(white: 0.4))
                    .font(.system(size: 15)).frame(width: 18)
                TextField("", text: text)
                    .foregroundColor(.white).font(.system(size: 14))
                    .keyboardType(kb)
                    .autocapitalization(kb == .emailAddress ? .none : .words)
            }
            .padding(.horizontal, 16).padding(.vertical, 14)
            .background(Color(white: 0.1)).cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
        }
    }

    @ViewBuilder
    func menuPicker<C: View>(_ label: String, icon: String, label lbl: String,
                             @ViewBuilder content: () -> C) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            fieldLabel(label)
            Menu { content() } label: {
                HStack(spacing: 12) {
                    Image(systemName: icon).foregroundColor(Color(white: 0.4))
                        .font(.system(size: 15)).frame(width: 18)
                    Text(lbl)
                        .foregroundColor(lbl == "Select" ? Color(white: 0.3) : .white)
                        .font(.system(size: 14))
                    Spacer()
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 12)).foregroundColor(Color(white: 0.35))
                }
                .padding(.horizontal, 16).padding(.vertical, 14)
                .background(Color(white: 0.1)).cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
            }
        }
    }

    func fieldLabel(_ t: String) -> some View {
        Text(t).font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.5))
    }

    // MARK: – Actions
    func loadDraft() {
        draftName = store.name; draftDept = store.department
        draftYear = store.year; draftEmail = store.email
        draftBio  = store.bio;  draftInterests = store.interests
        draftImage = store.profileImage
    }

    func addInterest() {
        let t = newInterest.trimmingCharacters(in: .whitespaces)
        guard !t.isEmpty, !draftInterests.contains(t) else { return }
        draftInterests.append(t); newInterest = ""
    }

    func save() {
        store.name = draftName; store.department = draftDept
        store.year = draftYear; store.email = draftEmail
        store.bio  = draftBio;  store.interests = draftInterests
        if let img = draftImage { store.profileImage = img }
        withAnimation { showToast = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            withAnimation { showToast = false }
            dismiss()
        }
    }
}

#Preview {
    NavigationStack { EditProfileScreen().environmentObject(UserProfileStore()) }
}
