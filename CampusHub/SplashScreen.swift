import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // App Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(white: 0.18))
                        .frame(width: 90, height: 90)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: 44, height: 44)
                }
                .padding(.bottom, 28)

                // Title
                Text("CampusHub")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)

                // Subtitle
                Text("Your campus. All\nin one place.")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color(white: 0.6))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 28)

                // Dots
                HStack(spacing: 8) {
                    Circle().fill(Color.white).frame(width: 8, height: 8)
                    Circle().fill(Color(white: 0.4)).frame(width: 8, height: 8)
                    Circle().fill(Color(white: 0.4)).frame(width: 8, height: 8)
                }
                .padding(.bottom, 60)

                Spacer()

                // Get Started Button
                Button(action: {}) {
                    Text("Get Started")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)

                // Already have account
                Button(action: {}) {
                    Text("Already have account?")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color(white: 0.5))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(white: 0.12))
                        .cornerRadius(14)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
