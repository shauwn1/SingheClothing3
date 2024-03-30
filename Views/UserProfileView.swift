//user profile view


import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    let defaultImage = Image("defaultProfileImage") // Replace with your default image
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                defaultImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                Text("Full Name: \(user.fullname)")
                Text("Email: \(user.email)")
                Text("Mobile Number: \(user.mobilenumber)")
                // ... add more fields as needed
            } else {
                Text("User details not available")
            }
        }
        .onAppear {
            // Make sure to fetch user profile when the view appears
            viewModel.fetchUserProfile()
        }
        .navigationTitle("Profile")
    }
}

// Define your own preview provider as needed
struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(viewModel: UserProfileViewModel(apiService: ApiService(), userId: 1))
    }
}
