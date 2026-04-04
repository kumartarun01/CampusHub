import SwiftUI

struct SignUpScreen: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var agreeTerms = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header
                        VStack(spacing: 10) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(white: 0.18))
                                    .frame(width: 72, height: 72)
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white, lineWidth: 2.5)
                                    .frame(width: 36, height: 36)
                            }

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

                            // Full Name
                            InputField(
                                icon: "person",
                                placeholder: "Full name",
                                label: "Full Name",
                                text: $fullName,
                                isSecure: false,
                                showToggle: false,
                                showPassword: .constant(false)
                            )

                            // Email
                            InputField(
                                icon: "envelope",
                                placeholder: "you@university.edu",
                                label: "University Email",
                                text: $email,
                                isSecure: false,
                                showToggle: false,
                                showPassword: .constant(false)
                            )

                            // Password
                            InputField(
                                icon: "lock",
                                placeholder: "Min. 8 characters",
                                label: "Password",
                                text: $password,
                                isSecure: !showPassword,
                                showToggle: true,
                                showPassword: $showPassword
                            )

                            // Confirm Password
                            InputField(
                                icon: "lock.fill",
                                placeholder: "Repeat password",
                                label: "Confirm Password",
                                text: $confirmPassword,
                                isSecure: !showPassword,
                                showToggle: false,
                                showPassword: .constant(false)
                            )

                            // Password strength indicator
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Password Strength")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color(white: 0.4))
                                HStack(spacing: 4) {
                                    ForEach(0..<4) { i in
                                        RoundedRectangle(cornerRadius: 3)
                                            .fill(i < 2 ? Color.white : Color(white: 0.2))
                                            .frame(height: 4)
                                    }
                                }
                            }
                            .padding(.top, 2)

                            // Terms
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
                                Text("I agree to the ")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(white: 0.45))
                                + Text("Terms of Service")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white)
                                + Text(" and ")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(white: 0.45))
                                + Text("Privacy Policy")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .padding(.top, 6)

                            // Sign Up button
//                            Button(action: {}) {
//                                Text("Create Account")
//                                    .font(.system(size: 16, weight: .semibold))
//                                    .foregroundColor(.black)
//                                    .frame(maxWidth: .infinity)
//                                    .frame(height: 52)
//                                    .background(agreeTerms ? Color.white : Color(white: 0.3))
//                                    .cornerRadius(13)
//                            }
                            NavigationLink(destination: OnboardingScreen()) {
                                
                                    Text("Create Account")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 52)
                                        .background(agreeTerms ? Color.white : Color(white: 0.3))
                                        .cornerRadius(13)
                                
                            }
                            .disabled(!agreeTerms)
                            .padding(.top, 8)

                            // Divider
                            HStack(spacing: 12) {
                                Rectangle().fill(Color(white: 0.2)).frame(height: 1)
                                Text("or")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(white: 0.35))
                                Rectangle().fill(Color(white: 0.2)).frame(height: 1)
                            }

                            // Google
                            Button(action: {}) {
                                HStack(spacing: 10) {
                                    Image(systemName: "globe")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                    Text("Sign up with Google")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color(white: 0.1))
                                .cornerRadius(13)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 13)
                                        .stroke(Color(white: 0.2), lineWidth: 1)
                                )
                            }
                        }
                        .padding(20)
                        .background(Color(white: 0.07))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)

                        // Login link
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .font(.system(size: 14))
                                .foregroundColor(Color(white: 0.45))
                            //                            Button(action: {}) {
                            //                                Text("Log In")
                            //                                    .font(.system(size: 14, weight: .semibold))
                            //                                    .foregroundColor(.white)
                            //                            }
                            NavigationLink(destination: LoginScreen()) {
                                Text("Log In")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                                
                            }
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
}

// Reusable input field component
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
                    .font(.system(size: 15))
                    .frame(width: 18)

                if isSecure {
                    SecureField("", text: $text, prompt: Text(placeholder)
                        .foregroundColor(Color(white: 0.3)))
                        .foregroundColor(.white)
                } else {
                    TextField("", text: $text, prompt: Text(placeholder)
                        .foregroundColor(Color(white: 0.3)))
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                }

                if showToggle {
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(Color(white: 0.35))
                            .font(.system(size: 15))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color(white: 0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(white: 0.18), lineWidth: 1)
            )
        }
    }
}

#Preview {
    SignUpScreen()
}
