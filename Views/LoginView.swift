import SwiftUI

struct LoginView: View {
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var shouldNavigateToHome = false
    @State private var shouldNavigateToSignup = false
    @StateObject private var cart = Cart()

    private var homeViewModel: HomeViewModel {
        HomeViewModel(cart: cart)
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)

                SecureField("Password", text: $password)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)

                Button("Login") {
                    authenticationViewModel.login(email: email, password: password)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5)

                if let errorMessage = authenticationViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                // Link to the signup page
                Button("Don't have an account? Sign up") {
                    shouldNavigateToSignup = true
                }
                .padding()
                .foregroundColor(.blue)

                NavigationLink(destination: SignupView(), isActive: $shouldNavigateToSignup) {
                    EmptyView()
                }

                NavigationLink(destination: HomeView(viewModel: homeViewModel), isActive: $shouldNavigateToHome) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
            .navigationTitle("Login")
            .onAppear {
                authenticationViewModel.onLoginSuccess = {
                    self.shouldNavigateToHome = true
                }
            }
        }
    }
}
