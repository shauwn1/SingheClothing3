////
////  ContentView.swift
////  SingheClothing
////
////  Created by Shehara Jayasooriya on 2024-03-24.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        TabView {
//            HomeView(viewModel: HomeViewModel(cart: Cart()))
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }
//            
//            CartView(cart: Cart())
//                .tabItem {
//                    Label("Cart", systemImage: "cart.fill")
//                }
//            
//            if authViewModel.isAuthenticated, let user = authViewModel.user {
//                            UserProfileView(viewModel: UserProfileViewModel(apiService: ApiService(), userId: user.id))
//                                .tabItem {
//                                    Label("Profile", systemImage: "person.fill")
//                                }
//                        }
//                    }
//                    .onAppear {
//                        if let userID = authViewModel.user?.id {
//                            userProfileViewModel = UserProfileViewModel(apiService: ApiService(), userId: userID)
//                            userProfileViewModel.fetchUserProfile()
//                        }
//                    }
//                }
//            }
