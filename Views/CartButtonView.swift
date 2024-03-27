//
//  CartButtonView.swift
//  SingheClothing
//
//  Created by Shehara Jayasooriya on 2024-03-25.
//

import SwiftUI

struct CartButtonView: View {
    @ObservedObject var cart: Cart

    var body: some View {
        NavigationLink(destination: CartView(cart: cart)) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart") // Replace with your cart icon
                    .resizable()
                    .frame(width: 24, height: 24)

                if cart.totalItems > 0 {
                    Text("\(cart.totalItems)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 10, y: -10)
                }
            }
        }
    }
}


