import SwiftUI

struct CategoryView: View {
    @Binding var expandedCategory: String?
    let category: String
    let subCategories: [String]
    var loadProductsForSubCategory: (String, String) -> Void

        var body: some View {
            DisclosureGroup(
                isExpanded: Binding(
                    get: { self.expandedCategory == self.category },
                    set: { isExpanded in
                        if isExpanded {
                            self.expandedCategory = self.category
                        } else if self.expandedCategory == self.category {
                            self.expandedCategory = nil
                        }
                    }
                )
            ) {
                ForEach(subCategories, id: \.self) { subCategory in
                    Button(action: {
                        self.loadProductsForSubCategory(subCategory, self.category)
                    }) {
                        Text(subCategory)
                            .padding(.leading)
                    }
                }
            } label: {
                Text(category)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }
