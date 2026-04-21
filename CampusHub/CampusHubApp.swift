import SwiftUI
import Combine
import FirebaseAuth
import FirebaseCore

// ─────────────────────────────────────────────
// MARK: - CampusHub Logo  (shared across all screens)
// ─────────────────────────────────────────────
struct CampusHubLogo: View {
    var size: CGFloat = 72

    var body: some View {
        ZStack {
            // Background tile
            RoundedRectangle(cornerRadius: size * 0.28)
                .fill(Color(white: 0.15))
                .frame(width: size, height: size)

            // Shine gradient
            RoundedRectangle(cornerRadius: size * 0.28)
                .fill(LinearGradient(
                    colors: [Color.white.opacity(0.09), Color.clear],
                    startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size, height: size)

            // Building + dots
            VStack(spacing: size * 0.04) {

                // Campus building
                HStack(spacing: size * 0.05) {
                    // Left tower
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 2).fill(Color.white)
                            .frame(width: size * 0.08, height: size * 0.08)
                        Rectangle().fill(Color.white)
                            .frame(width: size * 0.12, height: size * 0.22)
                    }
                    // Centre building
                    VStack(spacing: 0) {
                        LogoTriangle().fill(Color.white)
                            .frame(width: size * 0.18, height: size * 0.10)
                        Rectangle().fill(Color.white)
                            .frame(width: size * 0.22, height: size * 0.18)
                        // Arch door cut-out
                        ZStack {
                            Rectangle().fill(Color(white: 0.15))
                                .frame(width: size * 0.08, height: size * 0.08)
                            Capsule()
                                .fill(Color(white: 0.15))
                                .frame(width: size * 0.09, height: size * 0.06)
                                .offset(y: -size * 0.02)
                        }
                    }
                    // Right tower
                    VStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 2).fill(Color.white)
                            .frame(width: size * 0.08, height: size * 0.08)
                        Rectangle().fill(Color.white)
                            .frame(width: size * 0.12, height: size * 0.22)
                    }
                }

                // Base line
                Rectangle().fill(Color.white)
                    .frame(width: size * 0.55, height: size * 0.025)
                    .cornerRadius(2)

                // Hub dots
                HStack(spacing: size * 0.07) {
                    Circle().fill(Color.white.opacity(0.8)).frame(width: size * 0.07, height: size * 0.07)
                    Circle().fill(Color.white)             .frame(width: size * 0.09, height: size * 0.09)
                    Circle().fill(Color.white.opacity(0.8)).frame(width: size * 0.07, height: size * 0.07)
                }
            }
        }
    }
}

// Triangle helper for logo roof
struct LogoTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            p.closeSubpath()
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - App State
// ─────────────────────────────────────────────
enum AppScreen { case splash, login, onboarding, main }

class AppState: ObservableObject {
    @Published var screen: AppScreen = .splash
}

// ─────────────────────────────────────────────
// MARK: - App Entry
// ─────────────────────────────────────────────
@main
struct CampusHubApp: App {
    @StateObject private var store    = UserProfileStore()
    @StateObject private var appState = AppState()

    init() { FirebaseApp.configure() }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .environmentObject(appState)
                .preferredColorScheme(.dark)
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - RootView
// ─────────────────────────────────────────────
struct RootView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var store:    UserProfileStore

    var body: some View {
        switch appState.screen {
        case .splash:
            SplashScreen().environmentObject(appState)
        case .login:
            LoginScreen().environmentObject(appState)
        case .onboarding:
            OnboardingScreen().environmentObject(appState)
        case .main:
            MainTabView().environmentObject(store).environmentObject(appState)
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - SplashScreen
// ─────────────────────────────────────────────
struct SplashScreen: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()

                CampusHubLogo(size: 96).padding(.bottom, 28)

                Text("CampusHub")
                    .font(.system(size: 32, weight: .bold)).foregroundColor(.white).padding(.bottom, 10)
                Text("Your campus. All\nin one place.")
                    .font(.system(size: 16)).foregroundColor(Color(white: 0.6))
                    .multilineTextAlignment(.center).padding(.bottom, 28)

                HStack(spacing: 8) {
                    Circle().fill(Color.white).frame(width: 8, height: 8)
                    Circle().fill(Color(white: 0.4)).frame(width: 8, height: 8)
                    Circle().fill(Color(white: 0.4)).frame(width: 8, height: 8)
                }.padding(.bottom, 60)

                Spacer()

                Button { appState.screen = .login } label: {
                    Text("Get Started")
                        .font(.system(size: 17, weight: .semibold)).foregroundColor(.black)
                        .frame(maxWidth: .infinity).frame(height: 54)
                        .background(Color.white).cornerRadius(14)
                }
                .padding(.horizontal, 24).padding(.bottom, 16)

                Button { appState.screen = .login } label: {
                    Text("Already have account?")
                        .font(.system(size: 15)).foregroundColor(Color(white: 0.5))
                        .frame(maxWidth: .infinity).frame(height: 50)
                        .background(Color(white: 0.12)).cornerRadius(14)
                }
                .padding(.horizontal, 24).padding(.bottom, 40)
            }
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - LoginScreen  (Firebase Auth)
// ─────────────────────────────────────────────
struct LoginScreen: View {
    @EnvironmentObject var appState: AppState

    @State private var email        = ""
    @State private var password     = ""
    @State private var showPassword = false
    @State private var isLoading    = false
    @State private var errorMessage = ""
    @State private var showError    = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {

                        // Logo
                        VStack(spacing: 14) {
                            CampusHubLogo(size: 80)
                            Text("CampusHub")
                                .font(.system(size: 28, weight: .bold)).foregroundColor(.white)
                            Text("Welcome back 👋")
                                .font(.system(size: 15)).foregroundColor(Color(white: 0.5))
                        }
                        .padding(.top, 60).padding(.bottom, 40)

                        // Form card
                        VStack(spacing: 16) {
                            loginField("Email",    icon: "envelope", text: $email,
                                       secure: false, show: .constant(false))
                            loginField("Password", icon: "lock",     text: $password,
                                       secure: !showPassword, show: $showPassword, showToggle: true)

                            // Forgot password
                            HStack {
                                Spacer()
                                NavigationLink(destination: ForgotPasswordScreen()) {
                                    Text("Forgot Password?")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(Color(white: 0.55))
                                }
                            }.padding(.top, 2)

                            // Error banner
                            if showError {
                                HStack(spacing: 8) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red).font(.system(size: 14))
                                    Text(errorMessage)
                                        .font(.system(size: 13)).foregroundColor(.red)
                                    Spacer()
                                }
                                .padding(12)
                                .background(Color.red.opacity(0.10))
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red.opacity(0.3), lineWidth: 1))
                                .transition(.opacity.combined(with: .scale(scale: 0.97)))
                            }

                            // Log In button
                            Button(action: login) {
                                ZStack {
                                    if isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                    } else {
                                        Text("Log In")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)
                                    }
                                }
                                .frame(maxWidth: .infinity).frame(height: 52)
                                .background(Color.white).cornerRadius(13)
                            }
                            .disabled(isLoading)
                            .padding(.top, 8)

                            HStack(spacing: 12) {
                                Rectangle().fill(Color(white: 0.2)).frame(height: 1)
                                Text("or").font(.system(size: 13)).foregroundColor(Color(white: 0.35))
                                Rectangle().fill(Color(white: 0.2)).frame(height: 1)
                            }

                            Button {} label: {
                                HStack(spacing: 10) {
                                    Image(systemName: "globe").font(.system(size: 16)).foregroundColor(.white)
                                    Text("Continue with Google")
                                        .font(.system(size: 15, weight: .medium)).foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity).frame(height: 52)
                                .background(Color(white: 0.12)).cornerRadius(13)
                                .overlay(RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color(white: 0.2), lineWidth: 1))
                            }
                        }
                        .padding(20)
                        .background(Color(white: 0.07)).cornerRadius(20)
                        .padding(.horizontal, 20)

                        // Sign Up link
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .font(.system(size: 14)).foregroundColor(Color(white: 0.45))
                            NavigationLink(destination:
                                SignUpScreen().environmentObject(appState)
                            ) {
                                Text("Sign Up")
                                    .font(.system(size: 14, weight: .semibold)).foregroundColor(.white)
                            }
                        }
                        .padding(.top, 24).padding(.bottom, 40)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }

    // ── Firebase Login ──────────────────────────────────────────
    private func login() {
        withAnimation { showError = false }

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showErr("Please enter your email address."); return
        }
        guard !password.isEmpty else {
            showErr("Please enter your password."); return
        }

        isLoading = true
        Auth.auth().signIn(
            withEmail: email.trimmingCharacters(in: .whitespaces),
            password: password
        ) { _, error in
            isLoading = false
            if let error = error {
                showErr(loginMsg(error))
                return
            }
            withAnimation { appState.screen = .onboarding }
        }
    }

    private func showErr(_ msg: String) {
        errorMessage = msg
        withAnimation(.spring(response: 0.3)) { showError = true }
    }

    private func loginMsg(_ error: Error) -> String {
        let code = AuthErrorCode(_bridgedNSError: error as NSError)?.code
        switch code {
        case .wrongPassword:     return "Wrong password. Please try again."
        case .invalidEmail:      return "Invalid email address."
        case .userNotFound:      return "No account found. Please sign up first."
        case .userDisabled:      return "This account has been disabled."
        case .tooManyRequests:   return "Too many attempts. Try again later."
        case .networkError:      return "Network error. Check your connection."
        case .invalidCredential: return "Wrong email or password. Please try again."
        default:                 return "Login failed. Please check your credentials."
        }
    }

    @ViewBuilder
    func loginField(_ label: String, icon: String, text: Binding<String>,
                    secure: Bool, show: Binding<Bool>, showToggle: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.system(size: 13, weight: .medium)).foregroundColor(Color(white: 0.5))
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(Color(white: 0.4)).font(.system(size: 15))
                Group {
                    if secure {
                        SecureField("", text: text)
                    } else {
                        TextField("", text: text)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                }
                .foregroundColor(.white)
                if showToggle {
                    Button { show.wrappedValue.toggle() } label: {
                        Image(systemName: show.wrappedValue ? "eye.slash" : "eye")
                            .foregroundColor(Color(white: 0.35)).font(.system(size: 15))
                    }
                }
            }
            .padding(.horizontal, 16).padding(.vertical, 14)
            .background(Color(white: 0.1)).cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
        }
    }
}

// ─────────────────────────────────────────────
// MARK: - OnboardingScreen
// ─────────────────────────────────────────────
struct OnboardingScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var step = 0

    private let steps: [(title: String, body: String, icon: String)] = [
        ("Discover events\nhappening around\ncampus",
         "Never miss a workshop, fest, or club activity. Everything in one feed.",
         "calendar.badge.clock"),
        ("Join clubs &\nstay connected",
         "Follow your favourite clubs and get instant updates on meetings and events.",
         "person.3.fill"),
        ("RSVP with\none tap",
         "Save events, RSVP instantly and get reminders so you never miss out.",
         "bookmark.fill")
    ]

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 0) {

                HStack {
                    Text("CampusHub").font(.system(size: 20, weight: .bold)).foregroundColor(.white)
                    Spacer()
                    Button { appState.screen = .main } label: {
                        Text("Skip").font(.system(size: 14)).foregroundColor(Color(white: 0.5))
                    }
                }
                .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 20)

                HStack(spacing: 28) {
                    ForEach([("mic.fill","Events"),("building.columns.fill","Clubs"),
                             ("paintpalette.fill","Arts")], id: \.0) { item in
                        VStack(spacing: 6) {
                            Image(systemName: item.0).font(.system(size: 22)).foregroundColor(.white)
                            Text(item.1).font(.system(size: 11)).foregroundColor(Color(white: 0.5))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20).padding(.bottom, 20)

                Divider().background(Color(white: 0.2)).padding(.horizontal, 20)

                VStack(alignment: .leading, spacing: 0) {
                    Text("STEP \(step + 1) OF \(steps.count)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(white: 0.5)).padding(.bottom, 16)

                    Image(systemName: steps[step].icon)
                        .font(.system(size: 32)).foregroundColor(.white).padding(.bottom, 16)

                    Text(steps[step].title)
                        .font(.system(size: 22, weight: .bold)).foregroundColor(.white).padding(.bottom, 12)

                    Text(steps[step].body)
                        .font(.system(size: 14)).foregroundColor(Color(white: 0.55))
                        .lineSpacing(4).padding(.bottom, 32)

                    HStack(spacing: 8) {
                        ForEach(0..<steps.count, id: \.self) { i in
                            Capsule()
                                .fill(i == step ? Color.white : Color(white: 0.3))
                                .frame(width: i == step ? 24 : 8, height: 8)
                                .animation(.spring(response: 0.3), value: step)
                        }
                        Spacer()
                        Button {
                            if step < steps.count - 1 { step += 1 }
                            else { appState.screen = .main }
                        } label: {
                            HStack(spacing: 6) {
                                Text(step == steps.count - 1 ? "Start" : "Next")
                                    .font(.system(size: 15, weight: .semibold))
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 24).padding(.vertical, 14)
                            .background(Color.white).cornerRadius(12)
                        }
                    }
                }
                .padding(20)
                .background(Color(white: 0.07)).cornerRadius(20)
                .padding(.horizontal, 20).padding(.top, 20)

                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

// ─────────────────────────────────────────────
// MARK: - MainTabView
// ─────────────────────────────────────────────
struct MainTabView: View {
    @EnvironmentObject var store:    UserProfileStore
    @EnvironmentObject var appState: AppState
    @State private var selectedTab = "home"

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()
            Group {
                switch selectedTab {
                case "home":
                    HomeFeedScreen(selectedTab: $selectedTab).environmentObject(store)
                case "clubs":
                    ClubsScreen(selectedTab: $selectedTab).environmentObject(store)
                case "calendar":
                    EventCalendarScreen(selectedTab: $selectedTab).environmentObject(store)
                case "bookmarks":
                    BookmarksScreen(selectedTab: $selectedTab).environmentObject(store)
                default:
                    ProfileScreen(selectedTab: $selectedTab)
                        .environmentObject(store).environmentObject(appState)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            BottomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
