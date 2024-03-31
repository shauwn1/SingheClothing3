//user profile view


import SwiftUI

struct UserProfileView: View {
    @ObservedObject var viewModel: UserProfileViewModel
    @EnvironmentObject var v: AuthenticationViewModel
    
    var body: some View {
        VStack {
            if let user = v.user {
                Text("Full Name: \(user.fullname)")
                Text("Email: \(user.email)")
                Text("Mobile Number: \(user.mobilenumber)")
            } else {
                ProgressView("Loading...")
            }
        }
        .onAppear {
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
