//
//  OrderModel.swift
//  SingheClothing
//
//  Created by Dasun Pamuditha on 2024-03-31.
//

import Foundation
struct Order: Identifiable, Decodable {
    var id: Int
    var date: String
    var quantity: Int
    var size: String
    var color: String
    var title: String
    var price: Double
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "order_id"
        case date = "order_date"
        case quantity
        case size
        case color
        case title
        case price
        case image
    }
}
