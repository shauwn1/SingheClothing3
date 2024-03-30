//
//  ProductDetailViewModel.swift
//  SingheClothing
//
//  Created by Dasun Pamuditha on 2024-03-27.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    @Published var product: ClothingItem
    @Published var productVariants: [ProductVariant] = []
    @Published var selectedSize: String?
    @Published var selectedColor: String?
    
    
    private let apiService = ApiService()
    var cart: Cart

    init(product: ClothingItem, cart: Cart) {
        self.product = product
        self.cart = cart
        self.loadProductVariants()
    }
    
    func loadProductVariants() {
        apiService.fetchProductVariants(forProductId: product.id) { [weak self] variants in
            DispatchQueue.main.async {
                print("Fetched variants: \(variants)")
                self?.productVariants = variants ?? []
                // Set the default selected size and color
                self?.selectedSize = self?.productVariants.first?.size
                self?.selectedColor = self?.productVariants.first?.color
                print("Initial selected size: \(self?.selectedSize ?? "None")")
                print("Initial selected color: \(self?.selectedColor ?? "None")")
            }
        }
    }
    
    func addProductToCart() {
        guard let size = selectedSize, let color = selectedColor else { return }
        print("Adding to cart with size: \(size) and color: \(color)")
        // Check if the variant with the selected size and color exists
        if let variant = productVariants.first(where: { $0.size == size && $0.color == color }) {
            let cartItem = CartItem(product: product, size: size, quantity: 1, color: color)
            cart.addToCart(item: cartItem)
        }
    }
    }

