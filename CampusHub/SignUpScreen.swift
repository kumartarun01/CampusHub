import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpScreen: View {
    @EnvironmentObject var appState: AppState

    @State private var fullName        = ""
    @State private var email           = ""
    @State private var password        = ""
    @State private var confirmPassword = ""
    @State private var showPassword    = false
    @State private var agreeTerms      = false
    @State private var isLoading       = false
    @State private var errorMessage    = ""
    @State private var showError       = false
    @State private var showSuccess     = false   // ✅ success toast

    var passwordStrength: Int {
        var s = 0
        if password.count >= 8                                    { s += 1 }
        if password.contains(where: { $0.isUppercase })          { s += 1 }
        if password.contains(where: { $0.isNumber })             { s += 1 }
        if password.contains(where: { "!@#$%^&*".contains($0) }){ s += 1 }
        return s
    }
    var strengthColor: Color {
        switch passwordStrength {
        case 1: return .red
        case 2: return .orange
        case 3: return Color(red: 0.9, green: 0.7, blue: 0.0)
        case 4: return .green
        default: return Color(white: 0.2)
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // Logo
                    VStack(spacing: 12) {
                        CampusHubLogo(size: 72)
                        Text("Create Account")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        Text("Join your campus community")
                            .font(.system(size: 15))
                            .foregroundColor(Color(white: 0.5))
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 32)

                    // Form
                    VStack(spacing: 14) {

                        InputField(icon: "person",    placeholder: "Full name",
                                   label: "Full Name",        text: $fullName,
                                   isSecure: false, showToggle: false, showPassword: .constant(false))

                        InputField(icon: "envelope",  placeholder: "you@university.edu",
                                   label: "University Email", text: $email,
                                   isSecure: false, showToggle: false, showPassword: .constant(false))

                        InputField(icon: "lock",      placeholder: "Min. 8 characters",
                                   label: "Password",          text: $password,
                                   isSecure: !showPassword, showToggle: true, showPassword: $showPassword)

                        InputField(icon: "lock.fill", placeholder: "Repeat password",
                                   label: "Confirm Password",  text: $confirmPassword,
                                   isSecure: !showPassword, showToggle: false, showPassword: .constant(false))

                        // Password strength bar
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Password Strength")
                                .font(.system(size: 12))
                                .foregroundColor(Color(white: 0.4))
                            HStack(spacing: 4) {
                                ForEach(0..<4) { i in
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(i < passwordStrength ? strengthColor : Color(white: 0.2))
                                        .frame(height: 4)
                                        .animation(.easeInOut(duration: 0.2), value: passwordStrength)
                                }
                            }
                        }
                        .padding(.top, 2)

                        // Error banner
                        if showError {
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red).font(.system(size: 13))
                                Text(errorMessage)
                                    .font(.system(size: 13)).foregroundColor(.red)
                                Spacer()
                            }
                            .padding(12)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red.opacity(0.3), lineWidth: 1))
                            .transition(.opacity)
                        }

                        // Terms checkbox
                        HStack(alignment: .top, spacing: 10) {
                            Button(action: { agreeTerms.toggle() }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(agreeTerms ? Color.white : Color.clear)
                                        .frame(width: 20, height: 20)
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color(white: 0.35), lineWidth: 1.5)
                                        .frame(width: 20, height: 20)
                                    if agreeTerms {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            (Text("I agree to the ")
                                .font(.system(size: 13)).foregroundColor(Color(white: 0.45))
                            + Text("Terms of Service")
                                .font(.system(size: 13, weight: .semibold)).foregroundColor(.white)
                            + Text(" and ")
                                .font(.system(size: 13)).foregroundColor(Color(white: 0.45))
                            + Text("Privacy Policy")
                                .font(.system(size: 13, weight: .semibold)).foregroundColor(.white))
                        }
                        .padding(.top, 6)

                        // Create Account button
                        Button(action: signUp) {
                            ZStack {
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                } else {
                                    Text("Create Account")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                }
                            }
                            .frame(maxWidth: .infinity).frame(height: 52)
                            .background(agreeTerms ? Color.white : Color(white: 0.3))
                            .cornerRadius(13)
                        }
                        .disabled(!agreeTerms || isLoading)
                        .padding(.top, 8)

                        HStack(spacing: 12) {
                            Rectangle().fill(Color(white: 0.2)).frame(height: 1)
                            Text("or").font(.system(size: 13)).foregroundColor(Color(white: 0.35))
                            Rectangle().fill(Color(white: 0.2)).frame(height: 1)
                        }

                        Button(action: {}) {
                            HStack(spacing: 10) {
                                Image(systemName: "globe").font(.system(size: 16)).foregroundColor(.white)
                                Text("Sign up with Google")
                                    .font(.system(size: 15, weight: .medium)).foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity).frame(height: 52)
                            .background(Color(white: 0.1)).cornerRadius(13)
                            .overlay(RoundedRectangle(cornerRadius: 13)
                                .stroke(Color(white: 0.2), lineWidth: 1))
                        }
                    }
                    .padding(20)
                    .background(Color(white: 0.07)).cornerRadius(20)
                    .padding(.horizontal, 20)

                    // ✅ Clickable "Log In" — navigates to Login screen
                    HStack(spacing: 4) {
                        Text("Already have an account?")
                            .font(.system(size: 14)).foregroundColor(Color(white: 0.45))
                        Button(action: { appState.screen = .login }) {
                            Text("Log In")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                    .padding(.top, 24).padding(.bottom, 40)
                }
            }

            // ✅ Account Created Successfully toast — appears at top
            if showSuccess {
                VStack {
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color(red: 0.2, green: 0.8, blue: 0.4))
                            .font(.system(size: 18))
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Account Created Successfully!")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                            Text("Redirecting to login…")
                                .font(.system(size: 12))
                                .foregroundColor(Color(white: 0.55))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16).padding(.vertical, 14)
                    .background(Color(white: 0.12))
                    .cornerRadius(14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(red: 0.2, green: 0.8, blue: 0.4).opacity(0.4), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 60)
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
                .animation(.spring(response: 0.4), value: showSuccess)
                .zIndex(10)
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: – Firebase Sign Up → Firestore
    private func signUp() {
        withAnimation { showError = false }

        guard !fullName.trimmingCharacters(in: .whitespaces).isEmpty else {
            showErr("Please enter your full name."); return
        }
        guard email.contains("@") && email.contains(".") else {
            showErr("Please enter a valid email address."); return
        }
        guard password.count >= 8 else {
            showErr("Password must be at least 8 characters."); return
        }
        guard password == confirmPassword else {
            showErr("Passwords don't match. Please try again."); return
        }

        isLoading = true

        Auth.auth().createUser(
            withEmail: email.trimmingCharacters(in: .whitespaces),
            password: password
        ) { result, error in
            if let error = error {
                isLoading = false
                showErr(firebaseMsg(error))
                return
            }
            guard let user = result?.user else {
                isLoading = false
                showErr("Something went wrong. Please try again.")
                return
            }

            let cleanName  = fullName.trimmingCharacters(in: .whitespaces)
            let cleanEmail = email.lowercased().trimmingCharacters(in: .whitespaces)

            // ✅ Save signup data to Firestore (users collection)
            Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .setData([
                    "uid":             user.uid,
                    "fullName":        cleanName,
                    "email":           cleanEmail,
                    "department":      "",
                    "year":            "",
                    "bio":             "",
                    "interests":       [String](),
                    "createdAt":       Timestamp(date: Date()),
                    "profileComplete": false
                ]) { _ in
                    isLoading = false
                    // ✅ Show success toast, then go to login after 2s
                    withAnimation { showSuccess = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation { appState.screen = .login }
                    }
                }
        }
    }

    private func showErr(_ msg: String) {
        errorMessage = msg
        withAnimation { showError = true }
    }

    private func firebaseMsg(_ error: Error) -> String {
        let nsErr = error as NSError
        let code  = AuthErrorCode(rawValue: nsErr.code)
        switch code {
        case .emailAlreadyInUse: return "This email is already registered. Try logging in."
        case .invalidEmail:      return "Please enter a valid email address."
        case .weakPassword:      return "Password is too weak. Use at least 8 characters."
        case .networkError:      return "Network error. Please check your connection."
        default:                 return "Sign up failed. Please try again."
        }
    }
}

// MARK: – Reusable InputField
struct InputField: View {
    let icon: String
    let placeholder: String
    let label: String
    @Binding var text: String
    let isSecure: Bool
    let showToggle: Bool
    @Binding var showPassword: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(white: 0.5))
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(Color(white: 0.4))
                    .font(.system(size: 15)).frame(width: 18)
                if isSecure {
                    SecureField("", text: $text,
                                prompt: Text(placeholder).foregroundColor(Color(white: 0.3)))
                        .foregroundColor(.white)
                } else {
                    TextField("", text: $text,
                              prompt: Text(placeholder).foregroundColor(Color(white: 0.3)))
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        .keyboardType(icon == "envelope" ? .emailAddress : .default)
                }
                if showToggle {
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(Color(white: 0.35))
                            .font(.system(size: 15))
                    }
                }
            }
            .padding(.horizontal, 16).padding(.vertical, 14)
            .background(Color(white: 0.1)).cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12)
                .stroke(Color(white: 0.18), lineWidth: 1))
        }
    }
}

#Preview {
    SignUpScreen().environmentObject(AppState())
}
