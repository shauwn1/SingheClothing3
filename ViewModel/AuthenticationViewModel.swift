import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var user: User?
    
    var onLoginSuccess: (() -> Void)?
    var onRegistrationSuccess: (() -> Void)?

    func login(email: String, password: String) {
        guard let url = URL(string: "http://localhost:3000/api/users/login") else {
            self.errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let credentials = ["email": email, "password": password]
        do {
            let jsonData = try JSONEncoder().encode(credentials)
            request.httpBody = jsonData
        } catch {
            self.errorMessage = "Error encoding credentials"
            return
        }

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                guard let self = self else { return }

                if let error = error {
                    self.errorMessage = "Login failed: \(error.localizedDescription)"
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200,
                      let data = data else {
                    self.errorMessage = "Login failed: Invalid credentials or server error"
                    return
                }

                do {
                    // Assuming your server's response contains the user details
                    let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                    self.user = response.user
                    self.isAuthenticated = true
                    self.errorMessage = nil
                    self.onLoginSuccess?()
                }
                catch let DecodingError.dataCorrupted(context) {
                   print(context)
               } catch let DecodingError.keyNotFound(key, context) {
                   print("Key '\(key)' not found:", context.debugDescription)
                   print("codingPath:", context.codingPath)
               } catch let DecodingError.valueNotFound(value, context) {
                   print("Value '\(value)' not found:", context.debugDescription)
               }
                catch {
                    self.errorMessage = "Failed to decode user details: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    
    func register(fullname: String, mobilenumber: String, email: String, password: String) {
            guard let url = URL(string: "http://localhost:3000/api/users/register") else {
                self.errorMessage = "Invalid URL"
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let newUser = RegistrationData(fullname: fullname, mobilenumber: mobilenumber, email: email, password: password)
        do {
                let jsonData = try JSONEncoder().encode(newUser)
                request.httpBody = jsonData
            } catch {
                self.errorMessage = "Error encoding credentials"
                return
            }
            
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        guard let self = self else { return }

                        if let error = error {
                            self.errorMessage = "Registration failed: \(error.localizedDescription)"
                            return
                        }

                        guard let httpResponse = response as? HTTPURLResponse else {
                            self.errorMessage = "Invalid response"
                            return
                        }

                        if httpResponse.statusCode == 201 {
                            self.isAuthenticated = true
                            self.errorMessage = nil
                            self.onRegistrationSuccess?() // Call this closure when registration is successful
                        } else {
                            self.errorMessage = "Registration failed: Invalid data or server error"
                        }
                    }
                }.resume()
            }
        
    
    
    
}
