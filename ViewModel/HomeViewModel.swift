import Foundation

class HomeViewModel: ObservableObject {
    @Published var categories: [String] = []
    @Published var subCategories: [String: [String]] = [:]
    @Published var clothingItems: [ClothingItem] = []
    @Published var selectedCategory: String? {
        didSet {
            loadProductsForCategory()
        }
    }
    
    private let apiService = ApiService()
    var cart: Cart
       
    init(cart: Cart) {
        self.cart = cart
        loadCategories()
    }
    
    // Load main categories
    func loadCategories() {
        apiService.fetchCategories { [weak self] categories in
            self?.categories = categories ?? []
        }
    }
    
    // Load products for the selected main category
    func loadProductsForCategory() {
        guard let category = selectedCategory else { return }
        apiService.fetchProducts(forCategory: category) { [weak self] products in
            self?.clothingItems = products ?? []
        }
    }
    
    // Load subcategories for a given main category
    func loadSubCategories(forCategory category: String) {
        apiService.fetchSubCategories(forCategory: category) { [weak self] subCategories in
            DispatchQueue.main.async {
                self?.subCategories[category] = subCategories ?? []
                }
            }
        }
    
    
    // Load products for a given subcategory
    func loadProductsForSubCategory(_ subCategory: String) {
        apiService.fetchProducts(forCategory: subCategory) { [weak self] products in
            DispatchQueue.main.async {
                self?.clothingItems = products ?? []
            }
        }
    }
}

// Remember to implement `fetchSubCategories(forCategory:)` and `fetchProducts(forSubCategory:)` in `ApiService`.
