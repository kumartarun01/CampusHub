import SwiftUI

struct ForgotPasswordScreen: View {
    @State private var email = ""
    @State private var otpSent = false
    @State private var otp = ["", "", "", ""]
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var step = 1 // 1: email, 2: otp, 3: new password, 4: success
    @FocusState private var focusedField: Int?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // Back button
                HStack {
                    Button(action: {
                        if step > 1 { step -= 1 }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 15, weight: .semibold))
                            Text("Back")
                                .font(.system(size: 15))
                        }
                        .foregroundColor(Color(white: 0.6))
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 30)

                // Progress bar
                HStack(spacing: 6) {
                    ForEach(1...4, id: \.self) { i in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(i <= step ? Color.white : Color(white: 0.2))
                            .frame(height: 4)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 36)

                // Step content
                Group {
                    if step == 1 {
                        stepEmailView
                    } else if step == 2 {
                        stepOTPView
                    } else if step == 3 {
                        stepNewPasswordView
                    } else {
                        stepSuccessView
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
        }
    }

    // MARK: - Step 1: Email
    var stepEmailView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: "lock.rotation")
                .font(.system(size: 36))
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Text("Forgot Password?")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 10)

            Text("No worries! Enter your university email and we'll send you a reset link.")
                .font(.system(size: 14))
                .foregroundColor(Color(white: 0.5))
                .lineSpacing(4)
                .padding(.bottom, 32)

            VStack(alignment: .leading, spacing: 8) {
                Text("University Email")
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
            .padding(.bottom, 24)

            Button(action: { step = 2 }) {
                Text("Send Reset Code")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.white)
                    .cornerRadius(13)
            }
        }
    }

    // MARK: - Step 2: OTP
    var stepOTPView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: "message.fill")
                .font(.system(size: 36))
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Text("Check your email")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 10)

            Text("We sent a 4-digit code to\nyou@university.edu")
                .font(.system(size: 14))
                .foregroundColor(Color(white: 0.5))
                .lineSpacing(4)
                .padding(.bottom, 36)

            // OTP boxes
            HStack(spacing: 14) {
                ForEach(0..<4, id: \.self) { i in
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(white: 0.1))
                            .frame(width: 64, height: 64)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(otp[i].isEmpty ? Color(white: 0.18) : Color.white, lineWidth: 1.5)
                            )
                        Text(otp[i].isEmpty ? "·" : otp[i])
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(otp[i].isEmpty ? Color(white: 0.3) : .white)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom, 32)

            Button(action: { step = 3 }) {
                Text("Verify Code")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.white)
                    .cornerRadius(13)
            }
            .padding(.bottom, 20)

            HStack(spacing: 4) {
                Text("Didn't receive the code?")
                    .font(.system(size: 13))
                    .foregroundColor(Color(white: 0.4))
                Button(action: {}) {
                    Text("Resend")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }

    // MARK: - Step 3: New Password
    var stepNewPasswordView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: "lock.fill")
                .font(.system(size: 36))
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Text("New Password")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 10)

            Text("Create a strong new password for your CampusHub account.")
                .font(.system(size: 14))
                .foregroundColor(Color(white: 0.5))
                .lineSpacing(4)
                .padding(.bottom, 32)

            VStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("New Password")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color(white: 0.5))
                    HStack(spacing: 12) {
                        Image(systemName: "lock")
                            .foregroundColor(Color(white: 0.4))
                            .font(.system(size: 15))
                        SecureField("", text: $newPassword, prompt: Text("Min. 8 characters")
                            .foregroundColor(Color(white: 0.3)))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color(white: 0.1))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Confirm Password")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color(white: 0.5))
                    HStack(spacing: 12) {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(white: 0.4))
                            .font(.system(size: 15))
                        SecureField("", text: $confirmPassword, prompt: Text("Repeat password")
                            .foregroundColor(Color(white: 0.3)))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color(white: 0.1))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(white: 0.18), lineWidth: 1))
                }
            }
            .padding(.bottom, 24)

            Button(action: { step = 4 }) {
                Text("Update Password")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.white)
                    .cornerRadius(13)
            }
        }
    }

    // MARK: - Step 4: Success
    var stepSuccessView: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .fill(Color(white: 0.12))
                        .frame(width: 90, height: 90)
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                }

                Text("Password Updated!")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)

                Text("Your password has been reset successfully. You can now log in with your new password.")
                    .font(.system(size: 14))
                    .foregroundColor(Color(white: 0.5))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .padding(.horizontal, 20)
            }
            Spacer()

            Button(action: {}) {
                Text("Back to Login")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.white)
                    .cornerRadius(13)
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ForgotPasswordScreen()
}
