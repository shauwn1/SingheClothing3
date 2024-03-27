//
//  ClothingModel.swift
//  SingheClothing
//
//  Created by Shehara Jayasooriya on 2024-03-24.
//

import Foundation
struct ClothingItem: Identifiable, Decodable {
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var sub_category: String
    var image: String
  //  var rate: Double
//    var count: Int
}
