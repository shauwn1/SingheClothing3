import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.categories, id: \.self) { category in
                    Section(header: Text(category)) {
                        if let subcategories = viewModel.subCategories[category], !subcategories.isEmpty {
                            ForEach(subcategories, id: \.self) { subCategory in
                                Button(action: {
                                    print(category)
                                    print(subCategory)
                                    
                                    viewModel.loadProductsForSubCategory(subCategory, forCategory: category)
                                    
                                }) {
                                    Text(subCategory)
                                }
                            }
                        } else {
                            Text("Loading subcategories...")
                                .onAppear {
                                    viewModel.loadSubCategories(forCategory: category)
                                }
                        }
                    }
                }
                
                Section(header: Text("Products")) {
                    ForEach(viewModel.clothingItems) { product in
                        NavigationLink(destination: ProductDetailView(product: product, cart: viewModel.cart)) {
                            ProductRow(product: product)
                        }
                    }
                }
                
                
            }
            .toolbar {
                            // Cart Button Toolbar Item
                            ToolbarItem(placement: .navigationBarTrailing) {
                                CartButtonView(cart: viewModel.cart)
                            }
                            // Sort Button Toolbar Item
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Menu {
                                    Button("Price Low to High") {
                                        viewModel.sortState = .priceLowToHigh
                                        viewModel.sortProducts()
                                    }
                                    Button("Price High to Low") {
                                        viewModel.sortState = .priceHighToLow
                                        viewModel.sortProducts()
                                    }
                                } label: {
                                    Label("Sort", systemImage: "arrow.up.arrow.down")
                                }
                            }
                        }
                    }
                }
            }
    


struct ProductRow: View {
    let product: ClothingItem
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 100, height: 100)
                case .failure:
                    Color.red // Indicates an error.
                default:
                    ProgressView() // Shows a loading indicator.
                }
            }
            .frame(width: 100, height: 100)
            .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text("\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel(cart: Cart())
        HomeView(viewModel: viewModel)
    }
}
