// CartModel.swift
import Foundation
struct CartItem: Identifiable, Encodable {
    var id: UUID = UUID() // Default value provided
    var product: ClothingItem
    var size: String
    var quantity: Int
    var color: String
    
    // Other properties and methods...
    init(product: ClothingItem, size: String, quantity: Int, color: String) {
        self.id = UUID()
        self.product = product
        self.size = size
        self.quantity = quantity
        self.color = color
    }
    
    // Define coding keys if your JSON keys don't match the variable names exactly
    enum CodingKeys: String, CodingKey {
        case id
        case product // Make sure the JSON key for product details matches this key.
        case size
        case quantity
        case color
    }
    
}
class Cart: ObservableObject {
    @Published var items: [CartItem] = []
    
    
    var encodableItems: [EncodableCartItem] {
            items.map { EncodableCartItem(cartItem: $0) }
        }
    
    // Adds an item to the cart.
    func addToCart(item: CartItem) {
        if let index = items.firstIndex(where: { $0.product.id == item.product.id && $0.size == item.size && $0.color == item.color }) {
            items[index].quantity += 1
        } else {
            items.append(item)
        }
        print("Cart items after adding: \(items)")
    }
    
    // Removes an item from the cart by its UUID.
    func removeFromCart(itemId: UUID) {
        items.removeAll { $0.id == itemId }
    }
    
    // Increases the quantity of a specific item in the cart.
    func increaseQuantity(of item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        }
    }
    
    // Decreases the quantity of a specific item in the cart. If the quantity drops to 0, it removes the item from the cart.
    func decreaseQuantity(of item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                removeFromCart(itemId: item.id)
            }
        }
    }
    
    
    func clearCart() {
            items.removeAll()
        }
    
    // Computed property to get the total number of items in the cart.
    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    // Computed property to get the total price of all items in the cart.
    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
