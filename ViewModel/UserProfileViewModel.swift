//
//  UserProfileViewModel.swift
//  SingheClothing
//
//  Created by Dasun Pamuditha on 2024-03-29.
//

// UserProfileViewModel.swift
import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var user: User?
    private let apiService: ApiService
    private let userId: Int

    init(apiService: ApiService, userId: Int) {
        self.apiService = apiService
        self.userId = userId
        fetchUserProfile()
    }

    func fetchUserProfile() {
        apiService.fetchUserProfile(userId: userId) { [weak self] user in
            DispatchQueue.main.async {
                self?.user = user
            }
        }
    }

    func updateUserProfile(updatedUser: User) {
        apiService.updateUserProfile(userId: userId, updatedUser: updatedUser) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.user = updatedUser
                    // Show a success message or update the UI as needed
                } else {
                    // Handle update failure
                }
            }
        }
    }
}

