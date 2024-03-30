//
//  SingheClothingApp.swift
//  SingheClothing
//
//  Created by Shehara Jayasooriya on 2024-03-24.
//

import SwiftUI

@main
struct SingheClothingApp: App {
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    var body: some Scene {
        WindowGroup {
                    LoginView()
                .environmentObject(authenticationViewModel)
                }
    }
}
