//
//  OrderDetailsModel.swift
//  SingheClothing
//
//  Created by Dasun Pamuditha on 2024-03-30.
//

import Foundation
struct OrderDetails: Encodable {
    let userId: Int
    let items: [OrderItem]
}
