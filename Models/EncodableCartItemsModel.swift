//
//  EncodableCartItemsModel.swift
//  SingheClothing
//
//  Created by Dasun Pamuditha on 2024-03-30.
//

import Foundation
struct EncodableCartItem: Encodable {
    let productId: Int
    let size: String
    let color: String
    let quantity: Int
    
    init(cartItem: CartItem) {
        // Initialize properties using cartItem
        productId = cartItem.product.id
        size = cartItem.size
        color = cartItem.color
        quantity = cartItem.quantity
    }
}
