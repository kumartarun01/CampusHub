//import SwiftUI
//
//struct OnboardingScreen: View {
//    @State private var currentStep = 0
//    @State private var goToHome = false
//    let totalSteps = 3
//
//    var body: some View {
//        NavigationStack{
//            ZStack {
//                Color.black.ignoresSafeArea()
//
//                VStack(spacing: 0) {
//                    // Top bar
//                    HStack {
//                        Text("CampusHub")
//                            .font(.system(size: 20, weight: .bold))
//                            .foregroundColor(.white)
//                        Spacer()
//                        ZStack(alignment: .topTrailing) {
//                            Image(systemName: "bell.fill")
//                                .foregroundColor(.white)
//                                .font(.system(size: 20))
//                            Circle()
//                                .fill(Color.red)
//                                .frame(width: 8, height: 8)
//                                .offset(x: 2, y: -2)
//                        }
//                    }
//                    .padding(.horizontal, 20)
//                    .padding(.top, 12)
//                    .padding(.bottom, 4)
//
//                    Text("Welcome back seeeeage")
//                        .font(.system(size: 13))
//                        .foregroundColor(Color(white: 0.5))
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 20)
//                        .padding(.bottom, 16)
//
//                    // Category icons
//                    HStack(spacing: 32) {
//                        VStack(spacing: 6) {
//                            Image(systemName: "mic.fill")
//                                .font(.system(size: 22))
//                                .foregroundColor(.white)
//                            Text("Events")
//                                .font(.system(size: 11))
//                                .foregroundColor(Color(white: 0.5))
//                        }
//                        VStack(spacing: 6) {
//                            Image(systemName: "building.columns.fill")
//                                .font(.system(size: 22))
//                                .foregroundColor(.white)
//                            Text("Clubs")
//                                .font(.system(size: 11))
//                                .foregroundColor(Color(white: 0.5))
//                        }
//                        VStack(spacing: 6) {
//                            Image(systemName: "paintpalette.fill")
//                                .font(.system(size: 22))
//                                .foregroundColor(.white)
//                            Text("Arts")
//                                .font(.system(size: 11))
//                                .foregroundColor(Color(white: 0.5))
//                        }
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 20)
//
//                    Divider().background(Color(white: 0.2)).padding(.horizontal, 20)
//
//                    // Onboarding card
//                    VStack(alignment: .leading, spacing: 0) {
//                        Text("STEP \(currentStep + 1) OF \(totalSteps)")
//                            .font(.system(size: 12, weight: .semibold))
//                            .foregroundColor(Color(white: 0.5))
//                            .padding(.bottom, 12)
//
//                        Text("Discover events\nhappening around\ncampus")
//                            .font(.system(size: 22, weight: .bold))
//                            .foregroundColor(.white)
//                            .padding(.bottom, 14)
//
//                        Text("Never miss a workshop, fest, or club activity. Everything in one feed.")
//                            .font(.system(size: 14))
//                            .foregroundColor(Color(white: 0.55))
//                            .lineSpacing(4)
//                            .padding(.bottom, 32)
//
//                        // Progress dots
//                        HStack(spacing: 8) {
//                            ForEach(0..<totalSteps, id: \.self) { i in
//                                Capsule()
//                                    .fill(i == currentStep ? Color.white : Color(white: 0.3))
//                                    .frame(width: i == currentStep ? 24 : 8, height: 8)
//                            }
//                            Spacer()
//                            Button(action: {
//                                if currentStep < totalSteps - 1 {
//                                    currentStep += 1
//                                } else {
//                                    goToHome = true   // 👈 FINAL STEP → NAVIGATE
//                                }
//                            }) {
//                                HStack(spacing: 6) {
//                                    Text("Next")
//                                        .font(.system(size: 15, weight: .semibold))
//                                    Image(systemName: "chevron.right")
//                                        .font(.system(size: 13, weight: .semibold))
//                                }
//                                .foregroundColor(.black)
//                                .padding(.horizontal, 24)
//                                .padding(.vertical, 14)
//                                .background(Color.white)
//                                .cornerRadius(12)
//                            }
//                        }
//                        .padding(.bottom, 20)
//
//                        Text("Screen \(currentStep + 1) —")
//                            .font(.system(size: 13))
//                            .foregroundColor(Color(white: 0.4))
//                    }
//                    .padding(20)
//                    .background(Color(white: 0.07))
//                    .cornerRadius(20)
//                    .padding(.horizontal, 20)
//                    .padding(.top, 20)
//
//                    Spacer()
//                    
//                    NavigationLink(
//                        destination: HomeFeedScreen(),
//                        isActive: $goToHome
//                    ) {
//                        EmptyView()
//                    }
//
//
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    OnboardingScreen()
//}


import SwiftUI

// ─────────────────────────────────────────────
// MARK: - OnboardingScreen
// ─────────────────────────────────────────────
struct OnboardingScreen: View {
    @State private var currentStep = 0
    let totalSteps = 3

    private let steps: [(title: String, body: String, icon: String)] = [
        (
            title: "Discover events\nhappening around\ncampus",
            body:  "Never miss a workshop, fest, or club activity. Everything in one feed.",
            icon:  "calendar.badge.clock"
        ),
        (
            title: "Join clubs &\nstay connected",
            body:  "Follow your favourite clubs and get instant updates on meetings and events.",
            icon:  "person.3.fill"
        ),
        (
            title: "RSVP with\none tap",
            body:  "Save events, RSVP instantly and get reminders so you never miss out.",
            icon:  "bookmark.fill"
        )
    ]

    var body: some View {
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

                Text("Welcome back")
                    .font(.system(size: 13))
                    .foregroundColor(Color(white: 0.5))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)

                // Icon row
                HStack(spacing: 32) {
                    ForEach([("mic.fill","Events"),("building.columns.fill","Clubs"),("paintpalette.fill","Arts")], id: \.0) { item in
                        VStack(spacing: 6) {
                            Image(systemName: item.0)
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            Text(item.1)
                                .font(.system(size: 11))
                                .foregroundColor(Color(white: 0.5))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                Divider().background(Color(white: 0.2)).padding(.horizontal, 20)

                // Step card
                VStack(alignment: .leading, spacing: 0) {
                    // Step indicator
                    Text("STEP \(currentStep + 1) OF \(totalSteps)")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(white: 0.5))
                        .padding(.bottom, 16)

                    // Icon
                    Image(systemName: steps[currentStep].icon)
                        .font(.system(size: 32))
                        .foregroundColor(.white)
                        .padding(.bottom, 16)

                    // Title
                    Text(steps[currentStep].title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 12)

                    // Body
                    Text(steps[currentStep].body)
                        .font(.system(size: 14))
                        .foregroundColor(Color(white: 0.55))
                        .lineSpacing(4)
                        .padding(.bottom, 32)

                    // Progress dots + Next button
                    HStack(spacing: 8) {
                        ForEach(0..<totalSteps, id: \.self) { i in
                            Capsule()
                                .fill(i == currentStep ? Color.white : Color(white: 0.3))
                                .frame(width: i == currentStep ? 24 : 8, height: 8)
                                .animation(.spring(response: 0.3), value: currentStep)
                        }
                        Spacer()
                        Button {
                            withAnimation { currentStep = min(currentStep + 1, totalSteps - 1) }
                        } label: {
                            HStack(spacing: 6) {
                                Text("Next")
                                    .font(.system(size: 15, weight: .semibold))
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 13, weight: .semibold))
                            }
                            .foregroundColor(.black)
                            .padding(.horizontal, 24).padding(.vertical, 14)
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
            }
        }
    }
}

#Preview { OnboardingScreen() }
