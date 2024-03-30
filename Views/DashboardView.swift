//
//  DashboardView.swift
//  SingheClothing
//
//  Created by Dasun Pamuditha on 2024-03-30.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @StateObject private var cart = Cart()
    @ObservedObject var authViewModel: AuthenticationViewModel // Make sure to have the environment object set up
    @StateObject var userProfileViewModel = UserProfileViewModel(apiService: ApiService(), userId: 0)
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(cart: Cart()))
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            CartView(cart: cart)
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
            
            if authViewModel.isAuthenticated, let user = authViewModel.user {
                UserProfileView(viewModel: UserProfileViewModel(apiService: ApiService(), userId: user.id))
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                    }
            }
        }
        .onAppear {
            if let userID = authViewModel.user?.id {
                UserProfileView(viewModel: UserProfileViewModel(apiService: ApiService(), userId: authViewModel.user?.id ?? 1))
            }
        }
    }}



