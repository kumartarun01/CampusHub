import SwiftUI

struct LoginScreen: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Top logo area
                        VStack(spacing: 14) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(white: 0.18))
                                    .frame(width: 72, height: 72)
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white, lineWidth: 2.5)
                                    .frame(width: 36, height: 36)
                            }

                            Text("CampusHub")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)

                            Text("Welcome back 👋")
                                .font(.system(size: 15))
                                .foregroundColor(Color(white: 0.5))
                        }
                        .padding(.top, 60)
                        .padding(.bottom, 40)

                        // Form card
                        VStack(spacing: 16) {
                            // Email
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(Color(white: 0.5))
                                HStack(spacing: 12) {
                                    Image(systemName: "envelope")
                                        .foregroundColor(Color(white: 0.4))
                                        .font(.system(size: 15))
                                    TextField("", text: $email, prompt: Text("you@university.edu")
                                        .foregroundColor(Color(white: 0.3)))
                                        .foregroundColor(.white)
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
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

                            // Password
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(Color(white: 0.5))
                                HStack(spacing: 12) {
                                    Image(systemName: "lock")
                                        .foregroundColor(Color(white: 0.4))
                                        .font(.system(size: 15))
                                    Group {
                                        if showPassword {
                                            TextField("", text: $password, prompt: Text("••••••••")
                                                .foregroundColor(Color(white: 0.3)))
                                        } else {
                                            SecureField("", text: $password, prompt: Text("••••••••")
                                                .foregroundColor(Color(white: 0.3)))
                                        }
                                    }
                                    .foregroundColor(.white)
                                    Button(action: { showPassword.toggle() }) {
                                        Image(systemName: showPassword ? "eye.slash" : "eye")
                                            .foregroundColor(Color(white: 0.35))
                                            .font(.system(size: 15))
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

                            // Forgot password
                            HStack {
                                Spacer()
//                                Button(action: {}) {
//                                    Text("Forgot Password?")
//                                        .font(.system(size: 13, weight: .medium))
//                                        .foregroundColor(Color(white: 0.55))
//                                }
                                NavigationLink(destination: ForgotPasswordScreen()) {
                                    Text("Forgot Password?")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(Color(white: 0.55))
                                }
                            }
                            .padding(.top, 2)

                            // Login button
//                            Button(action: {}) {
//                                Text("Log In")
//                                    .font(.system(size: 16, weight: .semibold))
//                                    .foregroundColor(.black)
//                                    .frame(maxWidth: .infinity)
//                                    .frame(height: 52)
//                                    .background(Color.white)
//                                    .cornerRadius(13)
//                            }
                            
                            NavigationLink(destination: OnboardingScreen()) {
                                Text("Log In")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 52)
                                    .background(Color.white)
                            }
                            
                            .padding(.top, 8)

                            // Divider
                            HStack(spacing: 12) {
                                Rectangle().fill(Color(white: 0.2)).frame(height: 1)
                                Text("or")
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(white: 0.35))
                                Rectangle().fill(Color(white: 0.2)).frame(height: 1)
                            }
                            .padding(.vertical, 4)

                            // Google button
                            Button(action: {}) {
                                HStack(spacing: 10) {
                                    Image(systemName: "globe")
                                        .font(.system(size: 16))
                                        .foregroundColor(.white)
                                    Text("Continue with Google")
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(Color(white: 0.12))
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

                        // Sign up link
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                                .foregroundColor(Color(white: 0.45))
//                            Button(action: {}) {
//                                Text("Sign Up")
//                                    .font(.system(size: 14, weight: .semibold))
//                                    .foregroundColor(.white)
//                            }
                            NavigationLink(destination: SignUpScreen()) {
                                Text("Sign Up")
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
        .toolbar(.hidden)
    }
}

#Preview {
    LoginScreen()
}
