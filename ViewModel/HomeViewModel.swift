//homeviewmodel.swift



import Foundation

class HomeViewModel: ObservableObject {
    @Published var allProducts: [ClothingItem] = []
    @Published var filteredProducts: [String: [ClothingItem]] = [:]
    @Published var selectedSubCategory: String?
    @Published var categories: [String] = []
    @Published var subCategories: [String: [String]] = [:]
    @Published var clothingItems: [ClothingItem] = []
    @Published var selectedCategory: String? {
        didSet {
            print("Selected category: \(selectedCategory ?? "None")")
            loadProductsForCategory()
        }
    }
    // Initialize or reset the products view to show all products
    init(cart: Cart) {
        self.cart = cart
        loadCategories()
        loadAllProducts() // Call this to load all products initially
    }
    
    
    private let apiService = ApiService()
    var cart: Cart
    
    
    
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
                print("GGGG")
                self?.subCategories[category] = subCategories ?? []
            }
        }
    }
    
    
    // Load products for a given subcategory
    // Modify this method in your HomeViewModel to accept the category
    func loadProductsForSubCategory(_ subCategory: String, forCategory category: String) {
        print("haha")
        print(subCategory)
        apiService.fetchProducts(forCategory: category, subCategory: subCategory) { [weak self] products in
            DispatchQueue.main.async {
                self?.clothingItems = products ?? []
            }
        }
    }
    
    
    
    // Add a method to fetch all products regardless of category or subcategory
    func loadAllProducts() {
        apiService.fetchAllProducts { [weak self] products in
            DispatchQueue.main.async {
                self?.allProducts = products ?? []
                self?.clothingItems = self?.allProducts ?? [] // Update clothingItems
            }
        }
    }
    
    
    enum SortState {
            case none, priceLowToHigh, priceHighToLow
        }

        // Add a published variable for the sort state
        @Published var sortState: SortState = .none

        // Call this method to sort the clothing items based on the current sort state
        func sortProducts() {
            switch sortState {
            case .priceLowToHigh:
                clothingItems.sort(by: { $0.price < $1.price })
            case .priceHighToLow:
                clothingItems.sort(by: { $0.price > $1.price })
            case .none:
                break // No sorting, you could implement to reset to default state if needed
            }
        }
    
}
