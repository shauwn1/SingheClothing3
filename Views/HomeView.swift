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
                                    viewModel.loadProductsForSubCategory(subCategory)
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
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Clothing Store")
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
