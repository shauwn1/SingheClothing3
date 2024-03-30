//
//  OrderItem'.swift
//  SingheClothing
//
//  Created by Dasun Pamuditha on 2024-03-30.
//

import Foundation
struct OrderItem: Encodable {
    let productId: Int
    let size: String
    let color: String
    let quantity: Int
}
