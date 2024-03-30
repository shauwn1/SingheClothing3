//
//  MenuView.swift
//  SingheClothing
//
//  Created by Dasun Pamuditha on 2024-03-30.
//

import SwiftUI

struct MenuView: View {
    @Binding var isShowing: Bool
    var categories: [String]
    var subCategories: [String: [String]]
    var selectCategory: (String) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(categories, id: \.self) { category in
                Text(category)
                    .padding()
                    .onTapGesture {
                        self.selectCategory(category)
                        self.isShowing.toggle()
                    }

                if let subcategories = subCategories[category], !subcategories.isEmpty {
                    ForEach(subcategories, id: \.self) { subCategory in
                        Text(subCategory)
                            .padding(.leading)
                            .onTapGesture {
                                self.selectCategory(subCategory)
                                self.isShowing.toggle()
                            }
                    }
                }
            }
        }
    }
}
