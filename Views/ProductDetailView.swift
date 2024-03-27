import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    
    init(product: ClothingItem, cart: Cart) {
            viewModel = ProductDetailViewModel(product: product, cart: cart)
        }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: viewModel.product.image)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 300)
                .cornerRadius(12)

                Text(viewModel.product.title)
                    .font(.title2)
                Text(viewModel.product.description)
                Text("Price: $\(viewModel.product.price, specifier: "%.2f")")
                    .font(.headline)

                if !viewModel.productVariants.isEmpty {
                    Picker("Size", selection: $viewModel.selectedSize) {
                        ForEach(viewModel.productVariants.map(\.size).removingDuplicates(), id: \.self) { size in
                            Text(size).tag(size as String)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: viewModel.selectedSize) { newSize in
                        viewModel.selectedSize = newSize
                        print("New size selected: \(newSize ?? "None")")
                    }

                    Picker("Color", selection: $viewModel.selectedColor) {
                        ForEach(viewModel.productVariants.map(\.color).removingDuplicates(), id: \.self) { color in
                            Text(color).tag(color as String?)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: viewModel.selectedColor) { newColor in
                        viewModel.selectedColor = newColor
                        print("New color selected: \(newColor ?? "None")")
                    }
                }

                Button("Add to Cart") {
                    print("Selected size before adding to cart: \(viewModel.selectedSize ?? "None")")
                    print("Selected color before adding to cart: \(viewModel.selectedColor ?? "None")")
                    viewModel.addProductToCart()
                }
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Helper extension to remove duplicates from an array
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
