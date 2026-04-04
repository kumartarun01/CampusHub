import SwiftUI

struct OnboardingScreen: View {
    @State private var currentStep = 0
    @State private var goToHome = false
    let totalSteps = 3

    var body: some View {
        NavigationStack{
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Top bar
                    HStack {
                        Text("CampusHub")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            Circle()
                                .fill(Color.red)
                                .frame(width: 8, height: 8)
                                .offset(x: 2, y: -2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 4)

                    Text("Welcome back seeeeage")
                        .font(.system(size: 13))
                        .foregroundColor(Color(white: 0.5))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 16)

                    // Category icons
                    HStack(spacing: 32) {
                        VStack(spacing: 6) {
                            Image(systemName: "mic.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text("Events")
                                .font(.system(size: 11))
                                .foregroundColor(Color(white: 0.5))
                        }
                        VStack(spacing: 6) {
                            Image(systemName: "building.columns.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text("Clubs")
                                .font(.system(size: 11))
                                .foregroundColor(Color(white: 0.5))
                        }
                        VStack(spacing: 6) {
                            Image(systemName: "paintpalette.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text("Arts")
                                .font(.system(size: 11))
                                .foregroundColor(Color(white: 0.5))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)

                    Divider().background(Color(white: 0.2)).padding(.horizontal, 20)

                    // Onboarding card
                    VStack(alignment: .leading, spacing: 0) {
                        Text("STEP \(currentStep + 1) OF \(totalSteps)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color(white: 0.5))
                            .padding(.bottom, 12)

                        Text("Discover events\nhappening around\ncampus")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 14)

                        Text("Never miss a workshop, fest, or club activity. Everything in one feed.")
                            .font(.system(size: 14))
                            .foregroundColor(Color(white: 0.55))
                            .lineSpacing(4)
                            .padding(.bottom, 32)

                        // Progress dots
                        HStack(spacing: 8) {
                            ForEach(0..<totalSteps, id: \.self) { i in
                                Capsule()
                                    .fill(i == currentStep ? Color.white : Color(white: 0.3))
                                    .frame(width: i == currentStep ? 24 : 8, height: 8)
                            }
                            Spacer()
                            Button(action: {
                                if currentStep < totalSteps - 1 {
                                    currentStep += 1
                                } else {
                                    goToHome = true   // 👈 FINAL STEP → NAVIGATE
                                }
                            }) {
                                HStack(spacing: 6) {
                                    Text("Next")
                                        .font(.system(size: 15, weight: .semibold))
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 13, weight: .semibold))
                                }
                                .foregroundColor(.black)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 14)
                                .background(Color.white)
                                .cornerRadius(12)
                            }
                        }
                        .padding(.bottom, 20)

                        Text("Screen \(currentStep + 1) —")
                            .font(.system(size: 13))
                            .foregroundColor(Color(white: 0.4))
                    }
                    .padding(20)
                    .background(Color(white: 0.07))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                    Spacer()
                    
                    NavigationLink(
                        destination: HomeScreen(),
                        isActive: $goToHome
                    ) {
                        EmptyView()
                    }


                }
            }
        }
    }
}

#Preview {
    OnboardingScreen()
}
