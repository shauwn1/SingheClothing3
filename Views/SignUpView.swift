import SwiftUI

struct SignupView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var mobileNumber = ""
    @State private var showRegistrationSuccess = false
    @State private var navigateToLogin = false

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Full Name", text: $fullName)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)

                TextField("Email", text: $email)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)

                SecureField("Password", text: $password)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)

                TextField("Mobile Number", text: $mobileNumber)
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)

                Button("Register") {
                    authenticationViewModel.register(fullname: fullName, mobilenumber: mobileNumber, email: email, password: password)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(5)

                if let errorMessage = authenticationViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                if showRegistrationSuccess {
                    Text("Registered successfully!")
                        .foregroundColor(.green)
                }

                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Sign Up")
            .onAppear {
                authenticationViewModel.onRegistrationSuccess = {
                    self.showRegistrationSuccess = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.navigateToLogin = true
                    }
                }
            }
        }
    }
}
