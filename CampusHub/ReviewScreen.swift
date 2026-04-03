import SwiftUI

struct ReviewScreen: View {
    @State private var selectedRating = 0
    @State private var hoveredRating = 0
    @State private var reviewText = ""
    @State private var selectedTags: Set<String> = []
    @State private var submitted = false

    let tags = ["Great Events", "Easy to Use", "Good Notifications", "Well Designed", "Helpful", "Fast & Smooth"]

    struct ExistingReview: Identifiable {
        let id = UUID()
        let initials: String
        let name: String
        let rating: Int
        let date: String
        let text: String
    }

    let reviews: [ExistingReview] = [
        ExistingReview(initials: "AK", name: "Arjun K.", rating: 5, date: "Mar 28, 2025", text: "Best app for staying updated on campus events. Never miss a thing now!"),
        ExistingReview(initials: "PR", name: "Priya R.", rating: 4, date: "Mar 22, 2025", text: "Super clean design and easy to navigate. Would love more club categories."),
        ExistingReview(initials: "SM", name: "Sahil M.", rating: 5, date: "Mar 15, 2025", text: "The RSVP feature is a game changer. Also love the calendar view!"),
        ExistingReview(initials: "NK", name: "Neha K.", rating: 4, date: "Mar 10, 2025", text: "Notifications are really helpful. Great work by the team.")
    ]

    var averageRating: Double {
        let total = reviews.reduce(0) { $0 + $1.rating }
        return Double(total) / Double(reviews.count)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if submitted {
                submittedView
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header
                        HStack {
                            Button(action: {}) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Text("Rate & Review")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.white)
                            Spacer()
                            Color.clear.frame(width: 24, height: 24)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 24)

                        // Rating summary card
                        VStack(spacing: 12) {
                            HStack(alignment: .bottom, spacing: 6) {
                                Text(String(format: "%.1f", averageRating))
                                    .font(.system(size: 52, weight: .bold))
                                    .foregroundColor(.white)
                                Text("/ 5")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(white: 0.35))
                                    .padding(.bottom, 8)
                            }

                            StarRow(rating: Int(averageRating.rounded()), size: 20, color: .white)

                            Text("Based on \(reviews.count) reviews")
                                .font(.system(size: 13))
                                .foregroundColor(Color(white: 0.4))

                            // Rating bars
                            VStack(spacing: 6) {
                                ForEach([5, 4, 3, 2, 1], id: \.self) { star in
                                    let count = reviews.filter { $0.rating == star }.count
                                    let fraction = reviews.isEmpty ? 0.0 : CGFloat(count) / CGFloat(reviews.count)

                                    HStack(spacing: 10) {
                                        Text("\(star)")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(white: 0.4))
                                            .frame(width: 12)

                                        GeometryReader { geo in
                                            ZStack(alignment: .leading) {
                                                RoundedRectangle(cornerRadius: 3)
                                                    .fill(Color(white: 0.12))
                                                RoundedRectangle(cornerRadius: 3)
                                                    .fill(Color.white)
                                                    .frame(width: geo.size.width * fraction)
                                            }
                                        }
                                        .frame(height: 6)

                                        Text("\(count)")
                                            .font(.system(size: 11))
                                            .foregroundColor(Color(white: 0.35))
                                            .frame(width: 16, alignment: .trailing)
                                    }
                                }
                            }
                            .padding(.top, 8)
                        }
                        .padding(20)
                        .background(Color(white: 0.07))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)

                        // Write review section
                        VStack(alignment: .leading, spacing: 0) {
                            Text("WRITE A REVIEW")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(Color(white: 0.35))
                                .padding(.horizontal, 20)
                                .padding(.bottom, 14)

                            VStack(alignment: .leading, spacing: 20) {
                                // Star picker
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Your Rating")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(Color(white: 0.5))

                                    HStack(spacing: 10) {
                                        ForEach(1...5, id: \.self) { star in
                                            Button(action: { selectedRating = star }) {
                                                Image(systemName: star <= selectedRating ? "star.fill" : "star")
                                                    .font(.system(size: 32))
                                                    .foregroundColor(star <= selectedRating ? .white : Color(white: 0.25))
                                            }
                                        }
                                    }
                                }

                                // Quick tags
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("What did you like?")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(Color(white: 0.5))

                                    FlowLayout(items: tags, spacing: 8)
                                        .overlay(
                                            // Overlay tap areas for each chip
                                            GeometryReader { _ in
                                                Color.clear
                                            }
                                        )

                                    // Interactive chips
                                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                                        ForEach(tags, id: \.self) { tag in
                                            Button(action: {
                                                if selectedTags.contains(tag) {
                                                    selectedTags.remove(tag)
                                                } else {
                                                    selectedTags.insert(tag)
                                                }
                                            }) {
                                                Text(tag)
                                                    .font(.system(size: 12, weight: .medium))
                                                    .foregroundColor(selectedTags.contains(tag) ? .black : .white)
                                                    .padding(.horizontal, 14)
                                                    .padding(.vertical, 8)
                                                    .frame(maxWidth: .infinity)
                                                    .background(selectedTags.contains(tag) ? Color.white : Color(white: 0.12))
                                                    .cornerRadius(10)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(selectedTags.contains(tag) ? Color.clear : Color(white: 0.2), lineWidth: 1)
                                                    )
                                            }
                                        }
                                    }
                                }

                                // Text box
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Your Review (optional)")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(Color(white: 0.5))

                                    ZStack(alignment: .topLeading) {
                                        if reviewText.isEmpty {
                                            Text("Tell us what you think about CampusHub...")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color(white: 0.3))
                                                .padding(.horizontal, 14)
                                                .padding(.top, 14)
                                        }
                                        TextEditor(text: $reviewText)
                                            .foregroundColor(.white)
                                            .font(.system(size: 14))
                                            .scrollContentBackground(.hidden)
                                            .background(Color.clear)
                                            .padding(10)
                                            .frame(height: 110)
                                    }
                                    .background(Color(white: 0.1))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(white: 0.18), lineWidth: 1)
                                    )

                                    HStack {
                                        Spacer()
                                        Text("\(reviewText.count)/300")
                                            .font(.system(size: 11))
                                            .foregroundColor(Color(white: 0.3))
                                    }
                                }

                                // Submit button
                                Button(action: {
                                    if selectedRating > 0 {
                                        withAnimation { submitted = true }
                                    }
                                }) {
                                    Text("Submit Review")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 52)
                                        .background(selectedRating > 0 ? Color.white : Color(white: 0.25))
                                        .cornerRadius(13)
                                }
                                .disabled(selectedRating == 0)
                            }
                            .padding(20)
                            .background(Color(white: 0.07))
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 28)

                        // Existing reviews
                        VStack(alignment: .leading, spacing: 14) {
                            Text("RECENT REVIEWS")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(Color(white: 0.35))
                                .padding(.horizontal, 20)

                            VStack(spacing: 0) {
                                ForEach(reviews) { review in
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack(spacing: 10) {
                                            ZStack {
                                                Circle().fill(Color(white: 0.15)).frame(width: 38, height: 38)
                                                Text(review.initials)
                                                    .font(.system(size: 13, weight: .bold))
                                                    .foregroundColor(.white)
                                            }
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(review.name)
                                                    .font(.system(size: 14, weight: .semibold))
                                                    .foregroundColor(.white)
                                                Text(review.date)
                                                    .font(.system(size: 11))
                                                    .foregroundColor(Color(white: 0.35))
                                            }
                                            Spacer()
                                            StarRow(rating: review.rating, size: 12, color: .white)
                                        }
                                        Text(review.text)
                                            .font(.system(size: 13))
                                            .foregroundColor(Color(white: 0.5))
                                            .lineSpacing(3)
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 16)

                                    if review.id != reviews.last?.id {
                                        Divider().background(Color(white: 0.1)).padding(.horizontal, 20)
                                    }
                                }
                            }
                            .background(Color(white: 0.07))
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }

    var submittedView: some View {
        VStack(spacing: 24) {
            Spacer()
            ZStack {
                Circle().fill(Color(white: 0.1)).frame(width: 100, height: 100)
                Image(systemName: "star.fill")
                    .font(.system(size: 44))
                    .foregroundColor(.white)
            }

            Text("Thank You! 🎉")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)

            StarRow(rating: selectedRating, size: 28, color: .white)

            Text("Your review helps us improve\nCampusHub for everyone on campus.")
                .font(.system(size: 15))
                .foregroundColor(Color(white: 0.5))
                .multilineTextAlignment(.center)
                .lineSpacing(4)

            Spacer()

            Button(action: {}) {
                Text("Back to App")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.white)
                    .cornerRadius(13)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
    }
}

struct StarRow: View {
    let rating: Int
    let size: CGFloat
    let color: Color

    var body: some View {
        HStack(spacing: 3) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .font(.system(size: size))
                    .foregroundColor(star <= rating ? color : Color(white: 0.25))
            }
        }
    }
}

#Preview {
    ReviewScreen()
}
